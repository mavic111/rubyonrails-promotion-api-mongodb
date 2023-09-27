module Docs
  module V1
    module Platform
      def self.included(mod)
        mod.resource_description do
          api_versions "v1"
          short "Platform Documentation"
          error 403, "Forbidden"
          error 404, "Missing"
          error 500, "Server crashed for some reason"
          error :unprocessable_entity, "Could not save the entity."
        end

        mod.def_param_group :platform do
          param :platform, Hash, required: true, action_aware: true, desc: "Platform" do
            param :name, String, required: true, desc: "name of the platform"
            param :type, String, required: true, desc: "type of the platform"
            param :code, String, required: true, desc: "code of the platform"
          end
        end
      end
    end
  end
end
