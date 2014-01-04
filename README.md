# Twine Logger

**Twine + Raspberry Pi + Ruby + Cron + Yahoo Weather + Google Drive + Github Pages = Wifi Temperature Logging!**

I love the holidays, they allow me time to play and experiment. I needed a way of logging the temperature in my apartment, then a way to display and share those results with others in my building. It could be done much easier, and with less code, but where's the fun in that?

## Installation

Assuming you have a fresh install of Raspbian on your Pi, and that you have a successful network connection, you will need to install a system Ruby. 1.9.3 is what is available from the Raspbian sources. We are not using RVM or rbenv as they add a level of complexity that is just not needed on a Raspberry Pi. If you want to run other Rubies on a Pi, just buy another Pi.

    sudo apt-get install git-core ruby ruby-dev

With Ruby installed, you can install the bundler gem, but first you should change gemrc so that it doesn't install any documentation.

    sudo sh -c "echo 'gem: --no-ri --no-rdoc' > /etc/gemrc"
    sudo gem install bundler

We'll be using rsync to transfer the code from the local machine to the Raspberry Pi.

    rsync -avz --exclude '.git' --exclude-from 'rsync-excludes.txt' ./ username@rpi-address:/var/twine-logging/

We'll also need to run the bundle command on the Raspebrry Pi.

    sudo bundle

You need to setup your credentials on the Pi. In the `config` directory on the Pi, you can copy contents of the `credentials-example.yml` file in to a new file called `credentials.yml`. There you can adjust the values for your environment.

    cat credentials-example.yml > credentials.yml

    nano credentials.yml

Make sure everything is working by performing the current temperature rake task on the Raspberry Pi.

    rake temperature:current

Add the temperature:record rake task to crontab using the absolute path to the rake command. Below would be the command for every 30 minutes.

	*/30 *  * * *   root    cd /var/twine-logging && /usr/local/bin/rake temperature:record

