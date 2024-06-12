ScriptName Venworks:ScaleTheWorld:StatScalerScript extends ActiveMagicEffect

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

GlobalVariable Property VWKS_STW_ChanceToSpawn_Easy Auto Const Mandatory
GlobalVariable Property VWKS_STW_ChanceToSpawn_Hard Auto Const Mandatory
GlobalVariable Property VWKS_STW_ChanceToSpawn_MiniBoss Auto Const Mandatory
GlobalVariable Property VWKS_STW_ChanceToSpawn_Legendary Auto Const Mandatory

GlobalVariable Property VWKS_STW_Preset_Story_Base Auto Const Mandatory
GlobalVariable Property VWKS_STW_Preset_Easy_Base Auto Const Mandatory
GlobalVariable Property VWKS_STW_Preset_Normal_Base Auto Const Mandatory
GlobalVariable Property VWKS_STW_Preset_Hard_Base Auto Const Mandatory
GlobalVariable Property VWKS_STW_Preset_Nightmare_Base Auto Const Mandatory
GlobalVariable Property VWKS_STW_Preset_Apocalypse_Base Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Keyword Property VWKS_STW_Scaled Auto Const Mandatory
DifficultyPresets Property EnumDifficultyPresets Auto

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

Keyword Property ActorTypeGang Auto Const Mandatory
Keyword Property ActorTypePirate Auto Const Mandatory
Keyword Property ActorTypeZealot Auto Const Mandatory

Keyword Property CombatNPC_Easy Auto Const Mandatory
Keyword Property CombatNPC_Normal Auto Const Mandatory
Keyword Property CombatNPC_Hard Auto Const Mandatory
Keyword Property CombatNPC_Miniboss Auto Const Mandatory
Keyword Property CombatNPC_Legendary Auto Const Mandatory

LeveledItem Property LL_Loot_Legendary_Human Auto Const Mandatory
LeveledItem Property LL_Contraband_Any Auto Const Mandatory
MiscObject Property Contraband_VaruunHereticPamphlets Auto Const Mandatory
Potion Property Chem_Aurora Auto Const Mandatory

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
  ; Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart", "OnEffectStart triggered", 0, DebugEnabled.GetValueInt())

  If (akTarget == None)
    Return
  EndIf

  EnumDifficultyPresets = new DifficultyPresets

  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()
  Player = PlayerRef.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent scaling again. 
  If (Myself.HasKeyword(VWKS_STW_Scaled)) 
    return
  Else
    RealMe.AddKeyword(VWKS_STW_Scaled)
  EndIf

  If (VWKS_STW_Enabled.GetValueInt() == 0)
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart", "NPC Stat Scaling is currently disabled.", 0, DebugEnabled.GetValueInt())
    return
  EndIf

  ;; System Generated Legendary NPC we shouldn't mess with. 
  If (RealMe.HasKeyword(ActorTypeLegendary))
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "(" + RealMe.GetRace() + ")> is already a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, DebugEnabled.GetValueInt())
    ; DebugLevelScaling("FINAL")
    Return
  EndIf

  If (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Story)
    ;; Story preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the story preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Story)
  ElseIF (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Easy)
    ;; Easy preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the easy preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Easy)
  ElseIF (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Normal)
    ;; Normal preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the normal preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Normal)
  ElseIF (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Hard)
    ;; Hard preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the hard preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Hard)
  ElseIF (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Nightmare)
    ;; Nightmare preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the nightmare preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Nightmare)
  ElseIF (VWKS_STW_ActivePreset.GetValueInt() == EnumDifficultyPresets.Apocalypse)
    ;; Apocalypse preset is active
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectStart",  Myself + "> is a " + RealMe.GetRace() + " and applying the apocalypse preset scaling.", 0, DebugEnabled.GetValueInt())
    HandleStatScaling(EnumDifficultyPresets.Apocalypse)
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "OnEffectFinish", "OnEffectFinish triggered", 0, DebugEnabled.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Bool Function ShouldBecomeEasyNPC(int preset)
  ;; Base chance for Easy NPCs is 30%
  Int spawnChance = 0
  If (preset == EnumDifficultyPresets.Story)
    spawnChance = VWKS_STW_ChanceToSpawn_Easy.GetValueInt() + 25
  ElseIf (preset == EnumDifficultyPresets.Easy)
    spawnChance = VWKS_STW_ChanceToSpawn_Easy.GetValueInt() + 10
  ElseIf (preset == EnumDifficultyPresets.Normal)
    spawnChance = VWKS_STW_ChanceToSpawn_Easy.GetValueInt()
  ElseIf (preset == EnumDifficultyPresets.Hard)
    spawnChance = VWKS_STW_ChanceToSpawn_Easy.GetValueInt() - 20
  ElseIf (preset == EnumDifficultyPresets.Nightmare)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Apocalypse)
    spawnChance = 0
  EndIf

  If (spawnChance > 100)
    spawnChance = 100
  ElseIf (spawnChance < 0)
    spawnChance = 0
  EndIf
  return spawnChance == 100 || Game.GetDieRollSuccess(spawnChance, 1, 100, -1, -1)
