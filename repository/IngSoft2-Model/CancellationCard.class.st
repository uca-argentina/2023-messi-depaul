Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> byTurn [

	^ false
]

{ #category : #'instance variable' }
CancellationCard >> name [
	^'cancellation'.
]

{ #category : #action }
CancellationCard >> playOn: aBoardGame to: aSpaceshipCard [ 
	aBoardGame throwCancellationCardTo: aSpaceshipCard 
]
