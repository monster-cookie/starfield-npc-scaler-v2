Scriptname ScaleTheWorldTheSequel_StatScalerScript extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants
;;;
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
Keyword Property ScaleTheWorldTheSequel_Scaled Auto Const Mandatory

ConditionForm Property ActorIsCritter Auto Const Mandatory
ConditionForm Property ActorIsCreature Auto Const Mandatory
ConditionForm Property ActorIsHuman Auto Const Mandatory
ConditionForm Property ActorIsRobot Auto Const Mandatory

ActorValue Property Health Auto Const Mandatory
ActorValue Property DamageResist Auto Const Mandatory
ActorValue Property EnergyResist Auto Const Mandatory
ActorValue Property ElectromagneticDamageResist Auto Const Mandatory
ActorValue Property ENV_Resist_Radiation Auto Const Mandatory
ActorValue Property ENV_Resist_Corrosive Auto Const Mandatory
ActorValue Property ENV_Resist_Airborne Auto Const Mandatory
ActorValue Property ENV_Resist_Thermal Auto Const Mandatory
ActorValue Property CriticalHitChance Auto Const Mandatory
ActorValue Property CriticalHitDamageMult Auto Const Mandatory
ActorValue Property AttackDamageMult Auto Const Mandatory
ActorValue Property ReflectDamage Auto Const Mandatory

Keyword Property ActorTypeLegendary Auto Const Mandatory
;; ActorValue Property LegendaryRank Auto Const Mandatory
LegendaryAliasQuestScript Property LegendaryAliasQuest Auto Const mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
ObjectReference Property Myself Auto
Actor Property RealMe Auto

