class PingonePromote < Formula
  desc "Review selected PingOne configuration and submit GitLab promotion requests"
  homepage "https://github.com/ChayzX/pingone-promote"
  url "https://github.com/ChayzX/pingone-promote/releases/download/v0.2.0-rc.3/pingone-promote-v0.2.0-rc.3-source.tar.gz"
  version "0.2.0-rc.3"
  sha256 "ecddd8c0efa577f7230f775dfa69d359674c16dfac6a2ef8f952005d71275243"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOTOOLCHAIN"] = "local"
    ldflags = "-X pingone-promote/internal/buildinfo.Version=v#{version}"
    system "go", "build", *std_go_args(output: bin/"pingone-promote", ldflags:), "./cmd/pingone-promote"
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
  end
end
