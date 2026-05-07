# Utilities Catalog

## How To Read This File

`bin/` is the largest surface area in the repository. This catalog groups the top-level executables by role so the directory is searchable by intent.

Descriptions are based on script names and the surrounding repository structure unless the behavior was directly confirmed from code.

## Core Dotfiles Commands

- `dotfiles`: main CLI wrapper for install, update, and config editing
- `dotfiles-report`: reporting helper for the dotfiles environment
- `dotfiles-timestamp`: timestamp helper for installs or maintenance operations
- `dotfiles-update`: opinionated repo update and reinstall workflow
- `custom-env-resolve`: resolves logical config paths to environment-specific files
- `update`: generic update entrypoint or umbrella updater

## Git And Repository Helpers

- `git-browse`: open repository or remote pages from Git context
- `git-create-github`: create or initialize GitHub remotes or repositories
- `git-create-gitlab`: create or initialize GitLab remotes or repositories
- `git-flow`: wrapper around git-flow style operations
- `git-review`: review-oriented Git helper
- `git-worktree-create`: create a new Git worktree
- `git-worktree-path`: print or compute worktree paths
- `gitdiff`: streamlined diff helper

## File, Path, And Archive Utilities

- `bak`: backup helper
- `compress`: archive or compress files
- `extract`: extract compressed archives
- `ln-safe`: safe symlink helper used by the installer
- `pathtouri`: convert local paths to URIs
- `recursive-move`: move directory contents recursively
- `singlequote`: shell quoting helper
- `temp_paths`: temporary path management helper
- `toxlsx`: convert tabular data into spreadsheet output
- `validate_json`: JSON validation helper
- `json_prettify`: pretty-print JSON
- `pretty-print-tsv`: format TSV data
- `pipe`: generic piping helper
- `jq`: bundled jq wrapper or executable copy

## Shell, Terminal, And Session Helpers

- `load_ssh_agent`: initialize or reuse an SSH agent
- `run-as-cron`: run a command under cron-like environment constraints
- `scratch`: generic scratch entrypoint
- `scratch.bash`: launch a Bash scratch context
- `scratch.js`: launch a JavaScript scratch context
- `scratch.py`: launch a Python scratch context
- `scratch.pyclick`: Python scratch helper with click-style scaffolding
- `scratch.zsh`: launch a Zsh scratch context
- `subl`: open files in Sublime Text
- `tmux-attach`: attach to tmux sessions
- `tmux-open`: open files or paths inside tmux workflows
- `vim-server`: editor helper for Vim server support
- `vims`: Vim-related helper collection entrypoint

## Completion, Tmux, And Support Directories

- `completion/`: shell completion scripts for repo commands and helpers
- `cronjobs/`: scheduled jobs intended to run from cron
- `deprecated/`: retired or legacy utilities retained for reference
- `lib/`: shared shell helpers used across multiple scripts
- `scratch-templates/`: templates consumed by scratch helpers
- `sinppets/`: snippet store; likely a misspelled but intentionally kept directory name
- `tmux/`: tmux support files or templates

## Notifications And Messaging

- `send-notification`: generic local notification wrapper
- `send-notification-email`: email delivery backend
- `send-notification-telegram`: Telegram delivery backend
- `mic-trigger`: microphone-triggered notification or automation helper
- `ring`: available through `cronjobs/`, but part of the same alerting theme

## Networking, Connectivity, And Remote Access

- `myip`: print primary public or local IP
- `myips`: print multiple IP addresses
- `open-url`: open URLs with local system integration
- `sync-ssh`: synchronize data over SSH
- `transfer`: transfer files or payloads to another host or service
- `vpnconnect`: VPN connection helper
- `wifi-check`: Wi-Fi health or connectivity check
- `pingmon`: ping-based monitoring helper
- `windows_explorer`: interop helper for opening paths in Windows Explorer

## Power, Hardware, And Display

