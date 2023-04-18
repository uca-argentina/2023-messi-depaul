Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceshipPosition class >> withPosition: aPosition [ 
	^(self new) initializeWith: aPosition .
]

{ #category : #'instance creation' }
SpaceshipPosition >> initializeWith: aPosition [ 
	position:= aPosition .
]
