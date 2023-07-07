Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'jumps',
		'jumpsIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
HyperJumpEffect class >> with: aSequenceOfJumps [

	^ self new initializeWith: aSequenceOfJumps
]

{ #category : #action }
HyperJumpEffect >> implementOn: aBoardGame [

	| value |
	value := jumps at: jumpsIndex .
	jumpsIndex := jumpsIndex \\ jumps size + 1.
	
	aBoardGame applyHyperJumpEffect: (value parsecs quantity).
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeWith: aSequenceOfJumps [

	jumps := aSequenceOfJumps.
	jumpsIndex := 1
]
