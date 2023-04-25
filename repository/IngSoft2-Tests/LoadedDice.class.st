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
LoadedDice class >> validateInitialization: aSequence [
	(aSequence anySatisfy: [:value | value <= 0]) ifTrue: [ 
		Error signal: 'Cannot create dice with value less than 0' ].
]

{ #category : #initialize }
LoadedDice class >> with: aSequence [
	self validateInitialization: aSequence.
	^(self new) initializeWith: aSequence.
]

{ #category : #'instance creation' }
LoadedDice >> initializeWith: aSequence [
	sequence:= aSequence.
	sequenceIndex := 1.
	
	
]

{ #category : #'instance variables' }
LoadedDice >> sequence [
	^ sequence
]

{ #category : #action }
LoadedDice >> throw [
	|value|
        value := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.
        ^ value.
]
