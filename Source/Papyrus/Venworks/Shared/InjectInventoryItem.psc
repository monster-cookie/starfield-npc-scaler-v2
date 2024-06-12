ScriptName Venworks:Shared:InjectInventoryItem extends Quest

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
Form Property ItemToInject Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  VPI_Debug.DebugMessage(ModName, "Venworks:Shared:InjectInventoryItem", "OnQuestInit", "OnQuestInit triggered.", 0, DebugEnabled.GetValueInt())
  If PlayerRef.GetItemCount(ItemToInject) <= 0
    PlayerRef.AddItem(ItemToInject, 1, false)
    VPI_Debug.DebugMessage(ModName, "Venworks:Shared:InjectInventoryItem", "OnQuestInit", "Item added to player inventory.", 0, DebugEnabled.GetValueInt())
  EndIf
EndEvent