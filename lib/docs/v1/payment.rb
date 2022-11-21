module Docs
  module V1
    module Payment
      def self.included(mod)
        mod.resource_description do
          api_versions 'v1'  
          short 'Payment Documentation'
          error 403, "Forbidden"
          error 404, "Missing"
          error 500, "Server crashed for some reason"
          error :unprocessable_entity, "Could not save the entity."
        end
  
        mod.def_param_group :payment do
          param :payment, Hash, :required => true, :action_aware => true, :desc => "Payment" do
            param :name, String, :required => true, desc: 'name of the payment'
            param :type, String, :required => true, desc: 'type of the payment'
            param :code, String, :required => true, desc: 'code of the payment'
          end
        end

      end
    end
  end
end