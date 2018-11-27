# mpcvim
An interface for mpc ( vim plugin) to control mpd

# Installation
  The plugin comes in directories. The files of this plugin must be copied to respective folders in your .vim folder. For eg, all the files in the autoload should be copied to .vim/autoload. This must be done for all the files in the plugin.
  
 # Features
  :DisplayList or \md     -to display the list of music files in the current queue of mdb
  :TogglePlayback or \mp  -to play or pause the music
  :MpcBrowswer            -to open MPC 
  :ToggleRandom or <c-a>  -to toggle Random on the DisplayList buffer
  :ToggleRepeat or <c-e>  -to toggle Repeat on the DisplayList buffer
  :PlaySelectedSong or <c-x>  -to play song located at cursor on the DisplayList Buffer
