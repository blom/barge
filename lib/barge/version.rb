module Barge
  class Version
    MAJOR = 0
    MINOR = 12
    PATCH = 0

    def self.to_s
      [MAJOR, MINOR, PATCH].join '.'
    end
  end
end
