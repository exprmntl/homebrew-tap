class CodexUpdateHelper < Formula
  desc "Safely finish Codex desktop updates already staged by Sparkle"
  homepage "https://github.com/exprmntl/codex-update-helper"
  url "https://github.com/exprmntl/codex-update-helper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "13669d8b25b541260d2a6c1f7822de7515bfd7a7f8eb3b8464e4149789d609b0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/codex-update-helper"
  end

  service do
    run [opt_bin/"codex-update-helper", "run"]
    run_type :interval
    interval 3600
    run_at_load true
    keep_alive false
    process_type :background
    name macos: "dev.exprmntl.codex-update-helper"
    log_path var/"log/codex-update-helper.log"
    error_log_path var/"log/codex-update-helper.error.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/codex-update-helper version").strip
    assert_match "codex-update-helper run", shell_output("#{bin}/codex-update-helper help")
  end
end
