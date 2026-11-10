class Saku < Formula
  desc "A minimal and clean task manager for your terminal"
  homepage "https://asierzapata.github.io/saku/"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asierzapata/saku/releases/download/v0.14.0/saku-tdo-aarch64-apple-darwin.tar.xz"
      sha256 "bd9c5a07b5f9b37e9c17c9404431e81517af139a1553db58f81549b69af9e2f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asierzapata/saku/releases/download/v0.14.0/saku-tdo-x86_64-apple-darwin.tar.xz"
      sha256 "b1749fac5282f2c4d729b6c78e3bfaa2031d200f87baffc6ff1061daa574cb8c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asierzapata/saku/releases/download/v0.14.0/saku-tdo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d19b4b7324e5bc6285284438a14baeb950d107d376564505b5e139c1511b5873"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asierzapata/saku/releases/download/v0.14.0/saku-tdo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7580c33278a0d049d1fd9f61924757fb6933709576d69da931e8f2e23178fe9f"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "tdo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tdo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tdo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tdo"
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
