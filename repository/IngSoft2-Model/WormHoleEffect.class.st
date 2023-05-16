Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHoleEffect >> implementTo: spaceshipsPositions of: aName [
	|aSpaceshipPosition|
	aSpaceshipPosition:= spaceshipsPositions detect: [ 
		                      :spaceshipPosition | 
		                      spaceshipPosition spaceship == aName ].
	aSpaceshipPosition changePosition: aSpaceshipPosition position - 4.
]
