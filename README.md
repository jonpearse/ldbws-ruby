# ldbws

This is a wrapper around [Network Rail‘s Live Departure Board web service](https://lite.realtime.nationalrail.co.uk/OpenLDBWS/) (LDBWS/OpenLDBWS), allowing a much simpler querying interface. As best I can tell, all functionality is supported, although the gem currently only queries the public API.

You will need to [register for an API key](http://realtime.nationalrail.co.uk/OpenLDBWSRegistration/) in order to use this gem.


## Installation/usage

Add `ldbws` to your Gemfile

```ruby
gem "ldbws"
```

As long as you have an API key, you should be able to make requests against the service. Note that, per Ruby tradition, methods are written in `snake_case`, thus:

```ruby
require "ldbws"

service = Ldbws.service(YOUR_API_TOKEN)
result = service.get_departure_board(crs: "CDF") # ie GetDepartureBoard

puts "TIME   PLAT  TO"
result.train_services.each do |service|
  printf(
    "%s   %-2s   %s  (%s)\n",
    service.std.strftime("%H:%M"),
    service.platform || "-",
    service.destination.first.name,
    service.operator
  )
end

# TIME   PLAT  TO
# 17:32   -    Penarth  (Transport for Wales)
# 17:39   3    Swansea  (Great Western Railway)
# 17:55   8    Barry  (Transport for Wales)
# 17:56   2A   Manchester Piccadilly  (Transport for Wales)
# 18:01   6    Bargoed  (Transport for Wales)
# [etc]
```

Basic validation/coercion of parameters is provided (via [Dry::Schema](https://dry-rb.org/gems/dry-schema/)), but this is not exhaustive and should not be relied upon.
In particular, CRS codes—the three letter identifier for each station—are _not_ validated beyond “is it a three-letter string”.

## Error-handling

This module is pretty decent at validating request parameters, but beyond that all it can really do is just echo what LDBWS says. To wit, there are three errors that can be raised:

### `Ldbws::Request::ParamValidationError`

This is raised when parameter validation fails. Details about exactly which parameters and why can be found using the `#messages`, and is provided in hash format, thus:

```ruby
begin
  service.get_departure_board
rescue Ldbws::Request::ParamValidationError => e
  # e = { crs: "is missing" }
end
```

### `Ldbws::RequestError`

Raised when LDBWS returns an error message, usually because the request is bad (eg: invalid CRS). Unfortunately LDBWS’ error messages are pretty terrible, so it’s generally not too edifying to look at them.

### `Ldbws::ResponseParsingError`

Raised when the response from LDBWS cannot be parsed.

## Caveats

This is released into the world as-is. If you use it for something and end up missing your train, or do something that falls foul of the LDBWS terms of use, it’s not my fault :)

---

Share and enjoy!
