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
	^cardId 
]

{ #category : #'instance variable' }
RepeatCard >> id: number [ 
	cardId:= number.
]

{ #category : #action }
RepeatCard >> playOn: aCroupier [ 
	aCroupier repeatCard.
]

{ #category : #action }
RepeatCard >> playOn: aCroupier to: aCardPlayers [ 
	aCroupier repeatCardTo: aCardPlayers.
]
