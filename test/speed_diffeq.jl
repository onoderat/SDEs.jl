#A purely speed-check run. Does not check for correctness in script!
#Used to compare with say DiffEq
include("../src/solvers.jl")
include("setup.jl")
using BenchmarkTools

##
@time x, W = solve_diffeq(prob, x0, t)
@btime x, W = solve_diffeq(prob, x0, t)
