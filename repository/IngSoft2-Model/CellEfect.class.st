Class {
	#name : #CellEfect,
	#superclass : #Object,
	#instVars : [
		'number',
		'effect'
	],
	#classInstVars : [
		'number',
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CellEfect class >> on: aCellNumber of: anEffect [
	^(self new) initializeOf: aCellNumber and: anEffect.
]

{ #category : #'instance creation' }
CellEfect >> effect [
	^ effect
]

{ #category : #'instance creation' }
CellEfect >> initializeOf: aCellNumber and: anEffect [
	number := aCellNumber.
	effect := anEffect.
]

{ #category : #'instance variable' }
CellEfect >> number [
	^ number
]
