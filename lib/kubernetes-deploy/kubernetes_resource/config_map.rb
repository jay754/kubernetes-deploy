# frozen_string_literal: true
module KubernetesDeploy
  class ConfigMap < KubernetesResource
    TIMEOUT = 30.seconds
    PREDEPLOY = true
    PRUNABLE = true

    def sync
      _, _err, st = kubectl.run("get", kind, @name)
      @status = st.success? ? "Available" : "Unknown"
      @found = st.success?
    end

    def deploy_succeeded?
      exists?
    end

    def deploy_failed?
      false
    end

    def timeout_message
      UNUSUAL_FAILURE_MESSAGE
    end

    def exists?
      @found
    end
  end
end
