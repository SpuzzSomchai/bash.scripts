!#bin/bash

# This will create files with same name for each markdown as yml file
for x in *.md; do touch "$x" "${x%.md}.yml"; done