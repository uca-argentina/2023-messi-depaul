Class {
	#name : #Cell,
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
Cell class >> on: aCellNumber of: anEffect [

	^ self new initializeOf: aCellNumber and: anEffect
]

{ #category : #'instance variable' }
Cell >> effect [

	^ effect
]

{ #category : #'instance creation' }
Cell >> initializeOf: aCellNumber and: anEffect [

	number := aCellNumber.
	effect := anEffect
]

{ #category : #'instance variable' }
Cell >> number [

	^ number
]
