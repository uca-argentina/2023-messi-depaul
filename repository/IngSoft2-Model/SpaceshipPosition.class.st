Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> of: aSpaceship with: aPositionNumber [
	^(self new) initializeWith: aSpaceship and: aPositionNumber.
]

{ #category : #action }
SpaceshipPosition >> change: aNumber [
	position := position + aNumber.
]

{ #category : #initialization }
SpaceshipPosition >> initializeWith: aSpaceship and: aPositionNumber [ 
	spaceship := aSpaceship.
	position := aPositionNumber.
]

{ #category : #'instance variable' }
SpaceshipPosition >> position [
	^ position
]

{ #category : #'instance variables' }
SpaceshipPosition >> spaceship [
	^spaceship
]
