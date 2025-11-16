#!/usr/bin/env bash

set -xve

site_name='off_hours'

# Install Hugo
## On Arch Linux
sudo pacman --no-checks -Su hugo

hugo new site $site_name

cd $site_name

git init

# Add theme within root of the site
git submodule add https://github.com/mrmierzejewski/hugo-theme-console.git themes/hugo-theme-console


# Init theme for site
hugo mod init github.com/mesnaround/mesnaround.github.io

# Next declare the Console theme module as a dependency for your site.
hugo mod get github.com/mrmierzejewski/hugo-theme-console


cat << EOF >> hugo.toml
baseURL = 'https://mesnaround.github.io/'
languageCode = 'en-us'
title = 'Mark Schott: Off Hours'
theme = "hugo-theme-console"

[[module.imports]]
  path = "github.com/mrmierzejewski/hugo-theme-console"

[params]
  description = "Mark Schott's Corner of the WWW"
  animateStyle = "animate-fade-up" # Animation style for content

[[params.navlinks]]
  name = "About"
  url = "/about/"

[[params.navlinks]]
  name = "Posts"
  url = "/posts/"

[[params.navlinks]]
  name = "Photos"
  url = "/photos/"
EOF
