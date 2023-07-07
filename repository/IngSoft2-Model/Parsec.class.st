Class {
	#name : #Parsec,
	#superclass : #Object,
	#instVars : [
		'quantity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Parsec class >> of: aQuantity [ 
	^(self new) initializeOf: aQuantity .
]

{ #category : #'instance creation' }
Parsec >> initializeOf: aQuantity [
	quantity := aQuantity.
]

{ #category : #action }
Parsec >> parsecs [
	^self.
]

{ #category : #'instance variable' }
Parsec >> quantity [
	^quantity .
]
