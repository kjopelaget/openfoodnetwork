module Admin
  module InjectionHelper
    def admin_inject_enterprise
      admin_inject_json_ams "admin.enterprises", "enterprise", @enterprise, Api::Admin::EnterpriseSerializer
    end

    def admin_inject_enterprises
      admin_inject_json_ams_array("ofn.admin", "my_enterprises", @my_enterprises, Api::Admin::BasicEnterpriseSerializer) +
        admin_inject_json_ams_array("ofn.admin", "all_enterprises", @all_enterprises, Api::Admin::BasicEnterpriseSerializer)
    end

    def admin_inject_enterprise_relationships
      admin_inject_json_ams_array "ofn.admin", "enterprise_relationships", @enterprise_relationships, Api::Admin::EnterpriseRelationshipSerializer
    end

    def admin_inject_enterprise_roles
      admin_inject_json_ams_array "ofn.admin", "enterpriseRoles", @enterprise_roles, Api::Admin::EnterpriseRoleSerializer
    end

    def admin_inject_payment_methods
      admin_inject_json_ams_array "admin.payment_methods", "paymentMethods", @payment_methods, Api::Admin::IdNameSerializer
    end

    def admin_inject_shipping_methods
      admin_inject_json_ams_array "admin.shipping_methods", "shippingMethods", @shipping_methods, Api::Admin::IdNameSerializer
    end

    def admin_inject_hubs
      admin_inject_json_ams_array "ofn.admin", "hubs", @hubs, Api::Admin::IdNameSerializer
    end

    def admin_inject_producers
      admin_inject_json_ams_array "ofn.admin", "producers", @producers, Api::Admin::IdNameSerializer
    end

    def admin_inject_hub_permissions
      render partial: "admin/json/injection_ams", locals: {ngModule: "ofn.admin", name: "hubPermissions", json: @hub_permissions.to_json}
    end

    def admin_inject_products
      admin_inject_json_ams_array "ofn.admin", "products", @products, Spree::Api::ProductSerializer
    end

    def admin_inject_taxons
      admin_inject_json_ams_array "admin.taxons", "taxons", @taxons, Api::Admin::TaxonSerializer
    end

    def admin_inject_users
      admin_inject_json_ams_array "ofn.admin", "users", @users, Api::Admin::UserSerializer
    end

    def admin_inject_variant_overrides
      admin_inject_json_ams_array "ofn.admin", "variantOverrides", @variant_overrides, Api::Admin::VariantOverrideSerializer
    end

    def admin_inject_spree_api_key
      render partial: "admin/json/injection_ams", locals: {ngModule: 'ofn.admin', name: 'SpreeApiKey', json: "'#{@spree_api_key.to_s}'"}
    end

    def admin_inject_json_ams(ngModule, name, data, serializer, opts = {})
      json = serializer.new(data, scope: spree_current_user).to_json
      render partial: "admin/json/injection_ams", locals: {ngModule: ngModule, name: name, json: json}
    end

    def admin_inject_json_ams_array(ngModule, name, data, serializer, opts = {})
      json = ActiveModel::ArraySerializer.new(data, {each_serializer: serializer, scope: spree_current_user}.merge(opts)).to_json
      render partial: "admin/json/injection_ams", locals: {ngModule: ngModule, name: name, json: json}
    end
  end
end
