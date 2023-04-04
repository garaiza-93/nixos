{
  description = "Opinionated flake templates for whatever languages I use. Includes project-local neovim settings";

  outputs = { ... }: {
    templates = {
      dotnet = {
        path = ./dotnet;
        description = "Basic dotnet dev environment";
      };
      nodets = {
        path = ./nodets;
        description = "Build/run/develop node + typescript project";
      };
      rust = {
        path = ./rust;
        description = "Build/run/develop rust project";
      };
    };
  };
}
