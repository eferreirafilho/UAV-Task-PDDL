; Simple UAV read sensor domain
; With action durations

(define (domain demeter-task-domain-1) 
    (:requirements :fluents :durative-actions)

    (:predicates 
        (can-move ?from-waypoint ?to-waypoint)
        (is-in ?data ?sensor)
        (been-at ?auv ?waypoint)
        (carry ?auv ?data)
        (at ?auv ?waypoint)
        (is-at-surface ?waypoint)
        (data-sent ?data)
        (waypoint ?waypoint)
        (data ?data)
        (auv ?auv)
        (empty ?auv)
    )
    ;define actions here
    (:durative-action move
        :parameters (?auv ?from-waypoint ?to-waypoint)
        :duration(= ?duration 2)
        :condition (and 
            (at start (auv ?auv))
            (at start (waypoint ?from-waypoint))
            (at start (waypoint ?to-waypoint))
            (over all (can-move ?from-waypoint ?to-waypoint)) 
            (at start (at ?auv ?from-waypoint)) 
           
        )
        :effect (and 
            (at end (at ?auv ?to-waypoint))
            (at end (been-at ?auv ?to-waypoint))
            (at start (not (at ?auv ?from-waypoint)))
        )
    )
    (:durative-action get-data
        :parameters (?auv ?data ?waypoint)
        :duration(= ?duration 15)
        :condition (and 
            (at start (auv ?auv))
            (at start (data ?data))
            (at start (waypoint ?waypoint))
            (at start (is-in ?data ?waypoint))
            (over all (at ?auv ?waypoint))
            (at start (empty ?auv))
        )
        :effect (and 
            (at end (not (is-in ?data ?waypoint)))
            (at end (carry ?auv ?data))
            (at end (not (empty ?auv)))
    )
    )
    (:durative-action transmit-data
        :parameters (?auv ?data ?waypoint)
        :duration (= ?duration 10)
        :condition (and 
            (at start (auv ?auv))
            (at start (data ?data))
            (at start (waypoint ?waypoint))
            (at start (is-at-surface ?waypoint))
            (over all (at ?auv ?waypoint))
            (at start (carry ?auv ?data))
        )
        :effect (and 
            (at end (is-in ?data ?waypoint))
            (at end (not (carry ?auv ?data)))
            (at end (data-sent ?data))
            (at end (empty ?auv))        
            )
    )
    ;(:action recharge
    ;    :parameters (?auv ?waypoint)
    ;    :precondition (and 
    ;        (auv ?auv)
    ;        (waypoint ?waypoint)
    ;        (at ?auv ?waypoint)
    ;        (is-at-surface ?waypoint)
    ;        (is-recharging-point ?waypoint)
    ;        ;(< (battery-amount ?auv) 20)
    ;    )
    ;    :effect 
    ;    (assign (battery-amount ?auv) (battery-capacity))
    ;)
)

