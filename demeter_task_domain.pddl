; Multiple UAVs read sensor domain
; No battery
; No action durations
(define (domain demeter-task-domain-1)
(:requirements :typing :strips :fluents)
;(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

;(:types
;    data-retrieved
;)

(:predicates 
    (can-move ?from-waypoint ?to-waypoint)
    (is-in ?data ?sensor)
    (been-at ?auv ?waypoint)
    (carry ?auv ?data)
    (at ?auv ?waypoint)
    (is-at-surface ?waypoint)
    (data-send ?data)
    (waypoint ?waypoint)
    (data ?data)
    (auv ?auv)
    (empty ?auv)
)

;(:functions
;    (amount ?d - data-retrieved)
;    (total)
;)

;define actions here
(:action move
    :parameters (?auv ?from-waypoint ?to-waypoint)
    :precondition (and 
        (auv ?auv)
        (waypoint ?from-waypoint)
        (waypoint ?to-waypoint)
        (at ?auv ?from-waypoint)
        (can-move ?from-waypoint ?to-waypoint) 
    )
    :effect (and 
        (at ?auv ?to-waypoint)
        (been-at ?auv ?to-waypoint)
        (not (at ?auv ?from-waypoint))
    )
)
(:action get-data
    :parameters (?auv ?data ?waypoint)
    :precondition (and 
        (auv ?auv)
        (data ?data)
        (waypoint ?waypoint)
        (is-in ?data ?waypoint)
        (at ?auv ?waypoint)
        (empty ?auv)
    )
    :effect (and 
        (not (is-in ?data ?waypoint))
        (carry ?auv ?data)
        (not (empty ?auv))
)
)
(:action transmit-data
    :parameters (?auv ?data ?waypoint)
    :precondition (and 
        (auv ?auv)
        (data ?data)
        (waypoint ?waypoint)
        (is-at-surface ?waypoint)
        (at ?auv ?waypoint)
        (carry ?auv ?data)
    )
    :effect (and 
        (is-in ?data ?waypoint)
        (not (carry ?auv ?data))
        (data-send ?data)
        (empty ?auv)        
        )
)
)