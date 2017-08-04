@_inlineable
public
func floats_between<F>(_ f1:F, _ f2:F) -> Int where F:BinaryFloatingPoint
{
    let binades:Int = (Int(f1.exponentBitPattern) - Int(f2.exponentBitPattern)) * 1 << F.significandBitCount
    return binades + Int(f1.significandBitPattern) - Int(f2.significandBitPattern)
}

@_inlineable
//@_specialize(where F == Float)
//@_specialize(where F == Double)
public
func cos_karlie<F>(_ x:F) -> F where F:BinaryFloatingPoint
{
    let x:F = x.remainder(dividingBy: 2 * F.pi)
    return (x < F.pi ? 1 : -1) * sin_karlie(folded: x + (x > 0 ? -0.5 * F.pi : 0.5 * F.pi))
}

@_versioned
@_inlineable
//@_specialize(where F == Float)
//@_specialize(where F == Double)
func sin_karlie<F>(folded x:F) -> F where F:BinaryFloatingPoint
{
    let u:F   = x * 2 / F.pi,
        u2:F  = u * u
    var Σ:F   = 5.872975744799950138388e-12
    for coefficient:F in [  -6.684416831856084347986e-10,
                             5.692136428098625245839e-8,
                            -3.598843020467257521822e-6,
                             0.0001604411847130915918351,
                            -0.004681754135304255322786,
                             0.07969262624616563982725,
                            -0.6459640975062462009670,
                             1.570796326794896618906
                         ]
    {
        Σ = u2 * Σ + coefficient
    }
    return Σ * u
}

/* taylor series approximation, not as good for large values of x */
/*
@_inlineable
//@_specialize(where F == Float)
//@_specialize(where F == Double)
public
func cos_taylor<F>(_ x:F) -> F where F:BinaryFloatingPoint
{
    let x:F = abs(x.remainder(dividingBy: 2 * F.pi)),
        quadrant:Int = Int(x * (2 / F.pi))

    switch quadrant
    {
    case 0:
        return  cos(on_first_quadrant:        x)
    case 1:
        return -cos(on_first_quadrant: F.pi - x)
    case 2:
        return -cos(on_first_quadrant: x - F.pi)
    case 3:
        return -cos(on_first_quadrant: 2 * F.pi - x)
    default:
        fatalError("unreachable")
    }
}

@_versioned
@_inlineable
//@_specialize(where F == Float)
//@_specialize(where F == Double)
func cos_taylor<F>(on_first_quadrant x:F) -> F where F:BinaryFloatingPoint
{
    let x2:F = x * x
    var y:F  = 0.0000000000000477945439406649917
    for c:F in [-0.0000000000114707451267755432394,
                 0.000000002087675698165412591559,
                -0.000000275573192239332256421489,
                 0.00002480158730158702330045157,
                -0.00138888888888888880310186415,
                 0.04166666666666666665319411988,
                -0.4999999999999999999991637437,
                 0.9999999999999999999999914771
                ]
    {
        y = x2 * y + c
    }
    return y
}
*/
