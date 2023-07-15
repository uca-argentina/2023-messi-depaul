Class {
	#name : #PlayerCards,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
PlayerCards class >> of: aSpaceship [ 
	^(self new) of: aSpaceship.
]

{ #category : #'instance variables' }
PlayerCards >> cards [

	^ cards
]

{ #category : #action }
PlayerCards >> obtainCard: cardId [

	| aCard |
	aCard := cards
		         detect: [ :card | card id = cardId ]
		         ifNone: [ Error signal: 'You do not have that card' ].
	^ aCard
]

{ #category : #'instance creation' }
PlayerCards >> of: aSpaceship [

	spaceship := aSpaceship.
	cards := OrderedCollection new
]

{ #category : #action }
PlayerCards >> removeCard: cardId [

	| aCard |
	aCard := self obtainCard: cardId.
	cards remove: aCard
]

{ #category : #'instance variables' }
PlayerCards >> spaceships [

	^ spaceship
]
