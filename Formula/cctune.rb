class Cctune < Formula
  desc "Control Apple Music from the terminal and from Claude Code: commands, an MCP server and a live status line"
  homepage "https://github.com/pcangemi/cctune"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pcangemi/cctune/releases/download/v0.1.1/cctune-aarch64-apple-darwin.tar.xz"
      sha256 "74fa785c0054d85a7d29f2b6c138121f308ad4fa2d413995d5eeb5f517ad3afb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pcangemi/cctune/releases/download/v0.1.1/cctune-x86_64-apple-darwin.tar.xz"
      sha256 "1409be8ea7c9ba2af25836e2c2b27357b62bfff1ced4821db3ca592c21167613"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cctune"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cctune"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