EndFunction

Bool Function ShouldBecomeHardNPC(int preset)
  ;; BAse chance for Hard NPCs is 30%
  Int spawnChance = 0
  If (preset == EnumDifficultyPresets.Story)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Easy)
    spawnChance = VWKS_STW_ChanceToSpawn_Hard.GetValueInt() - 10
  ElseIf (preset == EnumDifficultyPresets.Normal)
    spawnChance = VWKS_STW_ChanceToSpawn_Hard.GetValueInt()
  ElseIf (preset == EnumDifficultyPresets.Hard)
    spawnChance = VWKS_STW_ChanceToSpawn_Hard.GetValueInt() + 20 
  ElseIf (preset == EnumDifficultyPresets.Nightmare)
    spawnChance = VWKS_STW_ChanceToSpawn_Hard.GetValueInt() + 30
  ElseIf (preset == EnumDifficultyPresets.Apocalypse)
    spawnChance = VWKS_STW_ChanceToSpawn_Hard.GetValueInt() + 60
  EndIf

  If (spawnChance > 100)
    spawnChance = 100
  ElseIf (spawnChance < 0)
    spawnChance = 0
  EndIf
  return spawnChance == 100 || Game.GetDieRollSuccess(spawnChance, 1, 100, -1, -1)
EndFunction

Bool Function ShouldBecomeMinibossNPC(int preset)
  ;; BAse chance for Miniboss NPCs is 20%
  Int spawnChance = 0
  If (preset == EnumDifficultyPresets.Story)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Easy)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Normal)
    spawnChance = VWKS_STW_ChanceToSpawn_MiniBoss.GetValueInt()
  ElseIf (preset == EnumDifficultyPresets.Hard)
    spawnChance = VWKS_STW_ChanceToSpawn_MiniBoss.GetValueInt() + 10
  ElseIf (preset == EnumDifficultyPresets.Nightmare)
    spawnChance = VWKS_STW_ChanceToSpawn_MiniBoss.GetValueInt() + 20
  ElseIf (preset == EnumDifficultyPresets.Apocalypse)
    spawnChance = VWKS_STW_ChanceToSpawn_MiniBoss.GetValueInt() + 50
  EndIf

  If (spawnChance > 100)
    spawnChance = 100
  ElseIf (spawnChance < 0)
    spawnChance = 0
  EndIf
  return spawnChance == 100 || Game.GetDieRollSuccess(spawnChance, 1, 100, -1, -1)
EndFunction

