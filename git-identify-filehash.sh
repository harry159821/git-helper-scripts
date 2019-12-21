#!/bin/sh
git_identify_filehash() {
	# USAGE: git-identify file hash
    local file=${1?}
    local hash=${2?}
    git log --all --format="%h %s" $file | while read commit msg; do
        if [ $(git rev-parse $commit:$file) = "$hash" ]; then
            echo $commit $msg - oldest tag including this commit: \
                $(git tag --contains $commit | head -n 1)
            break
        fi
    done
}

git_identify_filehash $1 $2
