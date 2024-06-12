ScriptName Venworks:Shared:ApplySpellToTarget extends ActiveMagicEffect  

Import Venworks:Shared:Logging

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property DebugEnabled Auto Const Mandatory
String Property ModName="VenworksShared" Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Spell Property AbilityToApply Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  Actor target = akTarget.GetSelfAsActor()
	target.AddSpell(AbilityToApply, false)
  Log(ModName, "Venworks:Shared:ApplySpellToTarget", "OnEffectStart", "Added ability with form ID " + AbilityToApply + " to target with form ID " + target + ".", 0, DebugEnabled.GetValueInt())
EndEvent