#!/bin/bash

touch ~/.svnupdate

function updateDir ()  {
    d=$1
    if [ -d "${d}" ] ; then
        pushd "${d}"
        if [ -d ".svn" ] ; then
            svn up
            svn st
        elif [ -d ".git" ] ; then
            git pull
            git status
        else
            echo "Don't know what to do with ${d}"
        fi

        popd
    fi
}

# for dir in ~/repos/* ~/personal/* ; do
for dir in ~/repos/* ; do
    updateDir "${dir}"
done

