module TracedSample

using Random, StatsBase

export sample, sample!, wsample, wsample!

const Address = Union{Symbol,Pair{Symbol}}

for fn in (:sample, :sample!, :wsample, :wsample!)
    @eval begin
    @doc """
        $($fn)([rng=GLOBAL_RNG,] addr::Address, args...; kwargs...)

    Traced execution of `$($fn)`, where `addr` specifies the name / address of
    the random choice. By default, the address `addr` is ignored, but it can
    be intercepted to support inference in a probabilistic programming system.
    An `Address` is either a `Symbol`, or a `Pair` that begins with a `Symbol`.
    """
    $fn
    end

    fn = GlobalRef(StatsBase, fn)
    @eval $fn(::Address, args...; kwargs...) =
        $fn(args...; kwargs...)
    @eval $fn(rng::AbstractRNG, ::Address, args...; kwargs...) =
        $fn(rng, args...; kwargs...)
end

end # module
