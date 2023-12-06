ScriptName ScaleTheWorldTheSequel_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants
;;;
Int Property CONST_RULETYPE_NOTSET=-1 Auto Const Mandatory
Int Property CONST_RULETYPE_DEFAULT=0 Auto Const Mandatory
Int Property CONST_RULETYPE_CRITTER=1 Auto Const Mandatory
Int Property CONST_RULETYPE_CREATURE=2 Auto Const Mandatory
Int Property CONST_RULETYPE_HUMAN=3 Auto Const Mandatory
Int Property CONST_RULETYPE_ROBOT=4 Auto Const Mandatory

Int Property CONST_SCALING_DIFFICULTY_NORMAL=0 Auto Const Mandatory
Int Property CONST_SCALING_DIFFICULTY_HARD=1 Auto Const Mandatory
Int Property CONST_SCALING_DIFFICULTY_NIGHTMARE=2 Auto Const Mandatory
Int Property CONST_SCALING_DIFFICULTY_APOCOLYPSE=3 Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_HardMode_Level Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Legendary_ChanceToSpawn Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Default_Base Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Default_ScaleRangeMin Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Default_ScaleRangeMax Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Default_EasterEggMode Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Critter_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Critter_Base Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Critter_ScaleRangeMin Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Critter_ScaleRangeMax Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Critter_EasterEggMode Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Creature_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Creature_Base Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Creature_ScaleRangeMin Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Creature_ScaleRangeMax Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Creature_EasterEggMode Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Human_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Human_Base Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Human_ScaleRangeMin Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Human_ScaleRangeMax Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Human_EasterEggMode Auto Const Mandatory

