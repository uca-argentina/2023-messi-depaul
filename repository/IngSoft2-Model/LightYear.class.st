Class {
	#name : #LightYear,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
LightYear class >> withValue: aNumber [ 
	^(self new) initializeWithValue: aNumber.
]

{ #category : #'instance creation' }
LightYear >> initializeWithValue: aNumber [ 
	number := aNumber.
]

{ #category : #action }
LightYear >> parsecs [
	^Parsec withValue: (number//3).
]
