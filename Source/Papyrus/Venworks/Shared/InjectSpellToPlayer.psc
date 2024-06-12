ScriptName Venworks:Shared:InjectSpellToPlayer extends Quest

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
Actor Property PlayerRef Auto Const Mandatory
Spell Property SpellToEnable Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  Log(ModName, "Venworks:Shared:InjectSpellToPlayer", "OnQuestInit", "Spell " + SpellToEnable + " added to player.", 0, DebugEnabled.GetValueInt())
  PlayerRef.AddSpell(SpellToEnable, false)
EndEvent