**Twine + Raspberry Pi + Ruby + Cron + Yahoo Weather + Google Drive + Github Pages = Wifi Temperature Logging!**

## Installation

Assuming you have a fresh install of Raspbian on your Pi, and that you have a successful network connection, you will need to install a system Ruby. 1.9.3 is what is available from the Raspbian sources.

    sudo apt-get install git-core ruby ruby-dev

With Ruby installed, you can install the bundler gem, but first you should change gemrc so that it doesn't install any documentation.

    sudo sh -c "echo 'gem: --no-ri --no-rdoc' > /etc/gemrc"
    sudo gem install bundler

We'll be using rsync to transfer the code from the local machine to the Raspberry Pi.

    rsync -avz --exclude '.git' --exclude 'Gemfile.lock' --exclude 'config/credentials.yml' ./ username@rpi-address:/twine-logging-directory/

We'll also need to run the bundle command on the Raspebrry Pi.

    sudo bundle

Make sure everything is working by performing the current temperature rake task on the Raspberry Pi.

    rake temperature:current


