##Specific problems from Kloden&Platen 1997
abstract type Problem end

struct Problem31 <: Problem
    avec::Vector{Float64}
end

function mgen(prob::Problem31, x0::AbstractVector)
    return length(x0)
end

function a!(prob::Problem31)
    coeff = -prob.avec.^2
    return function (t, x, f)
        f .= coeff.*(x.*(1-x.^2))
    end
end

function b!(prob::Problem31)
    return function (t, x, g)
        g .= diagm(prob.avec.*(1-x.^2))
    end
end

function bbp!(prob::Problem31)
    coeff = -2*prob.avec.^2
    return function (t, x, bbp)
        bbp .= coeff.*(x-x.^3)
    end
end

#Diffeq has a different convention from v4.0
function diffeq_a!(prob::Problem31)
    coeff = -prob.avec.^2
    return function (t, x, p, f)
        f .= coeff.*(x.*(1-x.^2))
    end
end

function diffeq_b!(prob::Problem31)
    return function (t, x, p, g)
        g .= diagm(prob.avec.*(1-x.^2))
    end
end

function solution(prob::Problem31, x0, t, Wvec)
    avec = prob.avec
    return [tanh.(avec.*W+atanh.(x0)) for W in Wvec]
end
