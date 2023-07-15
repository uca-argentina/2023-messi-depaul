Class {
	#name : #CardPlayers,
	#superclass : #Object,
	#instVars : [
		'card',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayers class >> of: aCard with: spaceships [
	^(self new) initializeOf: aCard with: spaceships.
]

{ #category : #'instance creation' }
CardPlayers >> cards [
	^ card.
]

{ #category : #'instance creation' }
CardPlayers >> initializeOf: aCard with: amountOfSpaceships [

	card := aCard.
	spaceships := amountOfSpaceships.
]

{ #category : #'instance creation' }
CardPlayers >> spaceships [
	^ spaceships
]
