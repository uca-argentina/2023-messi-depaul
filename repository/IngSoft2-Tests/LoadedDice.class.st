Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'faces',
		'sequence',
		'sequenceIndex',
		'aCollectionOfLoadedDices'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialize }
LoadedDice class >> validateAnAmountOfFaces: anAmount [
	anAmount > 2 ifFalse: [ 
		Error signal: 'Cannot create dice with 2 or less amount of faces' ]
]

{ #category : #initialize }
LoadedDice class >> with: aNumberFaces [
	self validateAnAmountOfFaces: aNumberFaces.
	^(self new) initializeWith: aNumberFaces.
]

{ #category : #'instance variables' }
LoadedDice >> faces [
	^ faces
]

{ #category : #'instance creation' }
LoadedDice >> initializeWith: aNumberOfFaces [
	faces:= aNumberOfFaces .
	sequence:= #(1 2 3) .
	sequenceIndex := 1.
	aCollectionOfLoadedDices:= OrderedCollection new.
	
	
]

{ #category : #action }
LoadedDice >> throw [
	|value|
        value := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.
        ^ value.
]