ObjectReference Property PlayerRef Auto Const Mandatory
Actor Property Player Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart", "OnEffectStart triggered", 0, Venpi_DebugEnabled.GetValueInt())
  If (akTarget == None)
    Return
  EndIf

  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()
  Player = PlayerRef.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(ScaleTheWorldTheSequel_Scaled)) 
    return
  Else
    RealMe.AddKeyword(ScaleTheWorldTheSequel_Scaled)
  EndIf

  If (ScaleTheWorldTheSequel_Enabled.GetValueInt() == 0)
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart", "NPC Stat Scaling is currently disabled.", 0, Venpi_DebugEnabled.GetValueInt())
    return
  EndIf

  ;; System Generated Legendary NPC we shouldn't mess with. 
  If (RealMe.HasKeyword(ActorTypeLegendary))
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "(" + RealMe.GetRace() + ")> is already a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, Venpi_DebugEnabled.GetValueInt())
    ; DebugLevelScaling("FINAL")
    Return
  EndIf

  If (ScaleTheWorldTheSequel_Critter_Enabled.GetValueInt() == 1 && ActorIsCritter.IsTrue(Myself, PlayerRef))
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " so applying critter stat scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
    HandleStatScaling(ScaleTheWorldTheSequel_Critter_Base.GetValue(), ScaleTheWorldTheSequel_Critter_ScaleRangeMin.GetValue(), ScaleTheWorldTheSequel_Critter_ScaleRangeMax.GetValue(), ScaleTheWorldTheSequel_Critter_EasterEggMode.GetValueInt() as Bool)
  ElseIF (ScaleTheWorldTheSequel_Creature_Enabled.GetValueInt() == 1 && ActorIsCreature.IsTrue(Myself, PlayerRef))
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " so applying creature stat scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
    HandleStatScaling(ScaleTheWorldTheSequel_Creature_Base.GetValue(), ScaleTheWorldTheSequel_Creature_ScaleRangeMin.GetValue(), ScaleTheWorldTheSequel_Creature_ScaleRangeMax.GetValue(), ScaleTheWorldTheSequel_Creature_EasterEggMode.GetValueInt() as Bool)
  ElseIF (ScaleTheWorldTheSequel_Human_Enabled.GetValueInt() == 1 && ActorIsHuman.IsTrue(Myself, PlayerRef))
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " so applying human stat scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
    HandleStatScaling(ScaleTheWorldTheSequel_Human_Base.GetValue(), ScaleTheWorldTheSequel_Human_ScaleRangeMin.GetValue(), ScaleTheWorldTheSequel_Human_ScaleRangeMax.GetValue(), ScaleTheWorldTheSequel_Human_EasterEggMode.GetValueInt() as Bool)
  ElseIF (ScaleTheWorldTheSequel_Robot_Enabled.GetValueInt() == 1 && ActorIsRobot.IsTrue(Myself, PlayerRef))
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " so applying robot stat scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
    HandleStatScaling(ScaleTheWorldTheSequel_Robot_Base.GetValue(), ScaleTheWorldTheSequel_Robot_ScaleRangeMin.GetValue(), ScaleTheWorldTheSequel_Robot_ScaleRangeMax.GetValue(), ScaleTheWorldTheSequel_Robot_EasterEggMode.GetValueInt() as Bool)
  Else
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " so applying default stat scaling rules.", 0, Venpi_DebugEnabled.GetValueInt())
    HandleStatScaling(ScaleTheWorldTheSequel_Default_Base.GetValue(), ScaleTheWorldTheSequel_Default_ScaleRangeMin.GetValue(), ScaleTheWorldTheSequel_Default_ScaleRangeMax.GetValue(), ScaleTheWorldTheSequel_Default_EasterEggMode.GetValueInt() as Bool)
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "OnEffectFinish", "OnEffectFinish triggered", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function HandleStatScaling(Float base, Float scaleMin, Float scaleMax, Bool easterEggMode)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  ; DebugLevelScaling("INITIAL")

  Int chanceLegendary = ScaleTheWorldTheSequel_Legendary_ChanceToSpawn.GetValueInt()
  if (chanceLegendary <= 0)
    chanceLegendary = 0
  ElseIF (chanceLegendary >= 100)
    chanceLegendary = 100
  EndIf
  If (chanceLegendary == 100 || Game.GetDieRollSuccess(chanceLegendary, 1, 100, -1, -1))
    ;; Won the lotto I become a legendary
    VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "HandleStatScaling",  Myself + "> has won the lotto and is now a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, Venpi_DebugEnabled.GetValueInt())
    LegendaryAliasQuest.MakeLegendary(RealMe)
    ; DebugLevelScaling("FINAL")
    return
  EndIf

  Float npcScalingAdjustmentToPlayer = GetScalingAdjustmentForDifficulty(base, scaleMin, scaleMax, easterEggMode)

  string message = "\n\n -=-=-=-=-= STAT DEBUG (" + Myself + ") =-=-=-=-=-\n\n"
  message += "Calculated a stat adjustment factor of " + npcScalingAdjustmentToPlayer + ".\n"

  int scaledHealth = Math.Round(playerHealth * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(Health, scaledHealth)
  message += "Adjusting my Health to " + scaledHealth + " from " + myHealth + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerHealth + " health.\n"

  int scaledDamageResist = Math.Round(playerDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(DamageResist, scaledDamageResist)
  message += "Adjusting my Damage Resist stat to " + scaledDamageResist + " from " + myDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerDamageResist + " damage resist.\n"

  int scaledEnergyResist = Math.Round(playerEnergyResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(EnergyResist, scaledEnergyResist)
  message += "Adjusting my Energy Resist stat to " + scaledEnergyResist + " from " + myEnergyResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerEnergyResist + " energy resist.\n"

  int scaledEMDamageResist = Math.Round(playerEMDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(ElectromagneticDamageResist, scaledEMDamageResist)
  message += "Adjusting my EM Damage Resist stat to " + scaledEMDamageResist + " from " + myEMDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerEMDamageResist + " EM damage resist.\n"

  Float scaledCriticalHitChance = Math.Round(playerCriticalHitChance * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(CriticalHitChance, scaledCriticalHitChance)
  message += "Adjusting my EM Damage Resist stat to " + scaledCriticalHitChance + " from " + myCriticalHitChance + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerCriticalHitChance + " EM damage resist.\n"


  ;; Some stats adjust by level difference
  Float levelMult = (playerLevel/100) as Int
  If (levelMult <= 0)
    levelMult = 0.5
  EndIf

  Float scaledAttackDamageMult = Math.sqrt(Math.sqrt(playerLevel)) * levelMult
  message += "Adjusting my attack multiplier to " + scaledAttackDamageMult + " from " + myAttackDamageMult + " against the player's " + playerAttackDamageMult + ".\n"
  RealMe.SetValue(AttackDamageMult, scaledAttackDamageMult)

  Float scaledCriticalHitDamageMult = (Math.sqrt(Math.sqrt(playerLevel))/2) * levelMult
  message += "Adjusting my critical damage multiplier to " + scaledCriticalHitDamageMult + " from " + myCriticalHitDamageMult + " against the player's " + playerCriticalHitDamageMult + ".\n"
  RealMe.SetValue(CriticalHitDamageMult, scaledCriticalHitDamageMult)

  message += "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"
  VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "HandleStatScaling", message, 0, Venpi_DebugEnabled.GetValueInt())
  DebugLevelScaling("FINAL")
EndFunction

Float Function GetScalingAdjustmentForDifficulty(Float base, Float scaleMin, Float scaleMax, Bool easterEggMode)
  Int iDifficulty = Game.GetDifficulty()

  If (easterEggMode && Game.GetDieRollSuccess(5, 1, 100, -1, -1))
    scaleMin = scaleMin * 1.25
    scaleMax = scaleMax * 1.50
  EndIf

  Float adjustment = Utility.RandomFloat(scaleMin,scaleMin)
  Float calculated = 1
  If (iDifficulty == 0)
    ;; Very Easy Difficulty
    calculated = (base*0) + adjustment
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    calculated = (base*1) + adjustment
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    calculated = (base*3) + adjustment
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    calculated = (base*6) + adjustment
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    calculated = (base*12) + adjustment
  Else 
    ;; Really can only be survival/nightmare mode
    calculated = (base*30) + adjustment
  EndIf

  If (ScaleTheWorldTheSequel_HardMode_Level.GetValueInt() == CONST_SCALING_DIFFICULTY_HARD)
    calculated += 2
  ElseIf (ScaleTheWorldTheSequel_HardMode_Level.GetValueInt() == CONST_SCALING_DIFFICULTY_NIGHTMARE)
    calculated += 4
  ElseIf (ScaleTheWorldTheSequel_HardMode_Level.GetValueInt() == CONST_SCALING_DIFFICULTY_APOCOLYPSE)
    calculated += 8
  EndIf

  Return calculated
EndFunction

Function DebugLevelScaling(String scalingState)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()
  string message = "\n\n ********** STAT DEBUG (" + scalingState +  "-" + Myself + ") ********** \n\n"
  message += "Scaling for a player of level " + playerLevel + " and my level is " + myLevel + ".\n"

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  message += "Current stats (Encounter Level " + encounterlevel +"):\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  message += "My/Player Damage Resist: " + myDamageResist + " | " + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + " | " + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + " | " + playerEMDamageResist + ".\n"

  message += "My/Player Radiation Resist: " + myRadiationResist + " | " + playerRadiationResist + ".\n"
  message += "My/Player Corrosive Resist: " + myCorrosiveResist + " | " + playerCorrosiveResist + ".\n"
  message += "My/Player Airborne Resist: " + myAirborneResist + " | " + playerAirborneResist + ".\n"
  message += "My/Player Thermal Resist: " + myThermalResist + " | " + playerThermalResist + ".\n"

  message += "My/Player Reflect Damage: " + myReflectDamage + " | " + playerReflectDamage + ".\n"
  message += "My/Player Critical Hit Chance: " + myCriticalHitChance + " | " + playerCriticalHitChance + ".\n"
  message += "My/Player Critical Hit Damage Multiplier: " + myCriticalHitDamageMult + " | " + playerCriticalHitDamageMult + ".\n"
  message += "My/Player Attack Damage Multiplier: " + myAttackDamageMult + " | " + playerAttackDamageMult + ".\n"

  message += "\n************************************************************\n\n"
  VPI_Debug.DebugMessage("ScaleTheWorldTheSequel_StatScalerScript", "DebugLevelScaling-" + scalingState, message, 0, Venpi_DebugEnabled.GetValueInt())
EndFunction
