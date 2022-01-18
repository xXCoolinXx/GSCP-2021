program heat
    implicit none    

    !Declare variables
    integer(4), PARAMETER :: xsteps = 61
    real(8) :: dt, dx, t, pi, kappa, length, C
    real(8), ALLOCATABLE, DIMENSION(:,:) :: Temp
    integer(4) :: ix, it, tsteps

    !Open data files
    open(unit = 69, file="txT.dat")

    !Initialize variables
    pi = 4*atan(1.0)
    C = 1 !Neutron term
    kappa = 1.0
    length = 1.0
    dt = 0.0001
    dx = length / (xsteps - 1)
    t = 0.1!dx**2 / 2 * kappa
    tsteps = floor(t/dt)
    ALLOCATE(Temp(xsteps,tsteps))

    Temp(0,1) = 0
    Temp(ceiling(xsteps / 2.0), 1) = 1/dx 

    !Approximation and write loop
    do it = 2, tsteps !Start at next time step
        do ix = 2, xsteps - 1 !Exclude the endpoints
            Temp(ix, it) = kappa*dt/dx**2 * (Temp(ix + 1,it-1) - 2 * Temp(ix, it-1) + Temp(ix - 1, it - 1)) + Temp(ix, it-1) &
                           + C * Temp(ix,it-1)
        end do
    end do

    do it = 10, tsteps
        write(69, *) Temp(:,it) !need timesteps and length to have real x and t values
    end do 
end program