{ ... }: {
  programs.openclaw = {
    enable = true;
    # Avoid bin/corepack collision with user's own nodejs package.
    excludeTools = [ "nodejs_22" ];
  };
}
