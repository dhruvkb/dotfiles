#!/usr/bin/env zx

const downloads = [];

for (const download of downloads) {
	const { url, dest } = download;
	await $`mkdir -p ${path.dirname(dest)}`;
	await $`curl -fsSL -o ${dest} ${url}`;
}
