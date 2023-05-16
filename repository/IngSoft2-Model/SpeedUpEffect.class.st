Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> implementTo: spaceshipsPositions of: aName [

	| aSpaceshipPosition |
	aSpaceshipPosition := spaceshipsPositions detect: [ 
		                      :spaceshipPosition | 
		                      spaceshipPosition spaceship == aName ].
	aSpaceshipPosition changePosition: aSpaceshipPosition position + 4
]
