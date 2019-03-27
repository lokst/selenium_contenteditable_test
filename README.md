# Selenium send_keys test

The aim of the project is to easily reproduce issues with selecting text in a contenteditable
div via sending the :shift :home key combination to the div through Selenium and Capybara, on
Firefox in a Linux environment. (The issue does not manifest in Chrome on Linux or Firefox on MacOS)

In order to conveniently observe the Selenium tests, this project creates a Docker image that supports VNC connections on port 5910.

## Getting Started

### Build the image
1. Clone this repository
2. Navigate to the project root
3. Run `docker build -t ubuntu_selenium_test .`

### Run the image
Run `docker run --rm --name ubuntu_selenium_test -dit -p 5909:5910 ubuntu_selenium_test`

This will create a port mapping from port 5910 (where the VNC service runs) in the `ubuntu_selenium_test`
container, to port 5909 on your host machine.

### Start a VNC session
1. Install a VNC client. Real VNC has one for macOS: https://www.realvnc.com/en/connect/download/viewer/macos/
2. Open the VNC client and connect to `localhost::5909`
3. In the VNC session, you will find an open terminal with the working directory in `/app`
4. Type `bundle exec ruby browser_test.rb` to run the Selenium tests. This will start up Firefox and run the tests,
first sending the :shift :home keys to a contenteditable div, and then sending the same key combination to an input
text field. Screenshots are also taken with Capybara and saved to the `/app/tmp` directory
on the container.
