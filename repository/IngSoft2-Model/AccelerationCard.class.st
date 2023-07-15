Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> canBePlayedIn: aBoardGame for: aSpaceship [

	aBoardGame validatePermanentPlayFor: aSpaceship
]

{ #category : #'instance variable' }
AccelerationCard >> id [
	^cardId 
]

{ #category : #'instance variable' }
AccelerationCard >> id: number [ 
	cardId:= number.
]

{ #category : #action }
AccelerationCard >> implementOn: aBoardGame [ 
	^1
]

{ #category : #'instance variables' }
AccelerationCard >> name [
	'acceleration'.
]

{ #category : #action }
AccelerationCard >> playOn: aCroupier to: aCardPlayers [ 
	Error signal: 'You cannot choose a player for acceleration card.'
]

{ #category : #action }
AccelerationCard >> playOn: aCroupier toAll: aCardPlayers [ 
	aCroupier recordPermanent: aCardPlayers
]

{ #category : #action }
AccelerationCard >> playOn: aBoardGame toSelected: aCard [ 
	
	Error signal: 'You cannot choose a card for acceleration card.'
]
