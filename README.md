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
# 17:32   -    Penarth  (Transport for Wales)
# 17:39   3    Swansea  (Great Western Railway)
# 17:55   8    Barry  (Transport for Wales)
# 17:56   2A   Manchester Piccadilly  (Transport for Wales)
# 18:01   6    Bargoed  (Transport for Wales)
# [etc]
```

### A note about rate limiting

LDBWS uses rate-limiting for free access: while this <i>probably</i> isn’t going to be an issue for the casual user, you may want to consider using a cache in front of this gem, just in case.

## Caveats

This is released into the world as-is. If you use it for something and end up missing your train, or do something that falls foul of the LDBWS terms of use, it’s not my fault :)

---

Share and enjoy!
