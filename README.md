# Vita

Little [Sinatra](http://www.sinatrarb.com/) application, which consumes the Linkedin API, and shows the information formatted as a curriculum vitae.

Vita uses [HAT](https://github.com/patriciomacadden/hat) as a base.

## Features

* Sinatra modular application.
* Data source powered by Linkedin API.
* Data persistence with Redis through [Ohm](https://github.com/soveran/ohm).
* Test suite powered by [minitest](https://github.com/seattlerb/minitest).

## Building your custom CV based on vita

If you point your environment variables to your LinkedIn application, vita must work
without problems.

You can set up your environment variables in the .env file, an example is provided:

```
vita/
└── .env.example
```

Once all environment variables are set up, you can simply run in the console:

```bash
$ rake refresh
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
