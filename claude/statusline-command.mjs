$.verbose = false;

/* Helpers
 * ======= */

/**
 * Wrap text in white square brackets.
 *
 * @param {string} text the text to wrap
 * @returns {string} the wrapped text
 */
function wrap(text) {
	return chalk.white("[") + text + chalk.white("]");
}

/**
 * Compute approximate rendered width of a styled string by stripping ANSI
 * escape sequences and counting code points. Assumes every glyph (including
 * Nerd Font icons) renders at one column.
 *
 * @param {string} text styled text containing ANSI escape sequences
 * @returns {number} approximate column width
 */
function visibleWidth(text) {
	return [...text.replace(/\x1b\[[0-9;]*m/g, "")].length;
}

/**
 * Format a duration in milliseconds as a compact human-readable string.
 *
 * @param {number} ms duration in milliseconds
 * @returns {string} the formatted duration
 */
function humanDuration(ms) {
	const totalSec = Math.max(0, Math.floor(ms / 1000));
	const d = Math.floor(totalSec / 86400);
	const h = Math.floor((totalSec % 86400) / 3600);
	const m = Math.floor((totalSec % 3600) / 60);
	const s = totalSec % 60;
	if (d > 0) return `${d}d ${h}h`;
	if (h > 0) return `${h}h ${m}m`;
	if (m > 0) return `${m}m ${s}s`;
	return `${s}s`;
}

/**
 * Build a colored "icon value" segment, or null if value is nullish so the
 * caller can filter it out.
 *
 * @param {*} value the value to display
 * @param {string} icon the icon glyph to prefix
 * @param {Function} color a chalk style function
 * @param {Function} [format=String] formatter applied to value
 * @returns {string|null} the styled segment or null
 */
function segment(value, icon, color, format = String) {
	if (value == null) return null;
	return color(`${icon} ${format(value)}`);
}

/**
 * Run a Git subcommand against `cwd`, returning trimmed stdout or null on
 * failure (e.g. the directory is not a Git repo).
 *
 * @param {string} cwd the working directory to run Git in
 * @param {string} subcommand the Git subcommand to invoke
 * @returns {Promise<string|null>} the trimmed output or null
 */
async function git(cwd, subcommand) {
	try {
		const { stdout } = await $({
			env: { ...process.env, GIT_OPTIONAL_LOCKS: "0" },
		})`git -C ${cwd} ${subcommand}`;
		return stdout.trim() || null;
	} catch {
		return null;
	}
}

/* Input
 * ===== */

// Claude Code provides input data as JSON via STDIN.
const input = JSON.parse(await stdin());
const cwd = input.workspace.current_dir;

/* Working directory + Git
 * ======================= */

const [gitBranch, gitRoot] = await Promise.all([git(cwd, "curr"), git(cwd, "root")]);

let repoRootName;
if (gitRoot) {
	repoRootName = gitRoot.split("/").at(-1);
} else {
	const home = os.homedir();
	repoRootName = cwd.startsWith(home) ? "~" + cwd.slice(home.length) : cwd;
}

/* Left segments
 * ============= */

const nfGitBranchIcon = "\u{F418}"; // nf-oct-git_branch
const nfTimerIcon = "\u{DB81}\u{DD1B}"; // nf-md-timer_outline

const leftSegments = [
	segment(gitBranch, nfGitBranchIcon, chalk.magenta.bold),
	segment(input.cost.total_duration_ms, nfTimerIcon, chalk.blue.bold, humanDuration),
];

/* Right segments
 * ============== */

const nfWeightLifterIcon = "\u{DB84}\u{DD5D}"; // nf-md-weight_lifter
const nfScrollIcon = "\u{EF0D}"; // nf-fa-scroll
const nfClockIcon = "\u{F017}"; // nf-fa-clock
const nfDollarIcon = "\u{F155}"; // nf-fa-dollar

const pct = (p) => `${Math.round(p)}%`;

const rightSegments = [
	segment(input.effort.level, nfWeightLifterIcon, chalk.red.bold),
	segment(input.context_window.used_percentage, nfScrollIcon, chalk.cyan.bold, pct),
	segment(input.rate_limits?.five_hour?.used_percentage, nfClockIcon, chalk.magenta.bold, pct),
	segment(input.rate_limits?.seven_day?.used_percentage, nfClockIcon, chalk.magenta.bold, pct),
	segment(input.cost.total_cost_usd, nfDollarIcon, chalk.green.bold, (c) => c.toFixed(2)),
];

/* Status
 * ====== */

const leftParts = [chalk.cyan.bold(repoRootName), ...leftSegments.filter(Boolean).map(wrap)];
const rightParts = [
	chalk.yellow.bold(input.model.display_name ?? ""),
	...rightSegments.filter(Boolean).map(wrap),
];
const left = leftParts.join(" ");
const right = rightParts.join(" ");

// Pad the middle so the right side aligns with the terminal's right edge.
// `correctionFactor` compensates for Claude's default horizontal insets.
const columns = parseInt(process.env.COLUMNS, 10) || 80;
const correctionFactor = 3;
const padCount = Math.max(1, columns - visibleWidth(left) - visibleWidth(right) - correctionFactor);
process.stdout.write(`${left}${" ".repeat(padCount)}${right}`);
