# Nmunch

![OM NOM NOM NOM](https://dl.dropbox.com/u/70881769/omnomnomnom.jpg)

Nmunch is a simple passive network discovery tool to find live nodes just by
listening to [ARP][arp] and broadcast packets on a network interface.

The main reason why I built this tool was mostly to have an excuse to play around
with the [ruby-pcap gem][ruby-pcap], but it turned out to be quite useful and the
architecture is flexible enough to extend the tool to do pretty much anything
with a discovered node.

## Installation

    gem install nmunch

## Usage

Nmunch is pretty straight-forward and supports two different methods:

### Listen on a network device

    nmunch -i <device name>

To find the names of your network devices, use `ifconfig` in a terminal. Usually,
they are called `eth0`, `en1`, etc.

To stop listening, simply press `Ctrl`+`C` to interrupt. It might take a couple of
seconds before it reacts.


### Analyze a PCAP capture file

Nmunch can also find nodes from a `pcap` capture file:

    nmunch -f <path/to/pcap/file.pcap>

### See all options

To see all options for Nmunch, type:

    nmunch --help

## Extending Nmunch

I have tried to keep the architecture pretty flexible with a simple *publish/subscribe* pattern for handling the discovered nodes. So if you want all nodes to be pwned by your secret 0day spl0itz, you can write a new node subscriber to do that for you. Have a look at `Nmunch::Subscriber::Stdout` for an example of how to write a node subscriber

### *Y U NO capture [insert protocol name] to find more nodes!?!1*

The current version of Nmunch only looks for [ARP][arp] and broadcast IP packets which captures quite a lot of nodes, but if you have more ideas, you can easily make a new packet dissector to handle it. see `Nmunch::Dissectors::Arp` for an example of how to write a packet dissector.

## Roadmap

This is what I have on the roadmap for Nmunch:

### ▢ More tests
### ▢ Improve documentation
### ▢ Export results in formats compatible with other tools
### ▢ Easier way to register custom node subscribers
### ▢ Extract more interesting information apart from live nodes
### ▢ Make a [Metasploit] Auxiliary module version of Nmunch

## Contributing

Feel free to file an issue, even if you don't have time to submit a patch.

Please try to include tests for any patch you submit.  If you don't include tests, I'll have to write one, and it'll take longer to get your code in.

## License

Copyright (c) 2012 Michael Henriksen

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[arp]: http://en.wikipedia.org/wiki/Address_Resolution_Protocol "Address Resolution Protocol"
[ruby-pcap]: https://github.com/ahobson/ruby-pcap
[metasploit]: http://www.metasploit.com/ "Metasploit penetration testing framework"