program lorentz
    implicit none    

    !Declare variables
    integer(4), PARAMETER :: RK_n = 4
    real(8) :: dt, t, pi, q, m, final_time!, k_e
    real(8) :: q_state(6), q_a(3), v(3)
    real(8) :: E(3), B(3)
    real(8) :: temp(6), K(RK_n,6)
    integer(4) :: i

    !Open data files
    open(unit = 69, file="position.dat")
    open(unit = 420, file = "velocity.dat")
    open(unit = 666, file = "acceleration.dat")

    open(unit = 68, file="KE.dat")
    open(unit = 421, file = "PE.dat")
    open(unit = 667, file = "E.dat")

    !Initialize variables
    pi = 4*atan(1.0)
    q = 3.0 !C
    m = 2.0 !kg
    !q = -1.602d-19
    !m = 9.11d-31

    dt = 0.001!1.0d-12
    t = 0
    final_time = 500

    q_state(1:3) = [0.0, 0.0, 0.0]
    q_state(4:6) = [1.0, 0.0, 0.0]

    E = [0.0, 0.01, 1.0]
    B = [0.0, 0.00, 0.1]

    !Approximation and write loop
    do while (t < final_time)
        t = t + dt 
        !Runge-kutta
        temp = q_state
        do i = 1, 4
            !Update acceleration according to temp
            v = temp(4:6)
            q_a = q / m * (E + [v(2)*B(3) - v(3)*B(2),&
                                v(3)*B(1) - v(1)*B(3),& 
                                v(1)*B(2) - v(2)*B(1)])
            
            !Update the ith K
            K(i, 1:3) = temp(4:6)
            K(i, 4:6) = q_a
            !Use the correct step size
            if (i == 4) then 
                exit
            else if (i == 3) then
                temp = q_state + dt * K(i,:) 
            else
                temp = q_state + 0.5 * dt * K(i,:)
            end if
        end do
        !Get the final approximation
        q_state = q_state + dt * (K(1,:) + 2*K(2,:) + 2*K(3,:) + K(4,:)) / 6

        !Write to file
        write(69,*) q_state(1:3)
        write(420,*) q_state(4:6)
        write(666,*) q_a
    end do
end program