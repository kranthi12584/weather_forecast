class CacheService
  CACHE_EXPIRY = 30.minutes

  # Retrieves cached forecast for a given ZIP code
  def self.fetch(zip_code)
    cached = $redis.get("forecast:#{zip_code}")
    cached.present? ? JSON.parse(cached) : nil
  end

  # Stores forecast data in cache
  def self.store(zip_code, data)
    $redis.set("forecast:#{zip_code}", data.to_json, ex: CACHE_EXPIRY)
  end
end
