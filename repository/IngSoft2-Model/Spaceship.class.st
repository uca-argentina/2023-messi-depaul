Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Spaceship class >> whereIsMyPosition [
	self shouldBeImplemented.
]

{ #category : #initialization }
Spaceship class >> withPosition: aPosition [
	^(self new) initializeWith: aPosition .
]

{ #category : #'instance creation' }
Spaceship >> initializeWith: aPosition [ 
	position := aPosition .
]

{ #category : #'tests - validation' }
Spaceship >> isValid [
	^true.
]
