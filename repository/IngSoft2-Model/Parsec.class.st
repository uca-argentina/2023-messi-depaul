Class {
	#name : #Parsec,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Parsec class >> withValue: aNumber [ 
	^(self new) initializeWithValue: aNumber.
]

{ #category : #'instance creation' }
Parsec >> initializeWithValue: aNumber [ 
	number := aNumber.
]

{ #category : #'instance variable' }
Parsec >> number [
	^number.
]

{ #category : #action }
Parsec >> parsecs [
	^self.
]
