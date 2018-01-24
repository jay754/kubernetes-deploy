# frozen_string_literal: true
module KubernetesDeploy
  class ServiceAccount < KubernetesResource
    TIMEOUT = 30.seconds
    PREDEPLOY = true

    def sync
      _, _err, st = kubectl.run("get", kind, @name, "--output=json")
      @status = st.success? ? "Created" : "Unknown"
      @found = st.success?
    end

    def deploy_succeeded?
      exists?
    end

    def deploy_failed?
      false
    end

    def exists?
      @found
    end

    def timeout_message
      UNUSUAL_FAILURE_MESSAGE
    end
  end
end
