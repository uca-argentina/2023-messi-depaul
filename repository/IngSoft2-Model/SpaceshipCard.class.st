Class {
	#name : #SpaceshipCard,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceshipCard class >> named: aSpaceship with: aCard [ 
	^(self new) initializeNamed: aSpaceship with: aCard.
]

{ #category : #'instance variable' }
SpaceshipCard >> card [
	^ card
]

{ #category : #'instance creation' }
SpaceshipCard >> initializeNamed: aSpaceshipCollection with: aCard [ 
	spaceships:= aSpaceshipCollection.
	card:= aCard.
]

{ #category : #'instance variable' }
SpaceshipCard >> spaceships [
	^ spaceships
]