- `battery`: battery status helper
- `battery-check`: battery threshold or health check
- `center-cursor`: UI helper to reposition the pointer
- `charging`: charging-state helper
- `invert-colors`: display inversion helper
- `mirror-display`: display mirroring helper
- `screenshot`: screenshot entrypoint
- `screenshot-nicename`: screenshot helper with friendly filenames
- `set-display-resolution`: display resolution setter
- `_screenshot_gnome`: GNOME screenshot backend
- `_screenshot_scrot`: `scrot` screenshot backend

## Media And Playback

- `cmus-server`: cmus integration helper
- `extract-album-art`: extract album art from media files
- `extract-album-art-spotify`: Spotify-specific album art extraction helper
- `generate-m3u-playlist`: generate M3U playlists
- `mp4tomp3`: convert MP4 media to MP3
- `open-in-youtube`: open matching content in YouTube
- `play-videos`: playback helper for video collections
- `playerctl`: media player control wrapper
- `playmusic`: music playback helper
- `pmv`: likely media playback shortcut or wrapper
- `videos-duration`: calculate video durations
- `youtube-dl-playlist`: download or manage YouTube playlists
- `youtube-dl-watch-later`: download or manage watch-later queues

## Documents And Text Processing

- `manpdf`: render or export man pages to PDF
- `mdtopdf`: convert Markdown to PDF
- `pdf-page-count`: print page counts for PDFs
- `my-urlencode`: URL encoding helper
- `qr-gen`: QR code generator

## Security And Credentials

- `gpg-decrypt`: decrypt with GPG
- `gpg-encrypt`: encrypt with GPG
- `kp`: likely secret-store or KeePass-oriented helper

## Filesystems, Mounts, And Sync

- `drive-go`: drive or mount navigation helper
- `mountazstorage`: mount Azure storage or similarly named remote storage
- `ok-to-download`: preflight or policy helper for downloads
- `sync-emergency`: emergency sync routine
- `syncf`: file synchronization helper
- `updatedrive`: update or sync mounted drive state

## Developer And Data Utilities

- `clipboard`: clipboard helper
- `coursera-download`: download helper for Coursera content
- `firefoxtagsappend`: append or manage Firefox tag metadata
- `ipython`: launch or wrap IPython
- `marks`: marks/bookmark helper
- `matlab`: MATLAB wrapper
- `open-url`: browser-launch helper useful in developer workflows too
- `pcp`: project-specific utility, likely paired with `pcp-check`
- `pcp-check`: validation or status command for `pcp`
- `reset-jetbrains-evaluation`: resets local JetBrains evaluation state
- `swapescape`: keyboard remap helper
- `testnet`: test network utility
- `twitter`: Twitter helper
- `twitterfav`: Twitter favorite/bookmark helper
- `update-marks`: refresh marks data
- `update-ranger-temp-paths`: refresh ranger temp path state
- `updategem`: RubyGems updater helper
- `updatepip`: Python package updater helper

## Ranger And Temp-Path Helpers

- `tp_generate_ranger_cd_command`: generate ranger-compatible directory switch commands
- `tp_get`: get a stored temp path value
- `tp_set`: set a stored temp path value

The completion directory also suggests related commands such as `tp_cd`, `tp_remove`, `tp_list`, `tp_set_value`, `tpcd`, `tpg`, `tps`, `tpsv`, and `tpr`, which indicates an internal family of path/bookmark utilities.

## Internal Or Underscore-Prefixed Helpers

- `_extract_zsh`: Zsh completion or extraction helper used internally

## Notes On Ambiguous Commands

Some utilities are clearly personal shorthand and are best understood by reading the script before changing them. Notable examples include:

- `kp`
- `pcp`
- `pmv`
- `testnet`
- `drive-go`

Those commands are documented here for discoverability, but not all of them expose enough naming context to describe exact behavior without a deeper script-by-script audit.
