
; Simple UAV read sensor domain
; With action durations

(define (domain demeter-domain) 
    (:requirements :fluents :durative-actions :duration-inequalities)

    (:functions
        (battery-amount ?demeter)
        (recharge-rate ?demeter)
        (battery-capacity)
    )

    (:predicates 
        (can-move ?from-waypoint ?to-waypoint)
        (is-in ?data ?sensor)
        (been-at ?demeter ?waypoint)
        (carry ?demeter ?data)
        (at ?demeter ?waypoint)
        (is-at-surface ?waypoint)
        (data-sent ?data)
        (waypoint ?waypoint)
        (data ?data)
        (demeter ?demeter)
        (empty ?demeter)
    )
    ;define actions here
    (:durative-action move
        :parameters (?demeter ?from-waypoint ?to-waypoint)
        :duration(= ?duration 2)
        :condition (and 
            (at start (demeter ?demeter))
            (at start (waypoint ?from-waypoint))
            (at start (waypoint ?to-waypoint))
            (over all (can-move ?from-waypoint ?to-waypoint)) 
            (at start (at ?demeter ?from-waypoint))
            (at start (> (battery-amount ?demeter) 8)))
           
        :effect (and 
            (at end (at ?demeter ?to-waypoint))
            (at end (been-at ?demeter ?to-waypoint))
            (at start (not (at ?demeter ?from-waypoint)))
            (at start (decrease (battery-amount ?demeter) 8)))
    )
    
    (:durative-action get-data
        :parameters (?demeter ?data ?waypoint)
        :duration(= ?duration 15)
        :condition (and 
            (at start (demeter ?demeter))
            (at start (data ?data))
            (at start (waypoint ?waypoint))
            (at start (is-in ?data ?waypoint))
            (over all (at ?demeter ?waypoint))
            (at start (empty ?demeter))
            (at start (>= (battery-amount ?demeter) 5))
        )
        :effect (and 
            (at end (not (is-in ?data ?waypoint)))
            (at end (carry ?demeter ?data))
            (at end (not (empty ?demeter)))
            (at start (decrease (battery-amount ?demeter) 5)) 
    )
    )
    (:durative-action transmit-data
        :parameters (?demeter ?data ?waypoint)
        :duration (= ?duration 10)
        :condition (and 
            (at start (demeter ?demeter))
            (at start (data ?data))
            (at start (waypoint ?waypoint))
            (at start (is-at-surface ?waypoint))
            (over all (at ?demeter ?waypoint))
            (at start (carry ?demeter ?data))
            (at start (> (battery-amount ?demeter) 2)))
        
        :effect (and 
            (at end (is-in ?data ?waypoint))
            (at end (not (carry ?demeter ?data)))
            (at end (data-sent ?data))
            (at end (empty ?demeter))     
            (at start (decrease (battery-amount ?demeter) 2))   
            )
    )
    (:durative-action recharge
        :parameters (?demeter ?waypoint)

        :duration 
            (= ?duration 
                (/ (- 80 (battery-amount ?demeter)) (recharge-rate ?demeter)))
        :condition (and 
            (at start (demeter ?demeter))
            (at start (waypoint ?waypoint))
            (at start (at ?demeter ?waypoint))
            (over all (is-at-surface ?waypoint))
            (at start (< (battery-amount ?demeter) 80))
        )
        :effect 
            (at end 
                (increase (battery-amount ?demeter) 
                    (* ?duration (recharge-rate ?demeter))))
    )
)

