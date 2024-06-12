ScriptName Venworks:ScaleTheWorld:ConfigTerminalScript Extends ActiveMagicEffect

Import Venworks:Shared:Logging
Import Venworks:Shared:Constants

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property DebugEnabled Auto Const Mandatory
String Property ModName="ScaleTheWorld" Auto Const Mandatory

GlobalVariable Property VWKS_STW_Enabled Auto Const Mandatory
GlobalVariable Property VWKS_STW_ActivePreset Auto Const Mandatory
GlobalVariable Property VWKS_STW_EasterEggMode_Critter Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto Const Mandatory
Form Property VWKS_STW_ConfigTerminal Auto Const Mandatory
Message Property VWKS_STW_ConfigTerminal_MainMenu Auto Const Mandatory
Message Property VWKS_STW_ConfigTerminal_ActivePreset Auto Const Mandatory
Message Property VWKS_STW_ConfigTerminal_ConfigureEasterEggs Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
DifficultyPresets EnumDifficultyPresets

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  EnumDifficultyPresets = new DifficultyPresets

  If (akTarget == PlayerRef as ObjectReference)
    Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, DebugEnabled.GetValueInt())
    PlayerRef.AddItem(VWKS_STW_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(VWKS_STW_ConfigTerminal_MainMenu, -1, True)
  Else
    Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "OnEffectStart", "Inventory object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message activeMenu, Int menuButtonClicked, Bool menuActive)
  Message previousMessage = activeMenu
  While (menuActive)
    If (activeMenu == VWKS_STW_ConfigTerminal_MainMenu)
      menuButtonClicked = VWKS_STW_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Stat Scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enable NPC Stat Scaling.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
        VWKS_STW_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Stat Scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable NPC Stat Scaling.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
        VWKS_STW_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Debug Mode
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 Clicked - Enable Debug Mode.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
        DebugEnabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Debug Mode
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Disable Debug Mode.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
        DebugEnabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Configure Active Scaling Preset
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Configure Active Scaling Preset.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_ActivePreset
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Configure Enabled Easter Eggs
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Configure Enabled Easter Eggs.", 0, DebugEnabled.GetValueInt())
        activeMenu = VWKS_STW_ConfigTerminal_ConfigureEasterEggs
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Active Scaling Preset Menu
    ElseIf (activeMenu == VWKS_STW_ConfigTerminal_ActivePreset)
      menuButtonClicked = VWKS_STW_ConfigTerminal_ActivePreset.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Set to story mode scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 1 clicked - Set to story mode scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Story)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Set to easy scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 2 clicked - Set to easy scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Easy)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Set to normal scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 3 clicked - Set to normal scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Normal)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Set to hard scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 4 clicked - Set to hard scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Hard)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Set to nightmare scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 5 clicked - Set to nightmare scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Nightmare)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Set to apocalypse scaling
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Active Scaling Preset Button 6 clicked - Set to apocalypse scaling.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_ActivePreset.SetValueInt(EnumDifficultyPresets.Apocalypse)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Easter Egg Settings
    ElseIf (activeMenu == VWKS_STW_ConfigTerminal_ConfigureEasterEggs)
      menuButtonClicked = VWKS_STW_ConfigTerminal_ConfigureEasterEggs.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        activeMenu = VWKS_STW_ConfigTerminal_MainMenu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Critter Overlords
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 1 clicked - Enable Critter Overlords.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_EasterEggMode_Critter.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Critter Overlords
        Log(ModName, "Venworks:ScaleTheWorld:ConfigTerminalScript", "ProcessMenu", "Enabled Easter Eggs Button 2 clicked - Disable Critter Overlords.", 0, DebugEnabled.GetValueInt())
        VWKS_STW_EasterEggMode_Critter.SetValueInt(0)
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
