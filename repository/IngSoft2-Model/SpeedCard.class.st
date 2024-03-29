Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> canBePlayedIn: aBoardGame for: aSpaceship [

	aBoardGame validatePermanentPlayFor: aSpaceship
]

{ #category : #'instance variable' }
SpeedCard >> id [

	^ cardId
]

{ #category : #initialization }
SpeedCard >> id: number [

	cardId := number
]

{ #category : #action }
SpeedCard >> implementOn: aBoardGame [

	^ 1
]

{ #category : #'instance variable' }
SpeedCard >> name [

	^ 'speed'
]

{ #category : #action }
SpeedCard >> playOn: aCroupier to: aCardPlayers [

	aCroupier recordPermanent: aCardPlayers
]

{ #category : #validation }
SpeedCard >> playOn: aCroupier toAll: aCardPlayers [

	Error signal: 'To play card, choose a player'
]

{ #category : #action }
SpeedCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'To play card, choose a player'.
]
