Class {
	#name : #ProbabilityEffects,
	#superclass : #Object,
	#instVars : [
		'effect',
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ProbabilityEffects class >> of: aEffect [ 
	^(self new) initializeOf: aEffect .
]

{ #category : #'instance creation' }
ProbabilityEffects >> initializeOf: aEffect [ 
	effect:= aEffect.
	amount:= 0.
]
