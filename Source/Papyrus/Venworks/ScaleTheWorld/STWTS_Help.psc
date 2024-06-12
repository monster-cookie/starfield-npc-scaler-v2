ScriptName STWTS_Help

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

;; Call using: CGF "STWTS_Help.Show" 
Function Show() Global
  String message = "Scale the World will pull the stats of near by NPCs to your level and stats to keep combat challenging.\n" 
  message += "\n\nHow to use\n\n"
  message += "     Feature Flags Status Screen:\n\tCGF \"STWTS_Debug.FeatureFlags\"\n"
  message += "To toggle debug mode and logging:\n\tCGF \"STWTS_Debug.ToggleDebugMode\"\n"
  message += "        To toggle scaling active:\n\tCGF \"STWTS_Debug.ToggleActiveMode\"\n"
  message += "    To toggle critter easter egg:\n\tCGF \"STWTS_Debug.ToggleCritterEasterEgg\"\n"
  message += "       Set active scaling preset:\n\tCGF \"STWTS_Debug.SetActivePreset\" <scaling_spread_integer>\n"
  message += "\n\nScaling Preset Valid Settings: 0=Story, 1=Easy, 2=Normal, 3=Hard, 4=Nightmare, 5=Apocalypse\n"

  Debug.MessageBox(message)
EndFunction
