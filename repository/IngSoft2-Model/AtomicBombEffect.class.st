Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> implementTo: spaceshipsPositions of: aName [ 
	spaceshipsPositions do: [ :spaceshipPosition | spaceshipPosition changePosition: 1 ]
]
