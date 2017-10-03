# frozen_string_literal: true
module KubernetesDeploy
  class Ingress < KubernetesResource
    TIMEOUT = 30.seconds
    PRUNABLE = true

    def sync
      _, _err, st = kubectl.run("get", kind, @name)
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
  end
end