GlobalVariable Property ScaleTheWorldTheSequel_Robot_Enabled Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Robot_Base Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Robot_ScaleRangeMin Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Robot_ScaleRangeMax Auto Const Mandatory
GlobalVariable Property ScaleTheWorldTheSequel_Robot_EasterEggMode Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property ScaleTheWorldTheSequel_ConfigTerminal Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_MainMenu Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax Auto
Message Property ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If (akTarget == PlayerRef as ObjectReference)
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, Venpi_DebugEnabled.GetValueInt())
    PlayerRef.AddItem(ScaleTheWorldTheSequel_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(ScaleTheWorldTheSequel_ConfigTerminal_MainMenu, -1, True)
  Else
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "OnEffectStart", "Inventoy object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  int ruleType = CONST_RULETYPE_NOTSET
  Message previousMessage = message
  While (menuActive)
    If (message == ScaleTheWorldTheSequel_ConfigTerminal_MainMenu)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Stat Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Stat Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Debug Mode
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 Clicked - Enable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Debug Mode
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Disable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Set to normal/default difficulty scaling rules
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Set to normal/default difficulty scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_HardMode_Level.SetValueInt(CONST_SCALING_DIFFICULTY_NORMAL)
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Set to hard difficulty scaling rules
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Set to hard difficulty scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_HardMode_Level.SetValueInt(CONST_SCALING_DIFFICULTY_HARD)
      ElseIf (menuButtonClicked == 7)
        ;; CLICKED 7: Set to nightmare difficulty scaling rules
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 7 clicked - Set to nightmare difficulty scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_HardMode_Level.SetValueInt(CONST_SCALING_DIFFICULTY_NIGHTMARE)
      ElseIf (menuButtonClicked == 8)
        ;; CLICKED 8: Set to apocalypse difficulty scaling rules
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 8 clicked - Set to apocalypse difficulty scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ScaleTheWorldTheSequel_HardMode_Level.SetValueInt(CONST_SCALING_DIFFICULTY_APOCOLYPSE)
      ElseIf (menuButtonClicked == 9)
        ;; CLICKED 9: Configure Default/Fallback Scaling Settings
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 9 clicked - Launching ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback
      ElseIf (menuButtonClicked == 10)
        ;; CLICKED 10: Configure Critter Race Scaling Settings
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 10 clicked - Launching ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters
      ElseIf (menuButtonClicked == 11)
        ;; CLICKED 11: Configure Creature Race Scaling Settings
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 11 clicked - Launching ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures
      ElseIf (menuButtonClicked == 12)
        ;; CLICKED 12: Configure Human Race Scaling Settings
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 12 clicked - Launching ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans
      ElseIf (menuButtonClicked == 13)
        ;; CLICKED 13: Configure Robot Race Scaling Settings
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 13 clicked - Launching ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Default/Fallback Scaling Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ruleType = CONST_RULETYPE_NOTSET
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Default/Fallbace Scale Settings Button 1 clicked - Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Default_EasterEggMode.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Default/Fallbace Scale Settings Button 2 clicked - Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Default_EasterEggMode.SetValueInt(0)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Configure Base Scaling Amount
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Default/Fallbace Scale Settings Button 3 clicked - Configure Base Scaling Amount.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback
        ruleType = CONST_RULETYPE_DEFAULT
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Configure minimum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Default/Fallbace Scale Settings Button 4 clicked - Configure minimum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback
        ruleType = CONST_RULETYPE_DEFAULT
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Configure maximum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Default/Fallbace Scale Settings Button 5 clicked - Configure maximum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_DefaultFallback
        ruleType = CONST_RULETYPE_DEFAULT
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Critters Scaling Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ruleType = CONST_RULETYPE_NOTSET
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 1 clicked - Enable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Critter_Enabled.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 2 clicked - Disable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Critter_Enabled.SetValueInt(0)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 3 clicked - Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Critter_EasterEggMode.SetValueInt(1)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 4 clicked - Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Critter_EasterEggMode.SetValueInt(0)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Configure Base Scaling Amount
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 5 clicked - Configure Base Scaling Amount.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters
        ruleType = CONST_RULETYPE_CRITTER
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Configure minimum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 6 clicked - Configure minimum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters
        ruleType = CONST_RULETYPE_CRITTER
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Configure maximum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Critter Scale Settings Button 7 clicked - Configure maximum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Critters
        ruleType = CONST_RULETYPE_CRITTER
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Creature Scaling Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ruleType = CONST_RULETYPE_NOTSET
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 1 clicked - Enable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Creature_Enabled.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 2 clicked - Disable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Creature_Enabled.SetValueInt(0)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 3 clicked - Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Creature_EasterEggMode.SetValueInt(1)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 4 clicked - Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Creature_EasterEggMode.SetValueInt(0)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Configure Base Scaling Amount
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 5 clicked - Configure Base Scaling Amount.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures
        ruleType = CONST_RULETYPE_CREATURE
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Configure minimum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 6 clicked - Configure minimum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures
        ruleType = CONST_RULETYPE_CREATURE
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Configure maximum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Creature Scale Settings Button 7 clicked - Configure maximum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Creatures
        ruleType = CONST_RULETYPE_CREATURE
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Humans Scaling Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ruleType = CONST_RULETYPE_NOTSET
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 1 clicked - Enable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Human_Enabled.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 2 clicked - Disable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Human_Enabled.SetValueInt(0)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 3 clicked - Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Human_EasterEggMode.SetValueInt(1)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 4 clicked - Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Human_EasterEggMode.SetValueInt(0)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Configure Base Scaling Amount
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 5 clicked - Configure Base Scaling Amount.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans
        ruleType = CONST_RULETYPE_HUMAN
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Configure minimum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 6 clicked - Configure minimum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans
        ruleType = CONST_RULETYPE_HUMAN
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Configure maximum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Human Scale Settings Button 7 clicked - Configure maximum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Humans
        ruleType = CONST_RULETYPE_HUMAN
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Show Robots Scaling Settings
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        message = ScaleTheWorldTheSequel_ConfigTerminal_MainMenu
        ruleType = CONST_RULETYPE_NOTSET
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Enable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 1 clicked - Enable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Robot_Enabled.SetValueInt(1)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Disable Scaling
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 2 clicked - Disable Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Robot_Enabled.SetValueInt(0)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 3 clicked - Enable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Robot_EasterEggMode.SetValueInt(1)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%)
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 4 clicked - Disable Easter Egg Mode (Min increase by 25% and Max increased by 50%).", 0, Venpi_DebugEnabled.GetValueInt())
        ScaleTheWorldTheSequel_Robot_EasterEggMode.SetValueInt(0)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Configure Base Scaling Amount
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 5 clicked - Configure Base Scaling Amount.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots
        ruleType = CONST_RULETYPE_ROBOT
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Configure minimum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 6 clicked - Configure minimum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots
        ruleType = CONST_RULETYPE_ROBOT
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Configure maximum value for the scaling range
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Robot Scale Settings Button 7 clicked - Configure maximum value for the scaling range.", 0, Venpi_DebugEnabled.GetValueInt())
        message = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax
        previousMessage = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Robots
        ruleType = CONST_RULETYPE_ROBOT
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Set base adjustment factor
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_Base.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to previous menu
        ruleType = CONST_RULETYPE_NOTSET
        message = previousMessage
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Base scaling factor to 0%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 01 clicked - Base scaling factor to 0% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Base scaling factor to 10%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 02 clicked - Base scaling factor to 10% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.10)
        message = previousMessage
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Base scaling factor to 20%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 03 clicked - Base scaling factor to 20% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.20)
        message = previousMessage
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Base scaling factor to 25%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 04 clicked - Base scaling factor to 25% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.25)
        message = previousMessage
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Base scaling factor to 30%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 05 clicked - Base scaling factor to 30% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.30)
        message = previousMessage
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Base scaling factor to 40%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 06 clicked - Base scaling factor to 40% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.40)
        message = previousMessage
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Base scaling factor to 50%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 07 clicked - Base scaling factor to 50% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Base scaling factor to 60%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 08 clicked - Base scaling factor to 60% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.60)
        message = previousMessage
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Base scaling factor to 70%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 09 clicked - Base scaling factor to 70% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.70)
        message = previousMessage
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Base scaling factor to 75%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 10 clicked - Base scaling factor to 75% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.75)
        message = previousMessage
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Base scaling factor to 80%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 11 clicked - Base scaling factor to 80% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.80)
        message = previousMessage
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Base scaling factor to 90%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 12 clicked - Base scaling factor to 90% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 0.90)
        message = previousMessage
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Base scaling factor to 100%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 13 clicked - Base scaling factor to 100% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 1.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Base scaling factor to 125%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 14 clicked - Base scaling factor to 125% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 1.25)
        message = previousMessage
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Base scaling factor to 150%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 15 clicked - Base scaling factor to 150% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 1.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 16) 
        ;; CLICKED 16: Base scaling factor to 175%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 16 clicked - Base scaling factor to 175% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 1.75)
        message = previousMessage
      ElseIF (menuButtonClicked == 17) 
        ;; CLICKED 17: Base scaling factor to 200%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 17 clicked - Base scaling factor to 200% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 2.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 18) 
        ;; CLICKED 18: Base scaling factor to 225%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 18 clicked - Base scaling factor to 225% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 2.25)
        message = previousMessage
      ElseIF (menuButtonClicked == 19) 
        ;; CLICKED 19: Base scaling factor to 250%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 19 clicked - Base scaling factor to 250% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 2.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 20) 
        ;; CLICKED 20: Base scaling factor to 275%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 20 clicked - Base scaling factor to 275% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 2.75)
        message = previousMessage
      ElseIF (menuButtonClicked == 21) 
        ;; CLICKED 21: Base scaling factor to 300%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Base Adjustment Factor Button 21 clicked - Base scaling factor to 300% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForRace(ruleType, 3.00)
        message = previousMessage
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Set minimum scaling range
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMin.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        ruleType = CONST_RULETYPE_NOTSET
        message = previousMessage
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Minimum stat adjustment to 35%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 01 clicked - Minimum stat adjustment to 35% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.35)
        message = previousMessage
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Minimum stat adjustment to 40%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 02 clicked - Minimum stat adjustment to 40% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.40)
        message = previousMessage
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Minimum stat adjustment to 50%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 03 clicked - Minimum stat adjustment to 50% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Minimum stat adjustment to 60%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 04 clicked - Minimum stat adjustment to 60% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.60)
        message = previousMessage
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Minimum stat adjustment to 70%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 05 clicked - Minimum stat adjustment to 70% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.70)
        message = previousMessage
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Minimum stat adjustment to 75%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 06 clicked - Minimum stat adjustment to 75% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.75)
        message = previousMessage
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Minimum stat adjustment to 80%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 07 clicked - Minimum stat adjustment to 80% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.80)
        message = previousMessage
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Minimum stat adjustment to 85%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 08 clicked - Minimum stat adjustment to 85% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.85)
        message = previousMessage
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Minimum stat adjustment to 90%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 09 clicked - Minimum stat adjustment to 90% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.90)
        message = previousMessage
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Minimum stat adjustment to 95%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 10 clicked - Minimum stat adjustment to 95% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 0.95)
        message = previousMessage
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Minimum stat adjustment to 100%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 11 clicked - Minimum stat adjustment to 100% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Minimum stat adjustment to 105%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 12 clicked - Minimum stat adjustment to 105% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.05)
        message = previousMessage
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Minimum stat adjustment to 110%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 13 clicked - Minimum stat adjustment to 110% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.10)
        message = previousMessage
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Minimum stat adjustment to 115%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 14 clicked - Minimum stat adjustment to 115% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.15)
        message = previousMessage
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Minimum stat adjustment to 125%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 15 clicked - Minimum stat adjustment to 125% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.25)
        message = previousMessage
      ElseIF (menuButtonClicked == 16) 
        ;; CLICKED 16: Minimum stat adjustment to 150%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 16 clicked - Minimum stat adjustment to 150% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMinScaleRangeForRace(ruleType, 1.50)
        message = previousMessage
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  Show Menu: Set maximum scaling range
    ElseIf (message == ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax)
      menuButtonClicked = ScaleTheWorldTheSequel_ConfigTerminal_Scaling_ScaleMax.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
        ruleType = CONST_RULETYPE_NOTSET
        message = previousMessage
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Maximum stat adjustment to 35%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 01 clicked - Maximum stat adjustment to 35% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 0.35)
        message = previousMessage
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Maximum stat adjustment to 85%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 02 clicked - Maximum stat adjustment to 85% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 0.85)
        message = previousMessage
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Maximum stat adjustment to 90%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 03 clicked - Maximum stat adjustment to 90% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 0.90)
        message = previousMessage
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Maximum stat adjustment to 95%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 04 clicked - Maximum stat adjustment to 95% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 0.95)
        message = previousMessage
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Maximum stat adjustment to 100%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 05 clicked - Maximum stat adjustment to 100% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Maximum stat adjustment to 105%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 06 clicked - Maximum stat adjustment to 105% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.05)
        message = previousMessage
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Maximum stat adjustment to 110%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 07 clicked - Maximum stat adjustment to 110% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.10)
        message = previousMessage
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Maximum stat adjustment to 115%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 08 clicked - Maximum stat adjustment to 115% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.15)
        message = previousMessage
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Maximum stat adjustment to 120%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 09 clicked - Maximum stat adjustment to 120% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.20)
        message = previousMessage
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Maximum stat adjustment to 125%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 10 clicked - Maximum stat adjustment to 125% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.25)
        message = previousMessage
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Maximum stat adjustment to 150%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 11 clicked - Maximum stat adjustment to 150% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Maximum stat adjustment to 175%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 12 clicked - Maximum stat adjustment to 175% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 1.75)
        message = previousMessage
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Maximum stat adjustment to 200%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 13 clicked - Maximum stat adjustment to 200% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 2.00)
        message = previousMessage
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Maximum stat adjustment to 250%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 14 clicked - Maximum stat adjustment to 250% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 2.50)
        message = previousMessage
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Maximum stat adjustment to 300%
        VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 15 clicked - Maximum stat adjustment to 300% for " + GetRaceBasedOnType(ruleType) + ".", 0, Venpi_DebugEnabled.GetValueInt())
        SetMaxScaleRangeForRace(ruleType, 3.00)
        message = previousMessage
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction

