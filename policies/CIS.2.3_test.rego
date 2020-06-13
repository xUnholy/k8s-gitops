package cis_2_3

import data.lib.test

test_violation {
    test.violations(violation) with input as policy_input("etcd", "--auto-tls=true")
}

test_no_violation_01 {
    test.no_violations(violation) with input as policy_input("etcd", "--auto-tls=false")
}

test_no_violation_02 {
    test.no_violations(violation) with input as policy_input("kube-proxy", "--auto-tls=true")
}

policy_input(component, kv) = {
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "kube-apiserver",
    "namespace": "kube-system",
    "labels": {
      "component": component,
      "tier": "control-plane"
    }
  },
  "spec": {
    "containers": [
      {
        "command": [
          "kube-apiserver",
          kv
        ],
        "image": "k8s.gcr.io/kube-apiserver:v1.18.3",
        "imagePullPolicy": "IfNotPresent",
        "name": "kube-apiserver"
      }
    ]
  }
}
