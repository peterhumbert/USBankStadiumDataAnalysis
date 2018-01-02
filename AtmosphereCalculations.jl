function StandardAtmos(alt, units = "SI")
     # This function uses the standard atmosphere model
     # to return the air temperature, pressure, and density
     # at a given altitude.
     # Input values in vector alt (altitude) should be 0-90 km (0-295000 ft)
     # Input value units is expected to be either 'SI' or 'US'.

    # Set initial constants based on units
    if units == "SI"
        altbases = [0 11e3 25e3 47e3 53e3 79e3 90e3] #units m
        a = [-6.5e-3 3e-3 -4.5e-3]                   #units K/m
        T = [288.16 216.66 282.66 165.66]            #units K
        R = 287                                      #units J/kg-K
        g = 9.81                                     #units m/s2
        p = [101325 22615.6 2484.17 120.052 58.1116 1.00387 0.103747]  #units kPa
        alt = alt * 1000                             #convert input from km to m
    elseif units == "US"
        altbases = [0 36.1e3 82.0e3 154.2e3 173.9e3 259e3 295e3] #units ft
        a = [-3.6e-3 1.65e-3 -2.5e-3]                            #units degR/ft
        T = [518.67 389.99 508.79 298.19]                        #units degR
        R = 1716                                                 #units lb-ft/slug-degR
        g = 32.2                                                 #units ft/s2
        p = [2116 478.7 52.59 2.556 1.236 0.0224 0.00233]        #units lb/ft2
    else
        error("Invalid units.")
    end
    N = length(alt)

    # Find temperature (temp), pressure (press) and density (rho)
    temp = zeros(Float64,N)
    press = zeros(Float64,N)
    rho = zeros(Float64,N)
    i = 1
    for h in alt
        if h < altbases[2]
            temp[i] = T[1]+a[1]*(h-altbases[1])
            press[i] = p[1]*(temp[i]/T[1])^(-g/a[1]/R)
            rho[i] = p[1]/R/temp[i]*(temp[i]/T[1])^(-g/a[1]/R)
        elseif h < altbases[3]
            temp[i] = T[2]
            press[i] = p[2]*exp(-g*(h-altbases[2])/(R*temp[i]))
            rho[i] = (p[2]/R/T[2])*exp(-g*(h-altbases[2])/R/T[2])
        elseif h < altbases[4]
            temp[i] = T[2]+a[2]*(h-altbases[3])
            press[i] = p[3]*(temp[i]/T[2])^(-g/a[2]/R)
            rho[i] = p[3]/R/temp[i]*(temp[i]/T[2])^(-g/a[2]/R)
        elseif h < altbases[5]
            temp[i] = T[3]
            press[i] = p[4]*exp(-g*(h-altbases[4])/(R*temp[i]))
            rho[i] = p[4]/R/T[3]*exp(-g*(h-altbases[4])/R/T[3])
        elseif h < altbases[6]
            temp[i] = T[3]+a[3]*(h-altbases[5])
            press[i] = p[5]*(temp[i]/T[3])^(-g/a[3]/R)
            rho[i] = p[5]/R/temp[i]*(temp[i]/T[3])^(-g/a[3]/R)
        else
            temp[i] = T[4]
            press[i] = p[6]*exp(-g*(h-altbases[6])/(R*temp[i]))
            rho[i] = p[6]/R/T[4]*exp(-g*(h-altbases[6])/R/T[4])
        end
        i += 1
    end

    return temp, press, rho
end

# test for StandardAtmos()
# (temp, press, rho) = StandardAtmos(0)
