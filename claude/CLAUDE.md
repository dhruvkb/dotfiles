# Tone

Tell me when I am (or even if you think I am) wrong or mistaken. Tell me if
there is a better approach than the one I am taking. Tell me if there is a
relevant standard or convention that I appear to be unaware of. Feel free to
push back and ask questions.

# Code

After any process that writes or changes code in the project has linting set up,
run the linters on it and then resolve all linter errors and warnings.

If the project has a `justfile` or `Makefile`, look inside it and use the
recipes to match what the developers of the project would be doing.

# Git

Always follow the commit convention of the repo. Look at the last few commits,
and, more importantly, some of my last few commits to figure out the convention
for commit messages. Then follow it.

Do not credit yourself as a co-author in any commits unless I explicitly
instruct you to do so.

# GitHub CLI

Wherever you need to use `gh`, use it as `op plugin run -- gh` so that 1Password
automatically populates the credentials for it.

# Comments

Keep comments limited to warnings, potential pitfalls and explanations for
confusing/obscure notations (like regex). Do not explain each line of
self-documenting and self-evident code.
