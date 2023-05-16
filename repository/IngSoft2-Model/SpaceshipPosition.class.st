Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'position',
		'round',
		'parsec'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> of: aSpaceship with: aPositionNumber [
	^(self new) initializeWith: aSpaceship and: aPositionNumber.
]

{ #category : #action }
SpaceshipPosition >> changeParsec: aNum [ 
	parsec := aNum.
]

{ #category : #action }
SpaceshipPosition >> changePosition: newPosition [
	position:= newPosition.
]

{ #category : #action }
SpaceshipPosition >> changeRound: aNum [
	round:= round + aNum.
]

{ #category : #initialization }
SpaceshipPosition >> initializeWith: aSpaceship and: aPositionNumber [ 
	spaceship := aSpaceship.
	position := aPositionNumber.
	round:= 1.
	parsec:= 1.
]

{ #category : #'instance variable' }
SpaceshipPosition >> parsec [
	^ parsec
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
