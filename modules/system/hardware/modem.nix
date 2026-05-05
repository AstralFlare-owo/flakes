{ pkgs, ... }: {
    programs.calls.enable = true;
    
    environment.systemPackages = with pkgs; [
        chatty
        modem-manager-gui
    ];
}