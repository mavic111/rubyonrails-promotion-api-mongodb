module Mongoid
    module Document
        def as_json(*args)
            attrs = super
            attrs["_id"] = _id.to_s
            attrs
        end
    end
end