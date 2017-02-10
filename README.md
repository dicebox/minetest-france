This repository is prepared with the idea that it will be shared with different minetest servers admins.

Here is a description of the file-tree:
minetest-france: top directory
  minetest: sub-repository of minetest source code, for "easy" updates
  games: sub-(directories|repositories) of minetest games, initially official minetest_game
  mods: sub-(directories|repositories) of mods and import of mods' archives for those not being in a repository
  textures: sub-(directories|repositories) of textures packs, and lone texture if needs be
  servers: sub-(directories|repositories) of each server, for their particular config files and scripts

We (plan to) make an extensive use of git-subrepo https://github.com/ingydotnet/git-subrepo, please check its documentation for any question regarding its use.
