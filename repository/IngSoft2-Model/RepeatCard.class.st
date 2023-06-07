Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> byTurn [
	^false.
]

{ #category : #'instance variable' }
RepeatCard >> name [
	^ 'repeat'.
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame [ 
	aBoardGame throwRepeatCard.
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame to: aSpaceship [ 
	aBoardGame throwRepeatCardTo: aSpaceship.
]
