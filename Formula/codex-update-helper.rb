class CodexUpdateHelper < Formula
  desc "Safely finish Codex desktop updates already staged by Sparkle"
  homepage "https://github.com/exprmntl/codex-update-helper"
  url "https://github.com/exprmntl/codex-update-helper.git",
      tag:      "v0.1.1",
      revision: "3e77bd0e69891d92f9b51a6fbf1609f96440fe9e"
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
