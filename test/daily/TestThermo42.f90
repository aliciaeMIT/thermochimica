

    !-------------------------------------------------------------------------------------------------------------
    !
    ! DISCLAIMER
    ! ==========
    ! 
    ! All of the programming herein is original unless otherwise specified.  Details of contributions to the 
    ! programming are given below.
    !
    !
    ! Revisions:
    ! ==========
    ! 
    !
    !    Date          Programmer          Description of change
    !    ----          ----------          ---------------------
    !    05/14/2013    M.H.A. Piro         Original code
    !    08/31/2018    B.W.N. Fitzpatrick  Modification to use Kaye's Pd-Ru-Tc-Mo system
    !
    ! Purpose:
    ! ========
    !    The purpose of this application test is to ensure that Thermochimica computes the correct results for
    !    the Pd-Ru-Tc-Mo system.
    !-----------------------------------------------------------------------------------------------------------


program TestThermo42

    USE ModuleThermoIO
    USE ModuleThermo 

    implicit none


    ! Specify units:
    cInputUnitTemperature  = 'K'
    cInputUnitPressure     = 'atm'
    cInputUnitMass         = 'moles'
    cThermoFileName        = '../data/Kaye_NobleMetals.dat'

    ! Specify values:
    dPressure              = 1D0
    dTemperature           = 2310D0
    dElementMass(42)       = 0.22D0        ! Mo
    dElementMass(43)       = 0.78D0        ! Tc



    ! Parse the ChemSage data-file:
    call ParseCSDataFile(cThermoFileName)
                
    ! Call Thermochimica:
    call Thermochimica


    ! Check results:
    if (INFOThermo == 0) then
        if (((DABS(dMolFraction(9) - 0.68579669D0)/0.68579669D0) < 1D-3).AND. &
        ((DABS(dMolFraction(10) - 0.304131D0)/0.304131D0) < 1D-3).AND. &
        ((DABS(dGibbsEnergySys - (-1.5588D5))/(-1.5588D5)) < 1D-3))  then
            ! The test passed: 
            print *, 'TestThermo42: PASS'
        else
            ! The test failed.
            print *, 'TestThermo42: FAIL <---'
        end if
    else
        ! The test failed.
        print *, 'TestThermo42: FAIL <---'
    end if


! Reset Thermochimica:
call ResetThermo


end program TestThermo42