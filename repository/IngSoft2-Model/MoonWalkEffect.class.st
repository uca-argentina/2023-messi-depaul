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

	^ self new initializeWith: aNumber
]

{ #category : #action }
MoonWalkEffect >> implementOn: aBoardGame [

	aBoardGame applyMoonWalkEffect: number
]

{ #category : #'instance creation' }
MoonWalkEffect >> initializeWith: aNumber [

	number := aNumber
]
