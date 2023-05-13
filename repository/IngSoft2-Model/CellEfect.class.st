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

{ #category : #action }
CellEfect >> applyAEffect: aSpaceshipPosition [ 
	effect applyFor: aSpaceshipPosition.
]

{ #category : #action }
CellEfect >> applyAEffect: aSpaceshipPosition and: anAmountOfCells [ 
	effect applyFor: aSpaceshipPosition and: anAmountOfCells.
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
