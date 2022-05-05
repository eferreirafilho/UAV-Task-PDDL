; Define the problem
(define (problem demeter-task-problem-1)
    (:domain demeter-task-domain-1
    )
    (:objects
        ;Surface Waypoints (waypoint0 = cable start)  
        waypoint0 waypoint1 waypoint2 waypoint3 waypoint4 waypoint5
        
        ;Sensors
        sensor1 sensor2 sensor3 sensor4 sensor5 

        ;Data from sensor
        data1 data2 data3 data4 data5

        ;robots
        auv1
        auv2
    )
    (:init
        ; Initialize surface waypoints
        (waypoint waypoint0) (waypoint waypoint1) (waypoint waypoint2) (waypoint waypoint3) (waypoint waypoint4) (waypoint waypoint5)
        ; Initialize data 
        (data data1) (data data2) (data data3) (data data4) (data data5)
        ; Initialize underwater sensors (sensors are waypoints)
        (waypoint sensor1) (waypoint sensor2) (waypoint sensor3) (waypoint sensor4) (waypoint sensor5)
        ; Define allowed moviments between surface waypoints and start cable
        (can-move waypoint0 waypoint1) (can-move waypoint1 waypoint2) (can-move waypoint2 waypoint3) (can-move waypoint3 waypoint4) (can-move waypoint4 waypoint5)
        (can-move waypoint5 waypoint4) (can-move waypoint4 waypoint3) (can-move waypoint3 waypoint2) (can-move waypoint2 waypoint1) (can-move waypoint1 waypoint0)
        ; Define allowed moviments from surface waypoints to underwater sensors
        (can-move waypoint1 sensor1) (can-move waypoint2 sensor2) (can-move waypoint3 sensor3) (can-move waypoint4 sensor4) (can-move waypoint5 sensor5)
        ; Define allowed moviments from underwater sensors to surface waypoints
        (can-move sensor1 waypoint1) (can-move sensor2 waypoint2) (can-move sensor3 waypoint3) (can-move sensor4 waypoint4) (can-move sensor5 waypoint5)
        ; Define data in sensors
        (is-in data1 sensor1) (is-in data2 sensor2) (is-in data3 sensor3) (is-in data4 sensor4) (is-in data5 sensor5)
        ; Define transmit data positions (cable start and surface waypoints)
        (is-at-surface waypoint0) (is-at-surface waypoint1) (is-at-surface waypoint2) (is-at-surface waypoint3) (is-at-surface waypoint4) (is-at-surface waypoint5)

        
        ; Multiple UAVs
        (auv auv1)
        (empty auv1)
        (at auv1 waypoint0) ; auv start at cable begin

        (auv auv2)
        (empty auv2)
        (at auv2 waypoint2) ; auv start at cable begin
    )
    (:goal
        (and
            (data-sent data1)
            (data-sent data2)
            (data-sent data3)
            (data-sent data4)
            (data-sent data5)
            (at auv1 waypoint0)
            (at auv2 waypoint0)
        )
    )
)