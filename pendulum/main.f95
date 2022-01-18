program shm

    implicit none    
    
    !Declare variables
    real(8) :: m, dt, t, pi, g, length
    real(8), allocatable, DIMENSION(:) :: theta, omega, a, KE, PE, E
    integer(4) :: i, steps

    !Open data files
    open(unit = 69, file="velocity.dat")
    open(unit = 420, file = "position.dat")
    open(unit = 666, file = "acceleration.dat")

    open(unit = 68, file = "KE.dat")
    open(unit = 421, file = "PE.dat")
    open(unit = 667, file = "E.dat")

    !Initialize variables
    m = 1
    g = 9.8
    length = 1
    t = 30
    dt = 0.01
    pi = 4.0*atan(1.0)
    
    steps = floor(t / dt)

    ALLOCATE(theta(steps),omega(steps), a(steps)) 
    ALLOCATE(KE(steps), PE(steps), E(steps))
    
    write(*,*) "Please input the initial angle (degrees)"
    read(*,*) theta(1)
    theta(1) = theta(1) * pi / 180
    omega(1) = 0
    a(1) = -g/length * sin(theta(1))

    theta(2) = theta(1) + omega(1)*dt + 0.5 * dt**2 * a(1)
    a(2) = - g/length * sin(theta(2)) 
    omega(2) = (theta(2) - theta(1)) / dt

    !Verlet's method
    do i = 3, steps
        theta(i) = 2 * theta(i-1) - theta(i-2) + dt**2 * a(i-1)
        a(i) = -g/length * sin(theta(i))
        omega(i) = (2 * theta(i) - 2 * theta(i-1) + dt**2 * a(i)) / (2*dt)
    end do

    do i = 1, steps-1
        !Write all the values
        write(69, *) i*dt, ",", omega(i)
        write(420, *) i*dt, ",", theta(i) 
        write(666, *) i*dt, ",", a(i)

        KE(i) = 0.5 * m * (length * omega(i))**2
        PE(i) = m * g * length * (1 - cos(theta(i)))
        E(i)  = KE(i) + PE(i)
        write(68, *) i*dt, ",", KE(i)
        write(421, *) i*dt, ",", PE(i) 
        write(667, *) i*dt, ",", E(i)
    end do

end program