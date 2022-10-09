# ldbws-ruby

I’ll write a proper readme/howto at some point, but short version is that this is a Ruby wrapper around [Network Rail‘s Live Departure Board web service](https://lite.realtime.nationalrail.co.uk/OpenLDBWS/) (LDBWS/OpenLDBWS)—I’ve trawled through their XSD files so you don’t have to =)

I built it for a project I’m hacking at + thought I’d release it into the world. It’s rough and ready right now, but it should be somewhat functional.

## HOWTO

All operations are supported, in `snake_case`, thus:

```ruby
require "path/to/ldbws"

service = Ldbws.service(YOUR_API_TOKEN)
result = service.get_departure_board(crs: "CDF")

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
# 22:15   1    Warminster  (Great Western Railway)
# 22:24   7    Barry Island  (Transport for Wales)
# 22:26   2    Gloucester  (Transport for Wales)
# 22:30   3A   Carmarthen  (Transport for Wales)
# 22:39   4    Swansea  (Great Western Railway)
# [etc]
```

## TODO

- [ ] write tests
- [ ] write documentation
- [ ] provide nicer wrapping of API calls to allow for caching/etc (technically complete, but I don’t like it)
- [ ] release as a gem

## Caveats

This is released into the world as-is. If you use it for something and end up missing your train, it’s not my fault :)

---

Share and enjoy!
