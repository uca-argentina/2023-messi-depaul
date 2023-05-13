Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect class >> applyFor: aSpaceshipPosition [ 
	self shouldBeImplemented.
]

{ #category : #action }
SpeedUpEffect class >> applyFor: aSpaceshipPosition and: anAmountOfCells [. 
	aSpaceshipPosition change: 4 and:  anAmountOfCells.
]
