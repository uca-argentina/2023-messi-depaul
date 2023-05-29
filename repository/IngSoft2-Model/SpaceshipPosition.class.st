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

{ #category : #initialization }
SpaceshipPosition class >> named: spaceshipName on: aPosition at: aRound [ 
	^(self new)  initializeNamed: spaceshipName on: aPosition at: aRound.
]

{ #category : #'instance creation' }
SpaceshipPosition class >> of: aSpaceship with: aPositionNumber [
	^(self new) initializeWith: aSpaceship and: aPositionNumber.
]

{ #category : #action }
SpaceshipPosition >> changePosition: newPosition [
	position:= newPosition.
]

{ #category : #action }
SpaceshipPosition >> changeRound: aNum [
	round:= round + aNum.
]

{ #category : #'instance creation' }
SpaceshipPosition >> initializeNamed: spaceshipName on: aPosition at: aRound [ 
	spaceship:= spaceshipName.
	position := aPosition.
	round := aRound.
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
