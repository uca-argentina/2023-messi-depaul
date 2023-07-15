Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'cell',
		'round'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> on: aCellNumber at: aRound [ 
	^(self new) initializeOn: aCellNumber at: aRound
]

{ #category : #'instance variable' }
Position >> cellNumber [
	^ cell.
]

{ #category : #'instance creation' }
Position >> initializeOn: aCellNumber at: aRound [ 
	cell := aCellNumber.
	round := aRound.
]

{ #category : #'instance variable' }
Position >> round [
 ^round
]
