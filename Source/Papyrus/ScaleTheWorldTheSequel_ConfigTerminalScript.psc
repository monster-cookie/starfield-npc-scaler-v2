ScriptName ScaleTheWorldTheSequel_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants
;;;
Int Property      CONST_PRESET_STORY=0 Auto Const Mandatory
Int Property       CONST_PRESET_EASY=1 Auto Const Mandatory
Int Property     CONST_PRESET_NORMAL=2 Auto Const Mandatory
Int Property       CONST_PRESET_HARD=3 Auto Const Mandatory
Int Property  CONST_PRESET_NIGHTMARE=4 Auto Const Mandatory
Int Property CONST_PRESET_APOCOLYPSE=5 Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="ScaleTheWorldTheSequel" Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_ActivePreset Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_EasterEggMode_Critter Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property ScaleTheWorldTheSequel_ConfigTerminal Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_MainMenu Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_ActivePreset Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_ConfigureEasterEggs Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If (akTarget == PlayerRef as ObjectReference)
    VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, Venpi_DebugEnabled.GetValueInt())
    PlayerRef.AddItem(ScaleTheWorldTheSequel_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(ScaleTheWorldTheSequel_ConfigTerminal_MainMenu, -1, True)
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "OnEffectStart", "Inventoy object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  Message previousMessage = message
  While (menuActive)
    If (message == ScaleTheWorldTheSequel_ConfigTerminal_MainMenu)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Stat Scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Stat Scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Debug Mode
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 Clicked - Enable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Debug Mode
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Disable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Configure Active Scaling Preset
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Configure Active Scaling Preset.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_ActivePreset
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Configure Enabled Easter Eggs
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Configure Enabled Easter Eggs.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_ConfigureEasterEggs
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Active Scaling Preset Menu
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_ActivePreset)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_ActivePreset.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Set to story mode scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 1 clicked - Set to story mode scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_STORY)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Set to easy scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 2 clicked - Set to easy scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_EASY)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Set to normal scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 3 clicked - Set to normal scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_NORMAL)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Set to hard scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 4 clicked - Set to hard scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_HARD)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Set to nightmare scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 5 clicked - Set to nightmare scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_NIGHTMARE)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Set to apocalypse scaling
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 6 clicked - Set to apocalypse scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_ActivePreset.SetValueInt(CONST_PRESET_APOCOLYPSE)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Easter Egg Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_ConfigureEasterEggs)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_ConfigureEasterEggs.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Critter Overlords
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 1 clicked - Enable Critter Overlords.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_EasterEggMode_Critter.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Critter Overlords
        VPI_Debug.DebugMessage(Venpi_ModName, "ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 2 clicked - Disable Critter Overlords.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_EasterEggMode_Critter.SetValueInt(0)
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
