class PingonePromote < Formula
  desc "Review selected PingOne configuration and submit GitLab promotion requests"
  homepage "https://github.com/ChayzX/pingone-promote"
  url "https://github.com/ChayzX/pingone-promote/releases/download/v0.2.0-rc.2/pingone-promote-v0.2.0-rc.2-source.tar.gz"
  version "0.2.0-rc.2"
  sha256 "fd561c80e0f36401f27af506042e6480fb444d578afb77053053083b1d3060fd"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-X pingone-promote/internal/buildinfo.Version=v#{version}"
    system "go", "build", *std_go_args(output: bin/"pingone-promote", ldflags:), "./cmd/pingone-promote"
    system "go", "build", *std_go_args(output: bin/"pingone-runner", ldflags:), "./cmd/pingone-runner"
    doc.install "README.md"
    pkgshare.install "docs", "examples"
  end

  def caveats
    <<~EOS
      Preview release. Native PingOne promotion and rollback still need live acceptance.
      Run pingone-promote to open the local browser interface.
      Profiles and history are stored outside Homebrew and are preserved on uninstall.
      Production planning, deployment and rollback remain controlled by GitLab.
    EOS
  end

  test do
    assert_equal "pingone-promote v#{version}\n", shell_output("#{bin}/pingone-promote --version")
    assert_equal "pingone-runner v#{version}\n", shell_output("#{bin}/pingone-runner --version")
    (testpath/"request.json").write("{}")
    assert_match "version", shell_output("#{bin}/pingone-runner validate --request #{testpath}/request.json 2>&1", 1)
  end
end
