Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecsValues',
		'parsecIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
HyperJumpEffect class >> with: anAmountOfParsecs [ 
	^(self new) initializeWith: anAmountOfParsecs.
]

{ #category : #action }
HyperJumpEffect >> implementTo: spaceshipsPositions of: aName [

	| aSpaceshipPosition value |
	value := parsecsValues at: parsecIndex.
	parsecIndex := parsecIndex \\ parsecsValues size + 1.

	aSpaceshipPosition := spaceshipsPositions detect: [ 
		                      :spaceshipPosition | 
		                      spaceshipPosition spaceship == aName ].

	aSpaceshipPosition changeParsec: value.
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeWith: anAmountOfParsecs [
	parsecsValues:= anAmountOfParsecs .
	parsecIndex:= 1.
]
