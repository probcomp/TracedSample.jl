# TracedSample.jl

Allows for the optional specification of traced addresses (i.e. variable names)
in calls to `sample` and related functions in
[`StatsBase.jl`](https://github.com/JuliaStats/StatsBase.jl). Providing this
information allows ordinary Julia code to be "probabilistic-programming-ready".
See also [`TracedRandom.jl`](https://github.com/probcomp/TracedRandom.jl), which
provides similar support for random primitives in `Random`.

```julia
julia> sample(:id, 1:5)
3

julia> sample(:fruit, [:apple, :banana, :cherry], weights([0.2, 0.3, 0.5]))
:banana
```

By default, the addresses (`:id` and `:fruit` in the examples above)
are ignored, but they can be intercepted via meta-programming
(see [`Genify.jl`](https://github.com/probcomp/Genify.jl)) to support inference
in probabilistic programming systems such as [`Gen`](https://www.gen.dev/).
Addresses can be specified as `Symbol`s, or as pairs from symbols
to other types (`Pair{Symbol,<:Any}`).
