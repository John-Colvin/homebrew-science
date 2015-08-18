class Clfft < Formula
  desc "FFT functions written in OpenCL"
  homepage "https://github.com/clMathLibraries/clFFT/"
  url "https://github.com/clMathLibraries/clFFT/archive/v2.6.1.tar.gz"
  sha256 "2b5b15b903baeef4dcea6bb8efbe6aba284510148c04d20f9b151a94ae71c050"

  patch do
    # New timer implementation for OS X
    url "https://github.com/clMathLibraries/clFFT/commit/e4063ef4541cd34951b25b38d429f199a15f8e14.diff"
    sha256 "6c46e429d368a95afa030f6865c392ee0a76d4fa8c7fb55daef88595fb7a5b72"
  end

  bottle do
    cellar :any
    sha256 "fd803537e3af8d9189852ac87001d6be4562f5a20a9d8cb11d799548dbc71bb5" => :yosemite
    sha256 "8265a5b1a675ad57825240e75cc58bf3a83996808019f6fc43cc7c55c78fc8c8" => :mavericks
    sha256 "135f7e329b29dbadf53bfa4c6b8110800fefc013edbf88c5263b8618ff3008e9" => :mountain_lion
  end

  depends_on "cmake" => :build
  depends_on "boost" => :build

  def install
    mkdir "build"
    cd "build"
    system "cmake", "../src", "-DBUILD_EXAMPLES:BOOL=OFF", "-DBUILD_TEST:BOOL=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/clFFT-client", "-i"
    # apple's opencl for cpu has a known bug that makes clfft fail on cpu, so force gpu
    system "#{bin}/clFFT-client", "-g", "-x", "192", "-y", "108", "--inLayout", "5", "--outLayout", "3"
  end
end
