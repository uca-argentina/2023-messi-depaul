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
	^(self new) creation.
]

{ #category : #'instance initialization' }
Spaceship >> creation [
	position := 0.
]

{ #category : #'instance variables' }
Spaceship >> position [
	^position .
]

{ #category : #adding }
Spaceship >> updatePosition: newPosition [
	position:= position + newPosition.
]
