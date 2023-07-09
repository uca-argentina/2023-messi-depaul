Class {
	#name : #DeckOfCards,
	#superclass : #Object,
	#instVars : [
		'cards',
		'indexCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeckOfCards class >> with: anAmountOfCards [ 
	^(self new) initializeWith: anAmountOfCards.
]

{ #category : #'instance variable' }
DeckOfCards >> card [
	^ cards
]

{ #category : #initialization }
DeckOfCards >> initializeCards [
	cards do: [ :card | card id: indexCard.
		indexCard:= indexCard + 1. ]
]

{ #category : #'instance creation' }
DeckOfCards >> initializeWith: anAmountOfCards [ 
	cards:= anAmountOfCards.
	indexCard := 1.
	self initializeCards.
	
]
