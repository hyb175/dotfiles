function kcg --wraps='kubectl config get-contexts' --description 'alias kcg=kubectl config get-contexts'
  kubectl config get-contexts $argv
        
end
