# swift-vibrant

[![CI Status](https://img.shields.io/travis/bd452/swiftVibrant.svg?style=flat)](https://travis-ci.org/bd452/swiftVibrant)
[![Version](https://img.shields.io/cocoapods/v/swiftVibrant.svg?style=flat)](https://cocoapods.org/pods/swiftVibrant)
[![License](https://img.shields.io/cocoapods/l/swiftVibrant.svg?style=flat)](https://cocoapods.org/pods/swiftVibrant)
[![Platform](https://img.shields.io/cocoapods/p/swiftVibrant.svg?style=flat)](https://cocoapods.org/pods/swiftVibrant)


## Installation

swift-vibrant is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'swift-vibrant'
```

## Usage
```swift
import swiftVibrant

let image = UIImage(named: "name_of_image")

// Calling from a background thread
Vibrant.from(image).getPalette({ palette in 
    // do stuff with your palette
})
// Calling in main thread
Vibrant.from(image).getPalette()
/// do stuff with your palette here

// Using constructor
let v = Vibrant(image, Vibrant.Options)
v.getPalette({ palette in 
    // do stuff with your palette
})
```


## References

### `Vibrant`
Main class of `swift-vibrant`.

#### `Vibrant.from(src: UIImage): Builder`
Make a `Builder` for an image. Returns a `Builder` instance.

#### `constructor(src: UIImage, opts: Vibrant.Options)`

Name    |  Description
------- |  ---------------------------------------
`image` |  Your UIImage instance
`opts`  |  Options (optional)


##### `Options`

```swift
public struct Options {
       var colorCount: Int = 64
       var quality: Int = 5
       var quantizer: Quantizer.quantizer
       var generator: Generator.generator
       var maxDimension: CGFloat?
       var filters: [Filter]
   }
```

Field          | Default                         | Description
-------------- | ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------
`colorCount`   | 64                              | amount of colors in initial palette from which the swatches will be generated
`quality`      | 5                               | Scale down factor used in downsampling stage. `1` means no downsampling. If `maxDimension` is set, this value will not be used.
`quantizer`    | `Quantizer.defaultQuantizer` | A `Quantizer` function
`generator`    | `Generator.defaultGenerator` | An `Generator` function
`maxDimension` | `nil`                   | The max size of the image's longer side used in downsampling stage. This field will override `quality`.
`filters`      | `[]`                            | An array of `Filter` 

##### `quantizer`

```swift
public typealias quantizer = (_ pixels: [UInt8], _ options: Vibrant.Options)->[Swatch]
```

##### `generator`

```swift
public typealias generator = (_ swatches: [Swatch])->Palette
```


##### `Filter`

Returns `true` if the color is to be kept.

```swift
public class Filter {
    public typealias filterFunction = (_ red: UInt8, _ green: UInt8, _ blue: UInt8, _ alpha: UInt8)->Bool
    
    var f: filterFunction
}
```

#### `getPalette(cb: (Palette)->Void)`

Name | Description
---- | -----------------
`cb` | callback function. 

### `Vibrant.Builder`
Helper class for change configurations and create a `Vibrant` instance. Methods of a `Builder` instance can be chained like:

```ts
Vibrant.from(src)
  .quality(1)
  .clearFilters()
  // ...
  .getPalette()
```

#### `constructor(src: UIImage, opts: Vibrant.Options)`
Arguments are the same as `Vibrant.constructor`.

#### `quality(q: Int): Builder`
Sets `opts.quality` to `q`. Returns this `Builder` instance.

#### `maxColorCount(n: Int): Builder`
Sets `opts.colorCount` to `n`. Returns this `Builder` instance.

#### `maxDimension(d: Int): Builder`
Sets `opts.maxDimension` to `d`. Returns this `Builder` instance.

#### `addFilter(f: Filter): Builder`
Adds a filter function. Returns this `Builder` instance.

#### `removeFilter(f: Filter): Builder`
Removes a filter function. Returns this `Builder` instance.

#### `clearFilters(): Builder`
Clear all filters. Returns this `Builder` instance.

#### `useQuantizer(quantizer: Quantizer.quantizer): Builder`
Specifies which `Quantizer` implementation class to use. Returns this `Builder` instance.

#### `useGenerator(generator: Generator.generator): Builder`
Sets `opts.generator` to `generator`. Returns this `Builder` instance.

#### `build(): Vibrant`
Builds and returns a `Vibrant` instance as configured.

#### `getPalette(cb: (Palette)->Void)`
Builds a `Vibrant` instance as configured and calls its `getPalette` method on a background thread. Calls `cb` on main thread.

#### `getPalette()->Palette`

Builds a `Vibrant` instance as configured and calls its `getPalette` method on the main thread.

### `Vibrant.Swatch`
Represents a color swatch generated from an image's palette.

#### `Vec3`

```swift
public typealias Vec3<T> = (T, T, T)
```

#### `RGB`

```swift
public typealias RGB = (r: UInt8, g: UInt8, b: UInt8)
```

#### `HSL`

```swift
public typealias HSL = (r: Double, g: Double, b: Double)
```

#### `XYZ`

```swift
public typealias HSL = (r: Double, g: Double, b: Double)
```

#### `LAB`

```swift
public typealias HSL = (r: Double, g: Double, b: Double)
```

#### 

#### `constructor(rgb: RGB, population: Int)`

Internal use.

Name         | Description
------------ | -----------------------------------
`rgb`        | `[r, g, b]`
`population` | Population of the color in an image

#### `hsl:  HSL`
#### `getPopulation(): Int`
#### `rgb: RGB`
#### `hex: String`

Returns a hexadecimal value of the swatch

#### `getTitleTextColor(): UIColor`
Returns an appropriate color to use for any 'title' text which is displayed over this `Swatch`'s color.

#### `getBodyTextColor(): UIColor`
Returns an appropriate color to use for any 'body' text which is displayed over this `Swatch`'s color.

### `Vibrant.Util`
Utility methods. Internal usage.

#### `hexToRgb(hex: string): RGB`
#### `rgbToHex(r: UInt8, g: UInt8, b: UInt8): String`
#### `hslToRgb(h: Double, s: Double, l: Double): RGB`
#### `rgbToHsl(r: UInt8, g: UInt8, b: UInt8): HSL`
#### `xyzToRgb(x: Double, y: Double, z: Double): RGB`
#### `rgbToXyz(r: UInt8, g: UInt8, b: UInt8): XYZ`
#### `xyzToCIELab(x: Double, y: Double, z: Double): LAB`
#### `rgbToCIELab(l: UInt8, a: UInt8, b: UInt8): LAB`
#### `deltaE94(lab1: Double, lab2: Double): Double`
Computes CIE delta E 1994 diff between `lab1` and `lab2`. The 2 colors are in CIE-Lab color space. Used in tests to compare 2 colors' perceptual similarity.

#### `rgbDiff(rgb1: RGB, rgb2: RGB): Double`
Compute CIE delta E 1994 diff between `rgb1` and `rgb2`.

#### `hexDiff(hex1: string, hex2: string): Double`
Compute CIE delta E 1994 diff between `hex1` and `hex2`.

#### `getColorDiffStatus(d: number): string`
Gets a string to describe the meaning of the color diff. Used in tests.

Delta E  | Perception                             | Returns
-------- | -------------------------------------- | -----------
<= 1.0   | Not perceptible by human eyes.         | `"Perfect"`
1 - 2    | Perceptible through close observation. | `"Close"`
2 - 10   | Perceptible at a glance.               | `"Good"`
11 - 49  | Colors are more similar than opposite  | `"Similar"`
50 - 100 | Colors are exact opposite              | `Wrong`

## Notes
- This library uses code from [ColorThiefSwift](https://github.com/yamoridon/ColorThiefSwift), mostly borrowing from their implementation of the modified median cut quantization (MMCQ) algorithm
- A majority of the rest was adapted from [node-vibrant](https://github.com/Vibrant-Colors/node-vibrant/)

## Author

Bryce Dougherty: bryce.dougherty@gmail.com

## Credits

Kazuki Ohara: [ColorThiefSwift](https://github.com/yamoridon/ColorThiefSwift)

Jari Zwarts: [node-vibrant](https://github.com/Vibrant-Colors/node-vibrant/)

## License

swiftVibrant is available under the MIT license. See the LICENSE file for more info.
