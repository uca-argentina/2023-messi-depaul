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
LoadedDice class >> validateAValue: aSequence [
	(aSequence allSatisfy: [:value | value == 0]) ifTrue: [ 
		Error signal: 'Cannot create dice with value 0' ]
]

{ #category : #initialize }
LoadedDice class >> validateAnAmountOfFaces: anAmount [
	anAmount > 2 ifFalse: [ 
		Error signal: 'Cannot create dice with 2 or less amount of faces' ]
]

{ #category : #initialize }
LoadedDice class >> with: aNumberFaces andWith: aSequence [
	self validateAnAmountOfFaces: aNumberFaces. 
	self validateAValue: aSequence. 
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
	|value|
        value := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.
        ^ value.
]
