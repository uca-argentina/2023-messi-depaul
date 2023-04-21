Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'faces',
		'sequence',
		'sequenceIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialize }
LoadedDice class >> with: aNumberFaces andWith: aSequence [
	^(self new) initializeWith: aNumberFaces andWith: aSequence .
]

{ #category : #'instance variables' }
LoadedDice >> faces [
	^ faces
]

{ #category : #'instance creation' }
LoadedDice >> initializeWith: aNumberOfFaces andWith: aSequence [ 
	faces:= aNumberOfFaces .
	sequence:= aSequence .
	sequenceIndex := 1.
	
]

{ #category : #action }
LoadedDice >> throw [
	|result|
        result := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.

        ^ result.
]
