ScriptName STWTS_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="ScaleTheWorldTheSequel" Auto Const Mandatory

GlobalVariable Property STWTS_Enabled Auto Const Mandatory
GlobalVariable Property STWTS_ActivePreset Auto Const Mandatory
GlobalVariable Property STWTS_EasterEggMode_Critter Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property STWTS_ConfigTerminal Auto
Message Property STWTS_ConfigTerminal_MainMenu Auto
Message Property STWTS_ConfigTerminal_ActivePreset Auto
Message Property STWTS_ConfigTerminal_ConfigureEasterEggs Auto
VPI_SharedObjectManager:DifficultyPresets Property EnumDifficultyPresets Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  EnumDifficultyPresets = VPI_SharedObjectManager.GetEnumDifficultyPresets()

  If (akTarget == PlayerRef as ObjectReference)
    VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, Venpi_DebugEnabled.GetValueInt())
    PlayerRef.AddItem(STWTS_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(STWTS_ConfigTerminal_MainMenu, -1, True)
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "OnEffectStart", "Inventory object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  Message previousMessage = message
  While (menuActive)
    If (message == STWTS_ConfigTerminal_MainMenu)
      menuButtonClicked = STWTS_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Stat Scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_MainMenu
        STWTS_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Stat Scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_MainMenu
        STWTS_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Debug Mode
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 Clicked - Enable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Debug Mode
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Disable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Configure Active Scaling Preset
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Configure Active Scaling Preset.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_ActivePreset
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Configure Enabled Easter Eggs
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Configure Enabled Easter Eggs.", 0, Venpi_DebugEnabled.GetValueInt())
        message = STWTS_ConfigTerminal_ConfigureEasterEggs
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Active Scaling Preset Menu
    ElseIf (message == STWTS_ConfigTerminal_ActivePreset)
      menuButtonClicked = STWTS_ConfigTerminal_ActivePreset.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = STWTS_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Set to story mode scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 1 clicked - Set to story mode scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Story)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Set to easy scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 2 clicked - Set to easy scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Easy)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Set to normal scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 3 clicked - Set to normal scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Normal)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Set to hard scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 4 clicked - Set to hard scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Hard)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Set to nightmare scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 5 clicked - Set to nightmare scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Nightmare)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Set to apocalypse scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 6 clicked - Set to apocalypse scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_ActivePreset.SetValueInt(EnumDifficultyPresets.Apocalypse)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Easter Egg Settings
    ElseIf (message == STWTS_ConfigTerminal_ConfigureEasterEggs)
      menuButtonClicked = STWTS_ConfigTerminal_ConfigureEasterEggs.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = STWTS_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Critter Overlords
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 1 clicked - Enable Critter Overlords.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_EasterEggMode_Critter.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Critter Overlords
        VPI_Debug.DebugMessage(Venpi_ModName, "STWTS_ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 2 clicked - Disable Critter Overlords.", 0, Venpi_DebugEnabled.GetValueInt())
        STWTS_EasterEggMode_Critter.SetValueInt(0)
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
