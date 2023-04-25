Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Dice class >> validateInitialization: anAmount [
	anAmount > 2 ifFalse: [ 
		Error signal: 'Cannot create dice with 2 or less amount of faces' ]
]

{ #category : #initialize }
Dice class >> with: aNumberFaces [
	self validateInitialization: aNumberFaces. 
	^(self new) initializeWith: aNumberFaces .
]

{ #category : #'instance variables' }
Dice >> faces [
	^ faces
]

{ #category : #'instance creation' }
Dice >> initializeWith: aNumberOfFaces [ 
	faces := aNumberOfFaces.
]

{ #category : #actions }
Dice >> throw [
	^(1 to: faces) atRandom.
]
