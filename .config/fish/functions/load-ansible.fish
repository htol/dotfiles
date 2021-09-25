function load-ansible
    set A ~/.local/ansible
    set AVENV {$A}/venv
    if test -d {$AVENV}
        echo "Loading venv"
        . {$AVENV}/bin/activate.fish
    else
        echo "Creating venv"
        cd {$A}
        python3 -m venv venv
        . {$AVENV}/bin/activate.fish
        echo "Installing requirements"
        pip install -r requirements.txt
    end

    if test -f ~/.local/ansible/hacking/env-setup.fish
        source ~/.local/ansible/hacking/env-setup.fish
        echo "Ansible environment loaded"
    end
end
  
