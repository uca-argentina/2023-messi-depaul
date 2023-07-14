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

{ #category : #action }
AccelerationCard >> playOn: aCroupier [ 
	self shouldBeImplemented.
]

{ #category : #action }
AccelerationCard >> playOn: aCroupier to: aCardPlayers [ 
	aCroupier recordPermanent: aCardPlayers
]

{ #category : #action }
AccelerationCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'You cannot choose a player for acceleration card.'
]
