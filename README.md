# Shared Minetest France repository

This repository is prepared with the idea that it will be shared with different minetest servers admins.

Here is the description of the file-tree:
* minetest-france: top directory
  * games: sub-(directories|repositories) of minetest games, initially official minetest_game
  * minetest: sub-repository of minetest source code, for "easy" updates
  * mods: sub-(directories|repositories) of mods and import of mods' archives for those not being in a repository
  * mods-categories: sub-directories with symlinks to mods/, in hope admins can better find the right mod
  * servers: sub-(directories|repositories) of each server, for their particular config files and scripts
  * textures: sub-(directories|repositories) of textures packs, and lone texture if needs be
  * tools: scripts, for now one to help subrepo clone a list of git repositories from a file
  * tools-data: data to feed our tools, for now list of mods and git repositores in some files

Here is the description of the server template:
 * servers/template/LICENSE.txt: the license of the files you add in your server directory
 * servers/template/README.md: the description of your server, the contribution rules, etc
 * servers/template/TEAM.txt: the list of your server team members, formated with 3 columns: "nickname(s)" "role(s)" "contact information", use commas in a given field if needs be
 * servers/template/games: helper list of games for your server init.sh
 * servers/template/init.sh: script used to replicate your server setup, either after you move it to an other machine, a reinstallation, or someone willing to clone your setup
 * servers/template/mods: helper list of mods for your server init.sh
 * servers/template/textures: helper list of textures for your server init.sh


We (plan to) make an extensive use of git-subrepo https://github.com/ingydotnet/git-subrepo, please check its documentation for any question regarding its use.
