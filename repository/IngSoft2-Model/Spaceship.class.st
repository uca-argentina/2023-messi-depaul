Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Spaceship class >> startsInPositionZero [
	^(self new) initializeInPositionZero.
]

{ #category : #adding }
Spaceship >> advanceAnAmountOfCells: anAmountOfCells [ 
	position:= position + anAmountOfCells.
]

{ #category : #'instance initialization' }
Spaceship >> initializeInPositionZero [
	position := 0.
]

{ #category : #'tests - validation' }
Spaceship >> isValid [
	^true.
]

{ #category : #update }
Spaceship >> movesForward: anAmountOfCells [ 
	^ (position := position + anAmountOfCells).
]

{ #category : #'instance variables' }
Spaceship >> position [
	^position .
]
