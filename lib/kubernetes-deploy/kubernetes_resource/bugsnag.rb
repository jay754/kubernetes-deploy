# frozen_string_literal: true
module KubernetesDeploy
  class Bugsnag < KubernetesResource
    TIMEOUT = 1.minute
    PREDEPLOY = true
    GROUP = 'stable.shopify.io'
    VERSION = 'v1'

    def sync
      @secret_found = false
      _, _err, st = kubectl.run("get", kind, @name)
      @found = st.success?
      if @found
        secrets, _err, _st = kubectl.run("get", "secrets", "--output=name")
        @secret_found = secrets.split.any? { |s| s.end_with?("-bugsnag") }
      end
      @status = @secret_found ? "Available" : "Unknown"
    end

    def deploy_succeeded?
      @secret_found
    end

    def deploy_failed?
      false
    end

    def exists?
      @found
    end

    def deploy_method
      :replace
    end
  end
end
