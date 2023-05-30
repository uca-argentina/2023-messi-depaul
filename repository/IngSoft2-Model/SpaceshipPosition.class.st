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

	^ self new initializeNamed: spaceshipName on: aPosition at: aRound
]

{ #category : #'instance creation' }
SpaceshipPosition >> initializeNamed: spaceshipName on: aPosition at: aRound [

	spaceship := spaceshipName.
	position := aPosition.
	round := aRound
]

{ #category : #'instance variables' }
SpaceshipPosition >> position [

	^ position
]

{ #category : #'instance variables' }
SpaceshipPosition >> round [

	^ round
]

{ #category : #'instance variables' }
SpaceshipPosition >> spaceship [

	^ spaceship
]
