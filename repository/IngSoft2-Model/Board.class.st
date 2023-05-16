Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds',
		'parsecs',
		'cellsEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	^ (self new) initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs.
]

{ #category : #initialization }
Board >> initializeCellsEffects [
	| aNoEffect aNoEffectProbability aSpeedUpEffect aSpeedUpEffectProbability allEffectsProbability size allEffects |
	size := 0.
	allEffects := OrderedCollection new.
	aNoEffect := NoEffect new.
	aNoEffectProbability := OrderedCollection new.
	aNoEffectProbability add: aNoEffect.
	aNoEffectProbability add: 0.4.
	
	aSpeedUpEffect := SpeedUpEffect new.
	aSpeedUpEffectProbability := OrderedCollection new.
	aSpeedUpEffectProbability add: aSpeedUpEffect.
	aSpeedUpEffectProbability add: 0.4.
	
	allEffectsProbability := OrderedCollection new.
	allEffectsProbability add: aNoEffectProbability.
	allEffectsProbability add: aSpeedUpEffectProbability.
	
	allEffects add: aSpeedUpEffect.
	allEffects add: aNoEffect.
	
	cellsEffects := OrderedCollection new. 

	
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	amountOfCells := anAmountOfCells.
	rounds := anAmountOfRounds.
	parsecs := anAmountOfParsecs.
	self initializeCellsEffects.
]
