class ProofableCli < Formula
  desc "Certifying any digital assets (files) to public blockchains"
  homepage "https://docs.proofable.io"
  url "https://github.com/SouthbankSoftware/proofable/archive/v0.2.13.tar.gz"
  SHA256: da20b443081ab84b6857c00a9796adf95f82f6accb37945387f253bf6b999fbe
  license "AGPL-3.0"
  head "https://github.com/SouthbankSoftware/proofable.git"

  depends_on "go" => :build

  def install
    ENV["APP_VERSION"] = version
    system "make", "build"
    bin.install "proofable-cli"
  end

  test do
    cert_path = "cli.proofable"
    # `proofable-cli` should:
    # 1. be able to create a blockchain certificate of itself
    shell_output("#{bin}/proofable-cli create proof \"#{bin}/proofable-cli\" -p \"#{cert_path}\" "\
                 "-t HEDERA --include-metadata --dev-token=magic "\
                 "--api.host-port=\"api.dev.proofable.io:443\"")
    # 2. verify the certificate. Here the cli should remember last token and API hostport
    shell_output("#{bin}/proofable-cli verify proof \"#{bin}/proofable-cli\" -p \"#{cert_path}\"")
  end
end
