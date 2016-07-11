module Resque
  module Failure
    class Backtrace < Base
      def save
        bt = filter_backtrace(Array(exception.backtrace))
        worker.log_with_severity :error, bt.join("\n")
      end

      private

      def filter_backtrace(backtrace)
        index = backtrace.index { |item| item.include?('/lib/resque/job.rb') }
        backtrace.first(index.to_i)
      end
    end
  end
end
