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

{ #category : #adding }
ProbabilityEffects >> addOneAmount [
	amount := amount + 1.
]

{ #category : #'instance creation' }
ProbabilityEffects >> amount [
	^ amount
]

{ #category : #'instance variable' }
ProbabilityEffects >> effect [
	^effect.
]

{ #category : #'instance creation' }
ProbabilityEffects >> initializeOf: aEffect [ 
	effect:= aEffect.
	amount:= 0.
]
