---
layout: post
---

## Preface
This is not intended to be a step-by-step guide. Those you should find from the supported documentation. This is just my general thoughts and high-level experience.

## Motivation
I want to remove as much extranneous and uncontrolled (by me) data collection from my life as possible. Just today I saw an ad for Quickbooks on a Youtube advertisement after mentioning it on a Zoom call earlier this week. I am confident this was not a coincidence.

I also would like to better understand general security practices and explore solutions that are out there. IMO, there's a balance between security and convenience, and I think that by sacrificing some of that convenience I will also make it more difficult for third party trackers to get access to my data. I still plan on using some Google services like gmail(syncing) and calendar although I'm looking for alternatives.

The less my data is in unintended party's hands the better. The vast majority of companies can not be trusted to handle your data with care either due to lack of technical know-how or lack of prioritization. I think is ultimately due to relaxed penalties for data privacy abuses imposed by State and Federal governments for the most part (in the USA). 

My current expectation is that my second to second location is in databases for numerous companies via cell signal, wifi triangulation, bluetooth contact tracing. Furthermore, id capabilities across apps is also suspect. I think the other possibility is general hacking. Just yesterday I heard how some savvy hackers emulated thousands of phones to drain bank accounts in the USA.

The last thing I'm expecting to get is better battery life due to limited background processes that are a part of Google apps (Gapps).

## Plan
I've got a Google Pixel3a which I've really enjoyed as a phone and happens to be one of the supported Graphene OS devices. It was cheap and has been first in line to get Android updates. End of life support for the device by Google is May 2022 at which point I can make a decision as to what to do next for a phone.

## Backup
Maybe Titanium backup is a good solution? I chose a piecemeal approach with limited success.

### Signal
Make sure you've properly backed up and saved the 30 digit code

### WhatsApp
My large family uses WhatsApp for correspondence and there's a lot of inertia to change so this will be maintained.
I was unable to successfully import my history into Graphene even after manually placing the database there and renaming it. I may have messed this up but I was given no restore option in Graphene.

### SMS Backup and Restore App
This app helped me with my general messaging from Android.

### Contacts
Can easily export contacts into a vcf file

### Photos and Miscellaneous
Think about and make sure you've got all the irreplaceables backed up.

## Install
The install guide for GrapheneOS was clear and the process is breezy. Make sure to follow the instructions closely.

## Adding Apps
Apart from the standard apps (Vandium, F
### Normal
I very much like:
  * KeePassDX
  * OpenVPN
  * Syncthing (use for my general backups anyways)
Also using
  * Signal
  * OpenCamera
  * VLC
  * OsmAnd (Google Maps replacment which isn't nearly as convenient and I'm still getting used to. Luckily I like using my own intuition to navigate IRL but this may be one of the biggest drawbacks in general and my own SO already gave me a bunch of shit in the first week)

### Work Profile (via Shelter)
Adding shelter has added some semblance of security via sandboxing (My knowledge here is not deep but I believe it's a more strict delineation of memory and storage area for these apps)
Apps I know not to trust go here like:
  * Secondary Browser (DuckDuckGo)
  * WhatsApp
  * Fairmail (linked to my gmail)
  * Specific Aurora Install after cloning from personal space

### What does seem to work which are GSF dependent
  * protonmail
  * chess.com
  
### What I know doesn't work which are GSF dependent
  * Spotify
  * Chase Banking App

### What I'd still like to try
  * Roku App
  * The seedvault backup process
  * Shazham
  
## Daily Use
  * It really is a sacrifice of convenience leaving stock Android. I had everything humming before making the switch but through the inconvenience comes education.
  * Phone works fine
  * Map alternative takes a bit of getting used to. I believe I read that alternative location isn't available so do some more research here if this is make or break. (I'm not there yet only about a week in)
  * Go back to doing things through the browser
     * I login to most sites now directly and get what I need. Who needs an app anyways?
