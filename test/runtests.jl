using TracedSample, StatsBase, Random, Test

@testset "Addressed calls with global RNG" begin

for fn in (sample, wsample)
   Random.seed!(0)
   traced = fn(:addr, [1, 2, 3], weights([1, 2, 3]))
   Random.seed!(0)
   untraced = fn([1, 2, 3], weights([1, 2, 3]))
   @test traced == untraced

   Random.seed!(0)
   traced = fn(:addr, [1, 2, 3], weights([1, 2, 3]), 3; replace=false)
   Random.seed!(0)
   untraced = fn([1, 2, 3], weights([1, 2, 3]), 3; replace=false)
   @test traced == untraced
end

for fn in (sample!, wsample!)
   Random.seed!(0)
   traced = fn(:addr, [1, 2, 3], weights([1, 2, 3]), zeros(5))
   Random.seed!(0)
   untraced = fn([1, 2, 3], weights([1, 2, 3]), zeros(5))
   @test traced == untraced
end

end

@testset "Addressed calls with custom RNG" begin

rng = MersenneTwister()

for fn in (sample, wsample)
   Random.seed!(rng, 42)
   traced = fn(rng, :addr, [1, 2, 3], weights([1, 2, 3]))
   Random.seed!(rng, 42)
   untraced = fn(rng, [1, 2, 3], weights([1, 2, 3]))
   @test traced == untraced

   Random.seed!(rng, 42)
   traced = fn(rng, :addr, [1, 2, 3], weights([1, 2, 3]), 3; replace=false)
   Random.seed!(rng, 42)
   untraced = fn(rng, [1, 2, 3], weights([1, 2, 3]), 3; replace=false)
   @test traced == untraced
end

for fn in (sample!, wsample!)
   Random.seed!(rng, 42)
   traced = fn(rng, :addr, [1, 2, 3], weights([1, 2, 3]), zeros(5))
   Random.seed!(rng, 42)
   untraced = fn(rng, [1, 2, 3], weights([1, 2, 3]), zeros(5))
   @test traced == untraced
end

end
