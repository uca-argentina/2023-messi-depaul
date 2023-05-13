Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'position',
		'round'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> of: aSpaceship with: aPositionNumber [
	^(self new) initializeWith: aSpaceship and: aPositionNumber.
]

{ #category : #action }
SpaceshipPosition >> change: aNumber and: anAmountOfCells [

	| moveAmount |
	moveAmount := position + aNumber.

	moveAmount > anAmountOfCells
		ifTrue: [ 
			[ moveAmount > anAmountOfCells ] whileTrue: [ 
				round := round + 1.
				moveAmount := moveAmount - anAmountOfCells ].

			position := position + aNumber % anAmountOfCells.
			position = 0 ifTrue: [ position := 1 ] ]
		ifFalse: [ position := position + aNumber ]
]

{ #category : #initialization }
SpaceshipPosition >> initializeWith: aSpaceship and: aPositionNumber [ 
	spaceship := aSpaceship.
	position := aPositionNumber.
	round:= 1.
]

{ #category : #'instance variable' }
SpaceshipPosition >> position [
	^ position
]

{ #category : #'instance variable' }
SpaceshipPosition >> round [
	^round.
]

{ #category : #'instance variables' }
SpaceshipPosition >> spaceship [
	^spaceship
]

{ #category : #action }
SpaceshipPosition >> winner: aRound [
	position:= 1.
	round := aRound + 1.
]
