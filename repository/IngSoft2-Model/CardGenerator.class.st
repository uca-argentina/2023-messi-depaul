Class {
	#name : #CardGenerator,
	#superclass : #Object,
	#instVars : [
		'amountOfCards',
		'speeds',
		'overloads',
		'accelerations',
		'cancellations',
		'redos',
		'repeats'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
CardGenerator class >> setWithCards: aNumber [ 
	^(self new) initializeWithCards: aNumber.
]

{ #category : #'instance variable' }
CardGenerator >> accelerations [
	^ accelerations
]

{ #category : #'instance variable' }
CardGenerator >> cancellations [
	^ cancellations
]

{ #category : #initialize }
CardGenerator >> initializeDeck [
	1 to: amountOfCards do: [ :index | 
		| aNumber |
		aNumber := 60 atRandom.
		(aNumber > 0 and: aNumber <= 10) ifTrue: [ 
			speeds := speeds + 1 ].
		(aNumber > 10 and: aNumber <= 20) ifTrue: [ 
			overloads := overloads + 1 ].
		(aNumber > 20 and: aNumber <= 30) ifTrue: [ 
			accelerations := accelerations + 1 ].
		(aNumber > 30 and: aNumber <= 40) ifTrue: [ 
			cancellations := cancellations + 1 ].
		(aNumber > 40 and: aNumber <= 50) ifTrue: [ 
			redos := redos + 1 ].
		(aNumber > 50 and: aNumber <= 60) ifTrue: [ 
			repeats := repeats + 1 ] ]
]

{ #category : #'instance creation' }
CardGenerator >> initializeWithCards: aNumber [
	amountOfCards := aNumber.
	speeds := 0.
	overloads := 0.
	accelerations := 0.
	cancellations := 0.
	redos := 0.
	repeats := 0.
	self initializeDeck.
	
]

{ #category : #'instance variable' }
CardGenerator >> overloads [
	^ overloads
]

{ #category : #'instance variable' }
CardGenerator >> redos [
	^ redos
]

{ #category : #'instance variable' }
CardGenerator >> repeats [
	^ repeats
]

{ #category : #'instance variable' }
CardGenerator >> speeds [
	^ speeds
]
