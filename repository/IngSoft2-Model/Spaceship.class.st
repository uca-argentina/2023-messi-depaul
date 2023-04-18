Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spaceship class >> withPosition: aPosition [
	^(self new) initializeWith: aPosition .
]

{ #category : #adding }
Spaceship >> advanceAnAmountOfCells: anAmountOfCells [ 
	position:= position + anAmountOfCells.
]

{ #category : #'instance creation' }
Spaceship >> initializeWith: aPosition [ 
	position := aPosition .
]

{ #category : #'tests - validation' }
Spaceship >> isValid [
	^true.
]

{ #category : #'instance variables' }
Spaceship >> whereIsMyPosition [
	^position .
]
