Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Die class >> of: aNumberOfFaces [
	self validateExistsWith: aNumberOfFaces. 
	^(self new) initializeWith: aNumberOfFaces .
]

{ #category : #initialize }
Die class >> validateExistsWith: aNumberOfFaces [
	aNumberOfFaces > 2 ifFalse: [ 
		Error signal: 'Cannot create die with 2 or less amount of faces' ]
]

{ #category : #'instance variables' }
Die >> faces [
	^ faces
]

{ #category : #'instance creation' }
Die >> initializeWith: aNumberOfFaces [ 
	faces := aNumberOfFaces.
]

{ #category : #actions }
Die >> throw [
	^faces atRandom.
]
