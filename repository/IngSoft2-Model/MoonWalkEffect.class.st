Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffect class >> with: aNumber [ 
	^(self new) initializeWith: aNumber.
]

{ #category : #action }
MoonWalkEffect >> implementTo: spaceshipsPositions of: aName [
		
	1 to:spaceshipsPositions size do: [:position | 
		|spaceshipPosition| 
		spaceshipPosition:= spaceshipsPositions at: position.
		(spaceshipPosition spaceship ~= aName)ifTrue: [ 
			spaceshipPosition changePosition:
				spaceshipPosition position - number ]ifFalse:[] ].
]

{ #category : #'instance creation' }
MoonWalkEffect >> initializeWith: aNumber [ 
	number := aNumber.
]
