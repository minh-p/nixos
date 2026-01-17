{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "goboscript";
  version = "3.2.1";

  src = fetchFromGitHub {
    owner = "aspizu";
    repo = "goboscript";
    rev = "v${version}";
    hash = "sha256-9JCM8SNRyiSBBy3co0ChlS/Ms8CeUex+fw6SgI3nMCs=";
  };

  cargoHash = "sha256-JeLBWVsLmsvvDsapC4nRTXsd7gzzCRP0MCv0uMVhfwA=";
}
