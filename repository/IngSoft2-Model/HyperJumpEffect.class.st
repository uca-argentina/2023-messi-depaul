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
HyperJumpEffect class >> with: aSequenceOfParsecs [ 
	^(self new) initializeWith: aSequenceOfParsecs.
]

{ #category : #action }
HyperJumpEffect >> implementOn: aBoardGame [

	| value |
	value := parsecsValues at: parsecIndex.
	parsecIndex := parsecIndex \\ parsecsValues size + 1.

	aBoardGame applyHyperJumpEffect: value
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
HyperJumpEffect >> initializeWith: aSequenceOfParsecs [
	parsecsValues:= aSequenceOfParsecs .
	parsecIndex:= 1.
]
