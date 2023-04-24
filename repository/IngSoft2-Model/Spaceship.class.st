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

{ #category : #'instance initialization' }
Spaceship >> initializeInPositionZero [
	position := 0.
]

{ #category : #'tests - validation' }
Spaceship >> isValid [
	^true.
]

{ #category : #'instance variables' }
Spaceship >> position [
	^position .
]

{ #category : #adding }
Spaceship >> updatePosition: newPosition [
	position:= newPosition.
]
