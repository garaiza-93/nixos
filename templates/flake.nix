{
  description = "Opinionated flake templates for whatever languages I use. Includes project-local neovim settings";

  outputs = { self, ... }: {
    templates = {
      nodets = {
        path = ./nodets;
        description = "Node create-react-app in Typescript.";
      };
    };
  };
}