String Function GetRaceBasedOnType(int ruleType)
  If (ruleType == CONST_RULETYPE_CRITTER)
    Return "Critter"
  ElseIf (ruleType == CONST_RULETYPE_CREATURE)
    Return "Creature"
  ElseIf (ruleType == CONST_RULETYPE_HUMAN)
    Return "Human"
  ElseIf (ruleType == CONST_RULETYPE_ROBOT)
    Return "Robot"
  ElseIf (ruleType == CONST_RULETYPE_DEFAULT)
    Return "Default"
  Else
    Return "Unset or Unknown (" + ruleType + ")"
  EndIf
EndFunction

Function SetBaseAdjustmentForRace(Int ruleType, Float newValue)
  If (ruleType == CONST_RULETYPE_CRITTER)
    ScaleTheWorldTheSequel_Critter_Base.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_CREATURE)
    ScaleTheWorldTheSequel_Creature_Base.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_HUMAN)
    ScaleTheWorldTheSequel_Human_Base.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_ROBOT)
    ScaleTheWorldTheSequel_Robot_Base.SetValue(newValue)
  Else
    ScaleTheWorldTheSequel_Default_Base.SetValue(newValue)
  EndIf
EndFunction

Function SetMinScaleRangeForRace(Int ruleType, Float newValue)
  If (ruleType == CONST_RULETYPE_CRITTER)
    ScaleTheWorldTheSequel_Critter_ScaleRangeMin.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_CREATURE)
    ScaleTheWorldTheSequel_Creature_ScaleRangeMin.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_HUMAN)
    ScaleTheWorldTheSequel_Human_ScaleRangeMin.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_ROBOT)
    ScaleTheWorldTheSequel_Robot_ScaleRangeMin.SetValue(newValue)
  Else
    ScaleTheWorldTheSequel_Default_ScaleRangeMin.SetValue(newValue)
  EndIf
EndFunction

Function SetMaxScaleRangeForRace(Int ruleType, Float newValue)
  If (ruleType == CONST_RULETYPE_CRITTER)
    ScaleTheWorldTheSequel_Critter_ScaleRangeMax.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_CREATURE)
    ScaleTheWorldTheSequel_Creature_ScaleRangeMax.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_HUMAN)
    ScaleTheWorldTheSequel_Human_ScaleRangeMax.SetValue(newValue)
  ElseIf (ruleType == CONST_RULETYPE_ROBOT)
    ScaleTheWorldTheSequel_Robot_ScaleRangeMax.SetValue(newValue)
  Else
    ScaleTheWorldTheSequel_Default_ScaleRangeMax.SetValue(newValue)
  EndIf
EndFunction
