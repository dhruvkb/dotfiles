#!/usr/bin/env zx

// Determine and record the desk UUID so that it can be controlled.

import { print, linkFile } from '../utils/utils.mjs'

print('Determining desk ID...', { newLine: false })
const proc = await $`/opt/uv/bin/linak-controller --scan | grep "Desk " | awk -F':' '{print $1}'`
const deskId = proc.stdout.trim()
print(chalk.green('done.'))

print('Recording desk UUID...', { newLine: false })
$`echo "DESK_UUID='${deskId}'" > ~/dotfiles/raycast/scripts/desk.local.sh`
print(chalk.green('done.'))
