class Megatools < Formula
  desc "Command-line client for Mega.co.nz"
  homepage "https://megatools.megous.com/"
  url "https://megatools.megous.com/builds/experimental/megatools-1.11.0-git-20200503.tar.gz"
  version "1.11.0"
  sha256 "ff203193190077a52a542858050a1579a59e1a2e59162cb8f9d1e396b446d5c5"
  license "GPL-2.0"

  depends_on "asciidoc" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "glib-networking"
  depends_on "openssl"

  uses_from_macos "curl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "-j4"
    system "make", "install"
  end

  test do
    # Downloads a publicly hosted file and verifies its contents.
    system "#{bin}/megadl",
      "https://mega.co.nz/#!3Q5CnDCb!PivMgZPyf6aFnCxJhgFLX1h9uUTy9ehoGrEcAkGZSaI",
      "--path", "testfile.txt"
    assert_equal File.read("testfile.txt"), "Hello Homebrew!\n"
  end
end