Bool Function ShouldBecomeLegendaryNPC(int preset)
  ;; BAse chance for Miniboss NPCs is 10%
  Int spawnChance = 0
  If (preset == EnumDifficultyPresets.Story)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Easy)
    spawnChance = 0
  ElseIf (preset == EnumDifficultyPresets.Normal)
    spawnChance = VWKS_STW_ChanceToSpawn_Legendary.GetValueInt()
  ElseIf (preset == EnumDifficultyPresets.Hard)
    spawnChance = VWKS_STW_ChanceToSpawn_Legendary.GetValueInt() + 10 
  ElseIf (preset == EnumDifficultyPresets.Nightmare)
    spawnChance = VWKS_STW_ChanceToSpawn_Legendary.GetValueInt() + 20
  ElseIf (preset == EnumDifficultyPresets.Apocalypse)
    spawnChance = VWKS_STW_ChanceToSpawn_Legendary.GetValueInt() + 40
  EndIf

  If (spawnChance > 100)
    spawnChance = 100
  ElseIf (spawnChance < 0)
    spawnChance = 0
  EndIf
  return spawnChance == 100 || Game.GetDieRollSuccess(spawnChance, 1, 100, -1, -1)
EndFunction

Float Function GetScalingFactorForDifficulty(int preset)
  Int iDifficulty = Game.GetDifficulty()

  Float base=0
  If (preset == EnumDifficultyPresets.Story)
    base = VWKS_STW_Preset_Story_Base.GetValue()
  ElseIf (preset == EnumDifficultyPresets.Easy)
    base = VWKS_STW_Preset_Easy_Base.GetValue()
  ElseIf (preset == EnumDifficultyPresets.Normal)
    base = VWKS_STW_Preset_Normal_Base.GetValue()
  ElseIf (preset == EnumDifficultyPresets.Hard)
    base = VWKS_STW_Preset_Hard_Base.GetValue()
  ElseIf (preset == EnumDifficultyPresets.Nightmare)
    base = VWKS_STW_Preset_Nightmare_Base.GetValue()
  ElseIf (preset == EnumDifficultyPresets.Apocalypse)
    base = VWKS_STW_Preset_Apocalypse_Base.GetValue()
  Else
    base = 100
  EndIf

  Float scaleMin = 1
  Float scaleMax = 1
  If (iDifficulty == 0)
    ;; Very Easy Difficulty
    scaleMin = 0.30 + base
    scaleMax = 0.80 + base
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    scaleMin = 0.40 + base
    scaleMax = 0.90 + base
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    scaleMin = 0.50 + base
    scaleMax = 1.00 + base
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    scaleMin = 0.60 + base
    scaleMax = 1.10 + base
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    scaleMin = 0.80 + base
    scaleMax = 1.30 + base
  Else 
    ;; Really can only be survival/nightmare mode
    scaleMin = 1.00 + base
    scaleMax = 1.50 + base
  EndIf

  Float scaleFactor = Utility.RandomFloat(scaleMin, scaleMax)

  If (ShouldBecomeEasyNPC(preset))
    ;; Converting to easy NPC
    scaleFactor = scaleFactor * 0.8
    RealMe.AddKeyword(CombatNPC_Easy)
  ElseIf (ShouldBecomeHardNPC(preset))
    ;; converting to hard NPC
    scaleFactor = scaleFactor * 1.1
    RealMe.AddKeyword(CombatNPC_Hard)
  ElseIf (ShouldBecomeMinibossNPC(preset))
    ;; converting to miniboss NPC
    scaleFactor = scaleFactor * 1.25
    RealMe.AddKeyword(CombatNPC_Miniboss)
  ElseIf (ShouldBecomeLegendaryNPC(preset))
    ;; converting to legendary NPC
    RealMe.AddKeyword(CombatNPC_Legendary)
  Else
    ;; leaving as normal npc
    RealMe.AddKeyword(CombatNPC_Normal)
  EndIf

  Return scaleFactor;
EndFunction

