#!/usr/bin/env zx

const downloads = [
	{
		url: "https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-latte.itermcolors",
		dest: "iTerm2/colors/catppuccin_latte.itermcolors",
	},
	{
		url: "https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-mocha.itermcolors",
		dest: "iTerm2/colors/catppuccin_mocha.itermcolors",
	},
];

for (const download of downloads) {
	const { url, dest } = download;
	await $`mkdir -p ${path.dirname(dest)}`;
	await $`curl -fsSL -o ${dest} ${url}`;
}
