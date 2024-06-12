ScriptName STWTS_Debug

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

;; Call using: CGF "STWTS_Debug.FeatureFlags" 
Function FeatureFlags() Global
  GlobalVariable Venpi_DebugEnabled = Game.GetFormFromFile(0x03000800, "VenpiCore.esm") as GlobalVariable
  GlobalVariable STWTS_Enabled = Game.GetFormFromFile(0x7B000806, "ScaleTheWorldTheSequel.esm") as GlobalVariable
  GlobalVariable STWTS_ActivePreset = Game.GetFormFromFile(0x7B000870, "ScaleTheWorldTheSequel.esm") as GlobalVariable
  GlobalVariable STWTS_EasterEggMode_Critter = Game.GetFormFromFile(0x7B000844, "ScaleTheWorldTheSequel.esm") as GlobalVariable

  String message = "Current Feature Flag Settings (1-On, 0=Off)\n\n"
  message += "                Debug Mode = " + Venpi_DebugEnabled.GetValueInt() + "\n"
  message += "           Scaling Enabled = " + STWTS_Enabled.GetValueInt() + "\n"
  message += "             Active Preset = " + STWTS_ActivePreset.GetValueInt() + "\n"
  message += "Critter Easter Egg Enabled = " + STWTS_EasterEggMode_Critter.GetValueInt() + "\n"
  message += "\n\nPreset Valid Settings: 0=Story, 1=Easy, 2=Normal, 3=Hard, 4=Nightmare, 5=Apocalypse\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "STWTS_Debug.ToggleDebugMode" 
Function ToggleDebugMode() Global
  GlobalVariable Venpi_DebugEnabled = Game.GetFormFromFile(0x03000800, "VenpiCore.esm") as GlobalVariable
  If (Venpi_DebugEnabled == None)
    Debug.MessageBox("Failed to find Venpi_DebugEnabled global variable in VenpiCore.esm. Please contact Venpi for help.")
    Return
  Else
    If (Venpi_DebugEnabled.GetValueInt() == 0)
      Venpi_DebugEnabled.SetValueInt(1)
    Else
      Venpi_DebugEnabled.SetValueInt(0)
    EndIf
  EndIf
EndFunction

;; Call using: CGF "STWTS_Debug.ToggleActiveMode" 
Function ToggleActiveMode() Global
  GlobalVariable STWTS_Enabled = Game.GetFormFromFile(0x7B000806, "ScaleTheWorldTheSequel.esm") as GlobalVariable
  Game.warning("STWTS_Enabled == " + STWTS_Enabled.GetValueInt())
  If (STWTS_Enabled == None || !STWTS_Enabled)
    Debug.MessageBox("Failed to find STWTS_Enabled global variable in ScaleTheWorldTheSequel.esm. Please contact Venpi for help.")
    Return
  Else
    If (STWTS_Enabled.GetValueInt() == 0)
      STWTS_Enabled.SetValueInt(1)
    Else
      STWTS_Enabled.SetValueInt(0)
    EndIf
  EndIf
EndFunction

;; Call using: CGF "STWTS_Debug.SetActivePreset" 
Function SetActivePreset(int preset) Global
  GlobalVariable STWTS_ActivePreset = Game.GetFormFromFile(0x7B000870, "ScaleTheWorldTheSequel.esm") as GlobalVariable
  If (STWTS_ActivePreset == None || !STWTS_ActivePreset)
    Debug.MessageBox("Failed to find STWTS_ActivePreset global variable in ScaleTheWorldTheSequel.esm. Please contact Venpi for help.")
    Return
  EndIF
  STWTS_ActivePreset.SetValueInt(preset)
EndFunction

;; Call using: CGF "STWTS_Debug.ToggleCritterEasterEgg" 
Function ToggleCritterEasterEgg() Global
  GlobalVariable STWTS_EasterEggMode_Critter = Game.GetFormFromFile(0x7B000844, "ScaleTheWorldTheSequel.esm") as GlobalVariable
  If (STWTS_EasterEggMode_Critter == None || !STWTS_EasterEggMode_Critter)
    Debug.MessageBox("Failed to find STWTS_EasterEggMode_Critter global variable in ScaleTheWorldTheSequel.esm. Please contact Venpi for help.")
    Return
  Else
    If (STWTS_EasterEggMode_Critter.GetValueInt() == 0)
      STWTS_EasterEggMode_Critter.SetValueInt(1)
    Else
      STWTS_EasterEggMode_Critter.SetValueInt(0)
    EndIf
  EndIf
EndFunction
