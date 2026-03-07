# Overview

A collection of modular bash configuration snippets for enhanced shell
productivity. Each snippet is a self-contained file that adds specific
functionality to your bash environment.

# Features

- **Modular design**: Each script handles one specific task or feature
- **Easy to customize**: Simply prefix unwanted scripts with
  `_`{.verbatim} to disable them
- **Well-documented**: All scripts now include comprehensive inline
  comments
- **No dependencies between most scripts**: Pick and choose what you
  need
- **Organized by number**: Scripts load in a predictable order (00-99)

# Usage

## Prerequisites

To use `atuin`{.verbatim} (`21-atuin`{.verbatim}) install
[ble.sh](https://github.com/akinomyoga/ble.sh) and
[atuin](https://docs.atuin.sh/cli/guide/installation/).

## Installation

1.  Clone the repository to `.bashrc.d`{.verbatim} in your Home
    directory:

    ``` bash
    git clone <repository-url> ~/.bashrc.d
    ```

2.  Add the following to your `.bashrc`{.verbatim} to source all
    numbered scripts:

    ``` bash
    [[ -d ~/.bashrc.d ]] && for f in ~/.bashrc.d/[0-9][0-9]-* ; do . ${f} ; done 
    ```

3.  Restart your shell or run `source ~/.bashrc`{.verbatim} to apply
    changes.

## Customization

To exclude certain snippets, add an underscore (`_`) at the beginning of
the filename. For example, to disable the weather function:

``` bash
mv ~/.bashrc.d/09-curl ~/.bashrc.d/_09-curl
```

## Privacy Note

I use `90-obscureIPv6Prefix`{.verbatim} to hide my IPv6 prefix when
sharing terminal output online. If you don\'t want this feature, you
can:

- Disable it by renaming:
  `mv 90-obscureIPv6Prefix _90-obscureIPv6Prefix`{.verbatim}
- Or remove all occurrences of `| obscureIPv6`{.verbatim} in
  `91-ip`{.verbatim} and `90-obscureIPv6Prefix`{.verbatim}

# Quick Reference

Here\'s a summary of the most useful functions and aliases:

  Command/Function                                                     Description                               Example
  -------------------------------------------------------------------- ----------------------------------------- ---------------------------------------------------
  `=`                                                                  Calculator with European number format    `=` \"12,5 · 3\"
  `=x`                                                                 Convert decimal to hex                    `=x 255`
  `=b`                                                                 Convert decimal to binary                 `=b 13`
  `gS`{.verbatim}, `gC`{.verbatim}, `gP`{.verbatim}, `gF`{.verbatim}   Git shortcuts (status/commit/push/pull)   `gC "Fix bug"`{.verbatim}
  `ipbrief`{.verbatim}                                                 Colorized, formatted network info         `ipbrief a`{.verbatim}
  `wetter`{.verbatim}                                                  Get weather for location                  `wetter Berlin`{.verbatim}
  `mkcd`{.verbatim}                                                    Create directory and cd into it           `mkcd newdir`{.verbatim}
  `please`{.verbatim} / `bitte`{.verbatim}                             Polite sudo                               `please dnf update`{.verbatim}
  `lout`{.verbatim} / `?`{.verbatim}                                   Bookmark command output                   `ls \vert lout`{.verbatim}, then `? 5`{.verbatim}
  `grepln`{.verbatim} / `emacsln`{.verbatim}                           Find & open file at pattern               `emacsln "TODO" file.txt`{.verbatim}
  `Anwesenheit`{.verbatim}                                             Process Teams attendance CSV              `Anwesenheit meeting.csv`{.verbatim}
  `KiB`{.verbatim}, `MiB`{.verbatim}, `GiB`{.verbatim}                 Convert IEC units to bytes                `GiB 5`{.verbatim}
  `tesed`{.verbatim}                                                   Test sed changes interactively            `tesed 's/old/new/g' file`{.verbatim}

# Available snippets

Scripts are now organized into logical groups:

- **00-09**: Core shell configuration (colors, options, PATH, prompt)
- **10-19**: Language-specific PATH setup (Rust, Perl, Python, TeX)
- **20-29**: Terminal integration and tools (Eat, Atuin, tmux, editor)
- **30-39**: Aliases and shortcuts
- **40-49**: Directory and file operations
- **50-59**: Shell functions and utilities
- **60-69**: Calculation and conversion tools
- **70-79**: Text and data processing
- **80-89**: Application-specific tools
- **90-99**: Network and privacy tools

## 00-colors --- ANSI color variables (prompt-safe + raw)

Defines prompt-escaped and raw colors; also enriches `awk`{.verbatim}
with colors and tabular OFS.

``` bash
  export RAW_R="\033[31m"
  export G="\[\033[32m\]"
  export Y="\[\033[33m\]"
  export B="\[\033[34m\]"
  export M="\[\033[35m\]"
  export C="\[\033[36m\]"
  export N="\[\033[0m\]"
  export RAW_G="\033[32m"
  export RAW_Y="\033[33m"
  export RAW_B="\033[34m"
  export RAW_M="\033[35m"
  export RAW_C="\033[36m"
  export RAW_N="\033[0m"

alias awk='awk -v r=$RAW_R -v g=$RAW_G -v y=$RAW_Y -v b=$RAW_B -v m=$RAW_M -v c=$RAW_C -v n=$RAW_N -v OFS="\t"'
```

## 01-options --- Safer shell defaults

`noclobber`{.verbatim} for redirections; enable `autocd`{.verbatim} and
`cdspell`{.verbatim}.

``` bash
set -C
shopt -s autocd
shopt -s cdspell
```

## 02-PATH --- Local user bin first

Ensure `~/.local/bin`{.verbatim} precedes system paths.

``` bash
export PATH=${HOME}/.local/bin:${PATH}
```

## 03-PS1 --- Minimal Git-aware, status-colored prompt

Shows ✔/✘ based on last exit code and current Git branch (with \* if
dirty). Uses color vars from `00-colors`{.verbatim}.

## 10-cargo --- Rust toolchain path

``` bash
export PATH=/home/sebastian/.cargo/bin:${PATH}
```

## 11-perl --- Local::lib environment

Per-user Perl install locations.

``` bash
PATH="/home/sebastian/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/sebastian/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/sebastian/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/sebastian/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/sebastian/perl5"; export PERL_MM_OPT;
```

## 12-python --- pyenv paths

Prefer user Python tools.

``` bash
PATH=${HOME}/.pyenv/bin/:~/.pyenv/versions/3.13.1/bin/:${PATH}
```

## 13-tex --- Local TEXMF

``` bash
export TEXMFHOME=${HOME}/Dropbox/TeX/texmf
```

## 20-eat --- EAT shell integration (if available)

``` bash
[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && source "$EAT_SHELL_INTEGRATION_DIR/bash"
```

## 21-atuin --- Shell history tool

Improved shell history with sync and search capabilities.

## 22-tmux.completion.bash --- tmux bash completion

Drop-in tmux completion script (clients/sessions/windows).

## 23-editor --- Default editor

``` bash
EDITOR=nvim
```

## 24-fontpreview --- UI tuning

Environment for `fontpreview`{.verbatim} (size, position, prompt, text).

``` bash
export FONTPREVIEW_SEARCH_PROMPT="❯ "
export FONTPREVIEW_SIZE=532x365
export FONTPREVIEW_POSITION="+532+365"
export FONTPREVIEW_FONT_SIZE=38
export FONTPREVIEW_BG_COLOR="#ffffff"
export FONTPREVIEW_FG_COLOR="#000000"
export FONTPREVIEW_PREVIEW_TEXT="ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nÄÖßẞ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n!@$%(){}[]"
```

## 30-alias --- Quality-of-life aliases

File/basics + Git helpers.

``` bash
  alias ßh=shh
  alias ß=ss

alias awk='awk -v OFS=" " '
alias pdfbook='pdfbook2 -spa4paper'
alias vim=nvim
alias suvi='sudo nvim'
alias gS='git status'
alias gC='git add -A && git commit -am'
alias gP='git push'
alias gF='git pull --rebase'

alias lsda='find . -maxdepth 1 -type d'
alias lsd="lsda -not -regex '^./..*'"
```

## 31-sudo~functions~ --- Polite sudo :)

``` bash
function please { echo "You're welcome!"; echo; sudo $@;}
function bitte  { echo "Gerne!"; echo; sudo $@;}
```

## 32-cdpath --- Faster `cd`{.verbatim} across common roots

``` bash
export CDPATH=.:~:~/git:/etc:~/Dokumente:~/Documents
```

## 40-mkcd --- Make and enter directory

``` bash
function mkcd () { mkdir $@; cd $_; }
```

## 50-man --- Search-in-`less`{.verbatim} man wrapper

Supports optional section and initial search (`less -p`{.verbatim}).

``` example
man 2 open O_CLOEXEC     # open section 2 and search for O_CLOEXEC
```

## 51-grepln --- Jump to first match in file

Find line number of first match and open in Emacs there.

``` bash
function grepln () {
PATTERN=$1
FILE=$2
grep -n -E "$PATTERN" "$FILE"  | head -1 | awk -F: '{print $1}'
}
function emacsln () {
PATTERN=$1
FILE=$2
emacsclient -nc +$(grepln "$PATTERN" "$FILE") "$FILE"
}
```

## 52-here --- Inline Python scratchpad

Replace `helper.py`{.verbatim} and execute it from a here-doc.

``` bash
alias pyhere='mv helper.py helper.py~; cat << . > helper.py && python3 helper.py'
```

## 53-lastout --- Bookmark and recall command output

Pipe any output through `lout`{.verbatim} to number & cache it; recall a
line via `? N`{.verbatim}.

``` bash
function lout () { tee ~/.lastout | nl; }
function ? () { awk -v LINE=$1 'NR==LINE {print $0}' ~/.lastout; }
```

``` example
ls -l /usr/bin | lout
? 2
```

## 54-sed-test --- Interactive sed tester

Preview sed changes before applying.

``` example
tesed 's/old/new/g' myfile.txt
```

## 60-calc --- Shell calculator (`, =x`{.verbatim}, `b`{.verbatim}, ...)

Convenient bc-based calculator with locale-friendly input/output and
base conversions.

``` example
= "12,5 · 3"          # -> 37,50
=x 255               # -> FF
=b 13                # -> 1101
=bx "1111 0000 1010"   # -> F0 0A
```

## 61-units.sh --- IEC size helpers

Convert KiB/MiB/GiB/TiB/PiB to raw bytes using `bc`{.verbatim}.

``` bash
function KiB() { bytes=$1; printf "%s B\n" $(echo "$1 * 2^10" | bc); }
function MiB() { bytes=$1; printf "%s B\n" $(echo "$1 * 2^20" | bc); }
function GiB() { bytes=$1; printf "%s B\n" $(echo "$1 * 2^30" | bc); }
function TiB() { bytes=$1; printf "%s B\n" $(echo "$1 * 2^40" | bc); }
function PiB() { bytes=$1; printf "%s B\n" $(echo "$1 * 2^50" | bc); }
```

## 70-AnwesenheitTeams --- Attendance cleanup (Teams)

Normalize/export meeting attendance lists (CSV from Teams).

``` bash
function Anwesenheit () {
file=${1:-"meetingAttendanceList.csv"}
iconv -f UTF-16LE -t UTF-8  ${file} |
awk '/Meisel|Anwesenheit/{next}; NR>1 {print $0}' |
sort -k1,2 -u | column -ts,
}
```

## 71-lpr --- Even/odd print helpers

Targets printer \"EPSON ET-2820\".

``` bash
alias lpodd='lpr -o page-set=odd -P EPSON_ET_2820_Series'
alias lpeven='lpr -o page-set=even -P EPSON_ET_2820_Series'
```

## 80-curl --- Quick weather via wttr.in

Simple helper for terminal weather (defaults to Mölschow).

``` bash
function wetter () {
local PLACE=${1:-"Mölschow"}
curl https:/wttr.in/${PLACE}
}
```

## 81-ntfy --- Tiny notify helper

POST a message to an ntfy endpoint (here: `ln1/tea`{.verbatim}).

``` bash
function ntfy () {
curl -d "$@" ln1/tea
}
```

## 82-update --- Distro-aware updater (+notify)

Try `zypper`{.verbatim}, then `dnf`{.verbatim}, then `apt`{.verbatim};
sends `ntfy`{.verbatim} on success/failure.

``` bash
#!/bin/bash
update () {
if ( sudo test -x /bin/zypper )
then
sudo zypper dup -y && ntfy "Update auf $HOSTNAME erfolgreich!" || "Update auf $HOSTNAME fehlgeschlagen"
elif ( sudo test -x /bin/dnf )
then
sudo dnf update -y && ntfy "Update auf $HOSTNAME erfolgreich!" || "Update auf $HOSTNAME fehlgeschlagen"
elif ( sudo test -x /bin/apt )
then
sudo apt update && sudo apt upgrade -y && ntfy "Update auf $HOSTNAME erfolgreich!" || "Update auf $HOSTNAME fehlgeschlagen"
fi
}
```

## 83-yt-dlp --- Run via pipenv

``` bash
alias yt-dlp='pipenv run yt-dlp'
```

## 84-distrobox --- Enter Arch distrobox (root)

``` bash
alias arch='distrobox enter --root arch'
```

## 90-obscureIPv6Prefix --- IPv6 prefix masking & helpers

Small helpers to keep public outputs private by masking your global IPv6
prefix; includes wrappers for `tracepath`{.verbatim} and
`ip`{.verbatim}.

``` example

# Example

$ tracepath 2a01:a380:4400:15::1 # -> replaces 2a01:a380 with 3fff:abc: 
$ ip a                       # -> colors + privacy masking
```

## 91-ip --- Pretty `ip`{.verbatim} / `ping`{.verbatim} wrappers (with privacy)

Colorizes `ip --brief`{.verbatim}, aligns routing/neighbor info, and
masks IPv6 prefix. `ping`{.verbatim} auto-restores your real prefix for
testing.

``` example
ipbrief a
ping 3fff:abc:1234::1
```

# Dependencies & Requirements

## Script Dependencies

Some scripts depend on others:

- `02-PS1`{.verbatim} (prompt) requires `08-colors`{.verbatim} for color
  variables
- `99-ip`{.verbatim} and related functions use
  `00-obscureIPv6Prefix`{.verbatim} for privacy masking
- Source order matters: scripts are loaded in numerical order (00-99)

## External Tools

Some scripts require external tools to be installed:

- `05-calc`{.verbatim}: requires `bc`{.verbatim} (calculator)
- `10-distrowatch`{.verbatim}: requires `distrobox`{.verbatim}
- `11-eat`{.verbatim}: requires Emacs with Eat terminal emulator
- `13-fontpreview`{.verbatim}: requires `fontpreview`{.verbatim} utility
- `19-ntfy`{.verbatim} / `27-update`{.verbatim}: require
  `curl`{.verbatim} and ntfy.sh service
- `26-units.sh`{.verbatim}: requires `bc`{.verbatim} (calculator)
- `28-yt-dlp`{.verbatim}: requires `pipenv`{.verbatim} and
  `yt-dlp`{.verbatim}
- `atuin`{.verbatim}: requires Atuin shell history tool

## Locale Requirements

- Aliases/functions with Unicode names (e.g., `ß`{.verbatim} in
  `03-alias`{.verbatim}) require UTF-8 locale
- Set in your shell: `export LANG=en_US.UTF-8`{.verbatim} or similar

# Troubleshooting

## Scripts Not Loading

If your scripts aren\'t being sourced:

1.  Check that the sourcing line is in your `~/.bashrc`{.verbatim} (not
    `~/.bash_profile`{.verbatim})
2.  Verify the glob pattern matches your files:
    `ls ~/.bashrc.d/[0-9][0-9]-*`{.verbatim}
3.  Ensure files are readable: `chmod +r ~/.bashrc.d/*`{.verbatim}

## Function Not Found

If a function isn\'t available:

1.  Check if the script is prefixed with `_`{.verbatim} (disabled)
2.  Verify the script loaded: `type function_name`{.verbatim}
3.  Check for syntax errors:
    `bash -n ~/.bashrc.d/script-name`{.verbatim}

## Path Issues

If custom paths aren\'t working:

1.  Check load order - PATH scripts (01, 06, 21, 22) should load early
2.  Verify paths exist: `ls -ld ~/.local/bin ~/.cargo/bin`{.verbatim}
3.  Reload your shell or run `source ~/.bashrc`{.verbatim}

------------------------------------------------------------------------
