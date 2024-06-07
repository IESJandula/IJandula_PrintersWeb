# require 'json'
# require 'dry-types'
# require 'dry-struct'

# module Types
#   include Dry.Types(default: :nominal)

#   Integer = Strict::Integer
#   Hash    = Strict::Hash
#   String  = Strict::String
# end

# class PrintActionElement < Dry::Struct

#   attribute :id,           Types::Integer
#   attribute :file_name,    Types::String
#   attribute :printer_name, Types::String
#   attribute :num_copies,   Types::Integer
#   attribute :color,        Types::String
#   attribute :orientation,  Types::String
#   attribute :status,       Types::String
#   attribute :faces,        Types::String
#   attribute :user,         Types::String
#   attribute :date,         Types::String

#   def self.from_dynamic!(d)
#     d = Types::Hash[d]
#     new(
#       id:           d.fetch("id"),
#       file_name:    d.fetch("fileName"),
#       printer_name: d.fetch("printerName"),
#       num_copies:   d.fetch("numCopies"),
#       color:        d.fetch("color"),
#       orientation:  d.fetch("orientation"),
#       status:       d.fetch("status"),
#       faces:        d.fetch("faces"),
#       user:         d.fetch("user"),
#       date:         d.fetch("date"),
#     )
#   end

#   def self.from_json!(json)
#     from_dynamic!(JSON.parse(json))
#   end

#   def to_dynamic
#     {
#       "id"          => id,
#       "fileName"    => file_name,
#       "printerName" => printer_name,
#       "numCopies"   => num_copies,
#       "color"       => color,
#       "orientation" => orientation,
#       "status"      => status,
#       "faces"       => faces,
#       "user"        => user,
#       "date"        => date,
#     }
#   end

#   def to_json(options = nil)
#     JSON.generate(to_dynamic, options)
#   end
# end

# class PrintAction
#   def self.from_json!(json)
#     print_action = JSON.parse(json, quirks_mode: true).map { |x| PrintActionElement.from_dynamic!(x) }
#     print_action.define_singleton_method(:to_json) do
#       JSON.generate(self.map { |x| x.to_dynamic })
#     end
#     print_action
#   end
# end
