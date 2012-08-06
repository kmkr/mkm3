#!/bin/bash

ROOT=~/git_projects/mkm3

cd $ROOT/vendor/assets/stylesheets/bootstrap
lessc bootstrap.less > $ROOT/app/assets/stylesheets/libs/bootstrap.css
sed 's/@/$/g' variables.less > $ROOT/app/assets/stylesheets/variables.css.scss
sed -i '/spin/d' $ROOT/app/assets/stylesheets/variables.css.scss
cd $ROOT
