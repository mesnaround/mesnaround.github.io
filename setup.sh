#!/usr/bin/env bash

set -xve

site_name='plugged_in_and_about'

# Install Hugo
## On Arch Linux
sudo pacman --no-checks -Su hugo

hugo new site $site_name

cd $site_name

git init

# Add theme within root of the site
git submodule add https://github.com/mrmierzejewski/hugo-theme-console.git hugo-theme-console


# Init theme for site
hugo mod init github.com/my-username/my-new-site


cat << EOF >> hugo.toml
baseURL = 'https://mesnaround.github.io/'
languageCode = 'en-us'
title = 'Plugged in and About'
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
