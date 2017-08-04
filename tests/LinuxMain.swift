import Math

import func Glibc.clock
//import func Glibc.cos

@discardableResult
func benchmark<F>(_ n:Int, _ function:(Int) -> F) -> F where F:BinaryFloatingPoint
{
    let t:Int = clock()
    var accum:F = 0
    for i in 0 ..< n
    {
        accum += function(i)
    }
    print("time = \(clock() - t)")
    return accum
}

var q_error:Int = 0
for d:Int in -360 ..< 360
{
    let r:Double = Double(d) * Double.pi / 180,
        y:Double = cos_karlie(r)
    print("cos(\(d)°) = \(y) (error: \(floats_between(y, _cos(r))), absolute: \(y - _cos(r)))")
    let error:Int = abs(floats_between(y, _cos(r)))
    if error < 1000000
    {
        q_error += error
    }
}
print("total ulp error = \(q_error)")
print(benchmark(100000000)
{
    _cos(Double($0))
})
