#!/usr/bin/env bash

source "$(dirname "${0}")/sort-by.bash"

sort-by "(fe|front)" mid back db <<Here
back01
front02
foofrontend11
mid03
front04
dontcare02 # Should appear near the end after everything else is taken care of
dontcare03 # Should appear near the end after everything else is taken care of
foo11 # Should appear near the end after everything else is taken care of
bar22
back04
front99
mid05
dbfe11 # Should appear near the beginning because not just db but also fe
dbsrv1 # Should appear near the end, because db only
Here
