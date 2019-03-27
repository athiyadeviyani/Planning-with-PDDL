(define (domain waiting)
    (:requirements :adl )
    
    (:types
        waiter
        customer
        plate
        location
    )
    
    (:constants x
        Agent - waiter
        BUFF - location
    )
    
    (:predicates
        (Adjacent ?x - location ?y - location)
        (At ?x - object ?y - location)
        (HasFood ?p - plate)
        (IsServed ?c - customer)
        (Holding ?p - plate)
        (IsHolding ?a - waiter)
    )
    
    
    ;;;; ACTIONS
    
    (:action PickUp
        :parameters (?a - waiter ?p - plate ?loc - location)
        :precondition (and 
            (not (Holding ?p))
            (not (IsHolding ?a))
            (not (HasFood ?p))
            (At ?p ?loc)
            (At Agent ?loc)
        )
        :effect (and 
            (Holding ?p)
            (IsHolding ?a)
        )
    )
    
    (:action HandOver
        :parameters (?p - plate ?loc - location ?a - waiter ?c - customer)
        :precondition (and
            (At ?c ?loc)
            (At Agent ?loc)
            (Holding ?p)
            (IsHolding ?a)
            (HasFood ?p)
            (not (IsServed ?c))
        )
        :effect (and
            (not (Holding ?p))
            (not (IsHolding ?a))
            (IsServed ?c)
        )
    )
    
    (:action Fill
        :parameters (?a - waiter ?p - plate)
        :precondition (and 
            (At Agent BUFF)
            (not (HasFood ?p))
            (Holding ?p)
            (IsHolding ?a)
        )
        :effect (HasFood ?p)
    )
    
    (:action Move 
        :parameters (?a - waiter ?currloc - location ?newloc - location)
        :precondition (and
            (At Agent ?currloc)
            (Adjacent ?currloc ?newloc)
        )
        :effect (and 
            (At Agent ?newloc)
            (not (At Agent ?currloc))
        )
    )
    
)















