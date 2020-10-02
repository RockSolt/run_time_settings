# frozen_string_literal: true

module RunTimeSettings
  module Type
    # = Time
    #
    # Custom type caster for Time. Values are converted to an integer representing seconds since epoch for storage in
    # the database, then converted back to Time on the way out.
    #
    # This is only accurate to the second; milliseconds are lost.
    class Time
      # called by read, should return Time instance
      def deserialize(value)
        ::Time.at(value.to_i)
      end

      # called by write, should convert to unix epoch for storage in database
      def serialize(value)
        value.to_i
      end
    end
  end
end