Function HandleStatScaling(Int preset)
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

  int encounterLevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  ; DebugLevelScaling("INITIAL")

  Float npcScalingAdjustmentToPlayer = GetScalingFactorForDifficulty(preset)

  string debugMessage = "\n\n -=-=-=-=-= STAT DEBUG (" + Myself + ") =-=-=-=-=-\n\n"
  debugMessage += "I'm a " + GetNPCType() + " NPC with a race of " + RealMe.GetRace() + " and a calculated a stat adjustment factor of " + npcScalingAdjustmentToPlayer + ".\n"

  If (RealMe.HasKeyword(ActorTypeLegendary))
    ;;
    ;; Won the lotto I become a legendary
    Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "HandleStatScaling",  Myself + "> has won the lotto and is now a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, DebugEnabled.GetValueInt())
    LegendaryAliasQuest.MakeLegendary(RealMe)
    ; DebugLevelScaling("FINAL")
    return
  EndIf

  If (RealMe.HasKeyword(CombatNPC_Miniboss))
    ;; Handle Resize
    RealMe.SetScale(1.10)

    ;; Handle Glow Effect

    ;; Handle Loot Injection
    RealMe.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    If (RealMe.HasKeyword(ActorTypePirate) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
      debugMessage += "I'm a miniboss pirate so injecting 1 random contraband item.\n"
      RealMe.AddItem(LL_Contraband_Any as Form, 1, true)
    ElseIf (RealMe.HasKeyword(ActorTypeZealot) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
      debugMessage += "I'm a miniboss zealot so injecting 0-3 random Va'Ruun Pamphlet item(s).\n"
      RealMe.AddItem(Contraband_VaruunHereticPamphlets as Form, Utility.RandomInt(0, 3), true)
    ElseIf (RealMe.HasKeyword(ActorTypeGang) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
      debugMessage += "I'm a miniboss gang member so injecting 0-6 aurora item(s).\n"
      RealMe.AddItem(Chem_Aurora as Form, Utility.RandomInt(0, 6), true)
    EndIf
  ElseIf(RealMe.HasKeyword(ActorTypePirate) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
    debugMessage += "I'm a " + GetNPCType() + " pirate so injecting 1 random contraband item.\n"
    RealMe.AddItem(LL_Contraband_Any as Form, 1, true)
  ElseIf(RealMe.HasKeyword(ActorTypeZealot) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
    debugMessage += "I'm a " + GetNPCType() + " zealot so injecting 0-3 random Va'Ruun Pamphlet item(s).\n"
    RealMe.AddItem(Contraband_VaruunHereticPamphlets as Form, Utility.RandomInt(0, 3), true)
  ElseIf(RealMe.HasKeyword(ActorTypeGang) && Game.GetDieRollSuccess(30, 1, 100, -1, -1))
    debugMessage += "I'm a " + GetNPCType() + " gang member so injecting 0-6 aurora item(s).\n"
    RealMe.AddItem(Chem_Aurora as Form, Utility.RandomInt(0, 6), true)
  EndIf

  int scaledHealth = Math.Round(playerHealth * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(Health, scaledHealth)
  debugMessage += "Adjusting my Health to " + scaledHealth + " from " + myHealth + " using a scaling factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerHealth + " health.\n"

  int scaledDamageResist = Math.Round(playerDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(DamageResist, scaledDamageResist)
  debugMessage += "Adjusting my Damage Resist stat to " + scaledDamageResist + " from " + myDamageResist + " using a scaling factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerDamageResist + " damage resist.\n"

  int scaledEnergyResist = Math.Round(playerEnergyResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(EnergyResist, scaledEnergyResist)
  debugMessage += "Adjusting my Energy Resist stat to " + scaledEnergyResist + " from " + myEnergyResist + " using a scaling factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerEnergyResist + " energy resist.\n"

  int scaledEMDamageResist = Math.Round(playerEMDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(ElectromagneticDamageResist, scaledEMDamageResist)
  debugMessage += "Adjusting my EM Damage Resist stat to " + scaledEMDamageResist + " from " + myEMDamageResist + " using a scaling factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerEMDamageResist + " EM damage resist.\n"

  Float scaledCriticalHitChance = Math.Round(playerCriticalHitChance * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(CriticalHitChance, scaledCriticalHitChance)
  debugMessage += "Adjusting my EM Damage Resist stat to " + scaledCriticalHitChance + " from " + myCriticalHitChance + " using a scaling factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerCriticalHitChance + " EM damage resist.\n"


  ;; These can't scale with the factor they do too much damage
  Float scaledAttackDamageMult = 1
  Float scaledCriticalHitDamageMult = 1
  If (RealMe.HasKeyword(CombatNPC_Easy))
    scaledAttackDamageMult = 0.80
    scaledCriticalHitDamageMult = 0.80
  ElseIf (RealMe.HasKeyword(CombatNPC_Hard))
    scaledAttackDamageMult = 1.10
    scaledCriticalHitDamageMult = 1.10
  ElseIf (RealMe.HasKeyword(CombatNPC_Miniboss))
    scaledAttackDamageMult = 1.50
    scaledCriticalHitDamageMult = 1.25
  EndIf
  debugMessage += "Adjusting my attack multiplier to " + scaledAttackDamageMult + " from " + myAttackDamageMult + " against the player's " + playerAttackDamageMult + ".\n"
  RealMe.SetValue(AttackDamageMult, scaledAttackDamageMult)
  debugMessage += "Adjusting my critical damage multiplier to " + scaledCriticalHitDamageMult + " from " + myCriticalHitDamageMult + " against the player's " + playerCriticalHitDamageMult + ".\n"
  RealMe.SetValue(CriticalHitDamageMult, scaledCriticalHitDamageMult)

  debugMessage += "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"
  Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "HandleStatScaling", debugMessage, 0, DebugEnabled.GetValueInt())
  DebugLevelScaling("FINAL")
EndFunction


Function DebugLevelScaling(String scalingState)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()
  string debugMessage = "\n\n ********** STAT DEBUG (" + scalingState +  "-" + Myself + ") ********** \n\n"
  debugMessage += "Scaling for a player of level " + playerLevel + " and my level is " + myLevel + ".\n"

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

  int encounterLevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  debugMessage += "Current stats (Encounter Level " + encounterLevel +"):\n"
  debugMessage += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  debugMessage += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  debugMessage += "My/Player Damage Resist: " + myDamageResist + " | " + playerDamageResist + ".\n"
  debugMessage += "My/Player Energy Resist: " + myEnergyResist + " | " + playerEnergyResist + ".\n"
  debugMessage += "My/Player EM Resist: " + myEMDamageResist + " | " + playerEMDamageResist + ".\n"

  debugMessage += "My/Player Radiation Resist: " + myRadiationResist + " | " + playerRadiationResist + ".\n"
  debugMessage += "My/Player Corrosive Resist: " + myCorrosiveResist + " | " + playerCorrosiveResist + ".\n"
  debugMessage += "My/Player Airborne Resist: " + myAirborneResist + " | " + playerAirborneResist + ".\n"
  debugMessage += "My/Player Thermal Resist: " + myThermalResist + " | " + playerThermalResist + ".\n"

  debugMessage += "My/Player Reflect Damage: " + myReflectDamage + " | " + playerReflectDamage + ".\n"
  debugMessage += "My/Player Critical Hit Chance: " + myCriticalHitChance + " | " + playerCriticalHitChance + ".\n"
  debugMessage += "My/Player Critical Hit Damage Multiplier: " + myCriticalHitDamageMult + " | " + playerCriticalHitDamageMult + ".\n"
  debugMessage += "My/Player Attack Damage Multiplier: " + myAttackDamageMult + " | " + playerAttackDamageMult + ".\n"

  debugMessage += "\n************************************************************\n\n"
  Log(ModName, "Venworks:ScaleTheWorld:StatScalerScript", "DebugLevelScaling-" + scalingState, debugMessage, 0, DebugEnabled.GetValueInt())
EndFunction

String Function GetNPCType()
  If (RealMe.HasKeyword(CombatNPC_Easy))
    Return "Easy"
  ElseIf (RealMe.HasKeyword(CombatNPC_Normal))
    Return "Normal"
  ElseIf (RealMe.HasKeyword(CombatNPC_Hard))
    Return "Hard"
  ElseIf (RealMe.HasKeyword(CombatNPC_Miniboss))
    Return "Miniboss"
  ElseIf (RealMe.HasKeyword(CombatNPC_Legendary))
    Return "Legendary"
  Else
    Return "Unknown"
  EndIf
EndFunction