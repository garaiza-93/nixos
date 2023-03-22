{
  description = "Opinionated flake templates for whatever languages I use. Includes project-local neovim settings";

  outputs = { ... }: {
    templates = {
      nodets = {
        path = ./nodets;
        description = "Node create-react-app in Typescript.";
      };
      rust = {
        path = ./rust;
        description = "Cargo project for quick Rust setup.";
      };
    };
  };
}
