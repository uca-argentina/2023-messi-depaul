Class {
	#name : #SpaceshipCard,
	#superclass : #Object,
	#instVars : [
		'spaceship',
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
SpaceshipCard >> initializeNamed: aSpaceship with: aCard [ 
	spaceship:= aSpaceship .
	card:= aCard.
]

{ #category : #'instance variable' }
SpaceshipCard >> spaceship [
	^ spaceship
]
