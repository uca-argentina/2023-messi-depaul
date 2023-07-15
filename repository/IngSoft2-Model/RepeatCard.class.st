Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 

]

{ #category : #'instance variable' }
RepeatCard >> id [

	^ cardId
]

{ #category : #'instance variable' }
RepeatCard >> id: number [

	cardId := number
]

{ #category : #'instance variables' }
RepeatCard >> name [

	^ 'repeat'
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame to: aCardPlayers [

	aBoardGame repeatCardTo: (aCardPlayers spaceships at: 1)
]

{ #category : #action }
RepeatCard >> playOn: aCroupier toSelected: aSpeedCard [ 
	Error signal: 'To play card, choose a player'.
]
