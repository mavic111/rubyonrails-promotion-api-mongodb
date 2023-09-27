module Docs
  module V1
    module Promotion
      def self.included(mod)
        mod.resource_description do
          api_versions "v1"
          short "Promotion Documentation"
          error 404, "Missing"
          error 500, "Server crashed for some reason"
          error :unprocessable_entity, "Could not save the entity."
        end

        mod.def_param_group :promotion do
          param :promotion, Hash, required: true, action_aware: true, desc: "Promotion" do
            param :title, String, required: true, desc: "title of the promotion"
            param :description, String, required: true, desc: "description of the promotion"
            param :code, String, required: true, desc: "code of the promotion"
            param :start_time, [Time, String, Integer], required: true, desc: "start time of the promotion"
            param :end_time, [Time, String, Integer], required: true, desc: "end time of the promotion"
            param :is_verified, [true, false, "true", "false"], required: false, allow_blank: true,
                                                                desc: "verified status of the promotion"
            param :click_count, Integer, required: false, desc: "click count of the promotion"
            param :payment_id, String, required: true, desc: "payment_id the promotion"
            param :platform_id, String, required: true, desc: "platform_id the promotion"
          end
        end
      end
    end
  end
end
