Class {
	#name : #LightYear,
	#superclass : #Object,
	#instVars : [
		'quantity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
LightYear class >> of: aQuantity [ 
	^(self new) initializeOf: aQuantity.
]

{ #category : #'instance creation' }
LightYear >> initializeOf: aQuantity [
	quantity := aQuantity.
]

{ #category : #action }
LightYear >> parsecs [
	^Parsec of: (quantity//3).
]
