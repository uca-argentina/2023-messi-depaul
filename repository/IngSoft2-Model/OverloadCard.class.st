Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> canBePlayedIn: aBoardGame for: aSpaceship [

	aBoardGame validatePermanentPlayFor: aSpaceship
]

{ #category : #'instance variable' }
OverloadCard >> id [

	^ cardId
]

{ #category : #initialization }
OverloadCard >> id: number [ 

	cardId:= number.
]

{ #category : #action }
OverloadCard >> implementOn: aBoardGame [

	^ -2
]

{ #category : #'instance variables' }
OverloadCard >> name [

	^'overload'.
]

{ #category : #action }
OverloadCard >> playOn: aCroupier to: aCardPlayers [

	aCroupier recordPermanent: aCardPlayers
]

{ #category : #action }
OverloadCard >> playOn: aCroupier toAll: aCardPlayers [

	Error signal: 'To play card, choose a player'
]

{ #category : #action }
OverloadCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'To play card, choose a player' .
]
