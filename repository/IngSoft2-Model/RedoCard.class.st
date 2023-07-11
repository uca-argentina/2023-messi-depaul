Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 
	
	aBoardGame validateRedoCard
]

{ #category : #'instance variable' }
RedoCard >> id [
	^cardId 
]

{ #category : #action }
RedoCard >> id: number [ 
	cardId:= number.
]

{ #category : #action }
RedoCard >> playOn: aCroupier to: aCardPlayers [

	| lastCardPlayers |
	lastCardPlayers := CardPlayers
		                   of: aCroupier lastCardPlayed
		                   with: aCardPlayers spaceships.

	aCroupier play: lastCardPlayers
]

{ #category : #action }
RedoCard >> playOn: aCroupier toSelected: aCardId [ 
	aCroupier cancellationCardTo: aCardId
]
