require 'json'
require 'trace_location'

TraceLocation.trace(format: :log) do
  JSON.load('{"foo": 42}')
end
