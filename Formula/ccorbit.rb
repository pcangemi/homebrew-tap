class Ccorbit < Formula
  desc "A live, read-only terminal view of every Claude Code session on this machine: wall, 3D HUD, code city"
  homepage "https://github.com/pcangemi/ccorbit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pcangemi/ccorbit/releases/download/v0.2.0/ccorbit-aarch64-apple-darwin.tar.xz"
      sha256 "6cbec8b914127cd50a3f13be6b3f24683a1dec857cc25e747813424023f71f00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pcangemi/ccorbit/releases/download/v0.2.0/ccorbit-x86_64-apple-darwin.tar.xz"
      sha256 "e2116ab257b397b70aff67f13e30941eeefcf4964846a06ccf905d96dc9e295a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pcangemi/ccorbit/releases/download/v0.2.0/ccorbit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "29a4c9e8008fc9c2726cb5612b6abc1e74ce9996fb9d5abcc6bada33968e0897"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pcangemi/ccorbit/releases/download/v0.2.0/ccorbit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "16adf33a2669a75832eaa0a01279e7e99192569f80a321d9c583360cd961dce4"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
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
      bin.install "ccorbit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ccorbit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ccorbit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ccorbit"
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
