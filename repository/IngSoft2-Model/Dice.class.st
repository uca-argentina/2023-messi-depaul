Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Dice class >> with: aNumberFaces [
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
