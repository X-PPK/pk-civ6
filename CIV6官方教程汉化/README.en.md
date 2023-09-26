# Sid Meier's Civilization VI Development Tools

## Tools included
### ModBuddy
ModBuddy is an IDE (integrated development environment) designed specifically for modders.  It is based off of Microsoft's Visual Studio 2013.  This tool is the primary tool used for developing mods.

It should be noted, however, that  this tool isn't necessarily required to create mods.  The .modinfo format is plain XML and can be hand-crafted.

### Steam Workshop Uploader
The uploader is a separate tool used to upload mods to Steam.

### FireTuner
FireTuner is a run-time debug console that can be attached to the game.  It's extremely useful for designers to inspect various bits of gameplay while the game is in play.

### Art/Asset Tools
A suite of art tools have been included in the SDK.  These tools are accessible through ModBuddy under the Tools menu.  Many of the asset tools require an open mod project in order to be launched.

## Additional Development Assets
For most art-related mods, intermediate game assets are required in order for the mod to correctly reference and/or replace these assets in-game.  These assets are large (approx 30 gigabytes).  In order to reduce the download size for modders who do not require these assets, they have been moved into their own separate Steam Tools entry.

These assets are stored in "Sid Meier's Civilization VI Development Assets.

ModBuddy will attempt to auto-discover these assets but may have trouble if they were installed to a custom location.  From within ModBuddy, navigate to Tools->Options->Civilization VI and set the 'Civilization VI Assets Path' to the root folder of the assets.

By default, this is usually:
C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI SDK Assets


