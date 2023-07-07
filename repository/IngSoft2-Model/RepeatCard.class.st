Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 

]

{ #category : #'instance variable' }
RepeatCard >> name [
	^ 'repeat'.
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame [ 
	aBoardGame repeatCard.
]

{ #category : #action }
RepeatCard >> playOn: aBoardGame to: aSpaceship [ 
	aBoardGame repeatCardTo: aSpaceship.
]
