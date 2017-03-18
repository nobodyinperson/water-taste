# Water taste [![Build Status](https://travis-ci.org/nobodyinperson/water-taste.svg?branch=master)](https://travis-ci.org/nobodyinperson/water-taste)

Bottled water doesn't always taste the same. Different brand, different taste.
I want to know, what mineral causes some waters to taste so strange and bad.

# Create plots

To create plots based on the data, simply run `make` from the repository root.
The `plots` directory will then be filled with `.png` plot files. If the data
or the plot scripts change, simply run `make` again.

# Data

The data is stored under the `data` folder in a `.csv`-file. All units are in
`mg/l`. The `taste` is unitless and has a range from `0` (bad) to `10` (good).
Name your personal taste column `taste_USERNAME`.

# Contribute data

Fork this repository or click the `Edit` button on the `.csv`-file. Make your
changes and then file a pull request.

# Contribute plot scripts

Read the [`README.md`](https://github.com/nobodyinperson/water-taste/blob/master/scripts/README.md) file under the [`scripts`](https://github.com/nobodyinperson/water-taste/blob/master/scripts) directory.

