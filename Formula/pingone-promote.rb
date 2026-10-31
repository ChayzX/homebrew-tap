class PingonePromote < Formula
  desc "Review selected PingOne configuration and submit GitLab promotion requests"
  homepage "https://github.com/ChayzX/pingone-promote"
  url "https://github.com/ChayzX/pingone-promote/releases/download/v0.2.0-rc.5/pingone-promote-v0.2.0-rc.5-source.tar.gz"
  version "0.2.0-rc.5"
  sha256 "38026ae601168bf331d55a78d4da564d27033709849fa1d0226e59eae8933b59"

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
