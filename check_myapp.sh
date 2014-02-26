if pgrep -n ruby
    then
        echo "Running"
    else
        echo "Not running"
        ruby myapp.rb
    fi
