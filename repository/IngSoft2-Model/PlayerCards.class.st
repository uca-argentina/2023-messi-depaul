Class {
	#name : #PlayerCards,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
PlayerCards class >> named: aString with: aSpeedCard [ 
	self shouldBeImplemented.
]

{ #category : #initialize }
PlayerCards class >> of: aSpaceship [ 
	^(self new) of: aSpaceship.
]

{ #category : #'instance variables' }
PlayerCards >> cards [
	^ cards
]

{ #category : #'instance creation' }
PlayerCards >> of: aSpaceship [
	spaceship:= aSpaceship.
	cards := OrderedCollection new.
]

{ #category : #'instance variable' }
PlayerCards >> spaceship [
	^ spaceship
]
