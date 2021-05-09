#!/usr/bin/env ruby
# Build helper for OpenOnload Docker images
# Copyright (c) 2015-2021 Neomantra BV.

require 'getoptlong'

ONLOAD_VERSIONS = {
    '7.1.0.265'   => { :version => '7.1.0.265',   :md5sum => '4db72fe198ec88d71fb1d39ef60c5ba7', :driverid => 'd9857bc9bddb5c6abdeb3f22d69b21d1', :package_url => "https://support.solarflare.com/wp/onload?sd=SF-109585-LS-33&pe=SF-122921-DH-2" },
    '7.0.0.176'   => { :version => '7.0.0.176',   :md5sum => '851ccf4fc76c96bcbeb01e1c57b20cce', :driverid => '6ac17472788a64c61013f3d7ed9ae4c9', :package_url => "https://support.solarflare.com/wp/onload?sd=SF-109585-LS-32&pe=SF-122921-DH-2" },
    '201811-u1'   => { :version => '201811-u1',   :md5sum => '357e64862aa4145e49d218fd04e63407', :driverid => '2d850c0cd0616655dc3e31c7937acaf7' },
    '201811'      => { :version => '201811',      :md5sum => 'fde70da355e11c8b4114b54114a35de1', :driverid => '357bb6508f1e324ea32da88f948efafa' },
    '201805-u1'   => { :version => '201805-u1',   :md5sum => 'f3b3761b4bfd74fec311fa0fe380ec0a' },
    '201805'      => { :version => '201805',      :md5sum => 'cbc523076c63b61fc853094a9af25e56' },
    '201710-u1.1' => { :version => '201710-u1.1', :md5sum => '99593ea209282ea669c1c0618e15bb02' },
    '201710-u1'   => { :version => '201710-u1',   :md5sum => '725ec834ee08720b36a161944a02cf2a' },
    '201710'      => { :version => '201710',      :md5sum => 'f22e9046694c11d83ca1ad520f7e8c4a' },
    '201606-u1.3' => { :version => '201606-u1.3', :md5sum => '4313539336d14df264e5b945486f9e92' },
    '201606-u1.2' => { :version => '201606-u1.2', :md5sum => 'fd3993a35b9e18aa32cb86fb9502623b' },
    '201606-u1.1' => { :version => '201606-u1.1', :md5sum => 'f8ff1f18208dc95e912c636177b88bb1' },
    '201606-u1'   => { :version => '201606-u1',   :md5sum => '21d242f4da8d48eb825e0c95c5010883' },
    '201606'      => { :version => '201606',      :md5sum => 'a94dc9b45bda85096814d85e366afdea' },
    '201509-u1'   => { :version => '201509-u1',   :md5sum => '01192799b6e932a043fdf27f5c28e6be' }
}

IMAGE_FLAVORS = {
    'bionic'   => { :flavor => 'bionic' },
    'buster'   => { :flavor => 'buster' },
    'centos7'  => { :flavor => 'centos7' },
    'centos8'  => { :flavor => 'centos8' },
    'focal'    => { :flavor => 'focal' },
    'stretch'  => { :flavor => 'stretch' },
    'trusty'   => { :flavor => 'trusty' },
    'xenial'   => { :flavor => 'xenial' }
}
# Archived Image Flavors
#   'cosmic'   => { :flavor => 'cosmic' },
#   'disco'    => { :flavor => 'disco' },
#   'precise'  => { :flavor => 'precise' },

###############################################################################

USAGE_STR = <<END_OF_USAGE
build_onload_image.rb [options]

    --versions                show list of onload version name (use with -v to show all fields)
    --flavors                 show list of image flavors

    --onload   -o  <version>  show docker build for OpenOnload <version>
    --flavor   -f  <flavor>   add <flavor> to build

    --url      -u <url>       Override URL for "packaged" versions.

    --tag      -t <tag>       tag image as <tag>
    --autotag  -a <prefix>    tag image as <prefix><version>-<flavor>[-nozf]. 
                              <prefix> is optional, but note without a <prefix> with colon,
                              the autotag will be a name not an image-name:tag

    --zf                      build with TCPDirect (zf)

    --arg          <arg>      pass '--build-arg <arg>' to "docker build"

    --quiet    -q             build quietly (pass -q to "docker build")
    --no-cache                pass --no-cache to "docker build"

    --execute  -x             also execute the build line

    --push     -p             push the built image

    --verbose  -v             verbose output
    --help     -h             show this help
END_OF_USAGE

$opts = {
    :action    => nil,
    :execute   => false,
    :push      => false,
    :version   => nil,
    :flavor    => nil,
    :tag       => nil,
    :autotag   => nil,
    :buildargs => [],
    :zf        => false,
    :quiet     => false,
    :cache     => true,
    :verbose   => 0
}

begin
    GetoptLong.new(
        [ '--versions',       GetoptLong::NO_ARGUMENT ],
        [ '--flavors',        GetoptLong::NO_ARGUMENT ],
        [ '--onload',   '-o', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--flavor',   '-f', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--url',      '-u', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--tag',      '-t', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--autotag',  '-a', GetoptLong::OPTIONAL_ARGUMENT ],
        [ '--arg',            GetoptLong::REQUIRED_ARGUMENT ],
        [ '--zf',             GetoptLong::NO_ARGUMENT ],
        [ '--quiet',    '-q', GetoptLong::NO_ARGUMENT ],
        [ '--no-cache',       GetoptLong::NO_ARGUMENT ],
        [ '--execute',  '-x', GetoptLong::NO_ARGUMENT ],
        [ '--push',     '-p' ,GetoptLong::NO_ARGUMENT ],
        [ '--verbose',  '-v', GetoptLong::NO_ARGUMENT ],
        [ '--help',     '-h', GetoptLong::NO_ARGUMENT ]
    ).each do |opt, arg|
        case opt
        when '--versions'
            $opts[:action] = :versions    
        when '--flavors'
            $opts[:action] = :flavors    
        when '--onload'
            if ! $opts[:version].nil? then
                STDERR << "ERROR: --build can only be specified once\n"
                exit(-1)
            end
            $opts[:action] = :build
            $opts[:version] = arg
        when '--flavor'
            if ! $opts[:flavor].nil? then
                STDERR << "ERROR: --flavor can only be specified once\n"
                exit(-1)
            end
            $opts[:action] = :build
            $opts[:flavor] = arg
        when '--url'
            $opts[:url] = arg
        when '--tag'
            $opts[:tag] = arg
        when '--autotag'
            $opts[:autotag] = arg
        when '--arg'
            $opts[:buildargs] << arg
        when '--zf'
            $opts[:zf] = true
        when '--quiet'
            $opts[:quiet] = true
        when '--no-cache'
            $opts[:cache] = false
        when '--execute'
            $opts[:execute] = true
        when '--push'
            $opts[:push] = true
        when '--verbose'
            $opts[:verbose] += 1
        when '--help'
            $opts[:action] = :help
        end
    end
rescue StandardError => e
    STDERR << "ERROR: #{e.to_s}\n"
    exit(-1)
end

###############################################################################

case $opts[:action]
when :versions
    if $opts[:verbose] == 0 then
        ONLOAD_VERSIONS.each do |k, v|
            STDOUT << sprintf("%s\n", v[:version])
        end
    else
        ONLOAD_VERSIONS.each do |k, v|
            STDOUT << sprintf("%-16s %s %s %s\n",
                v[:version], v[:md5sum],
                v[:driverid] || "",
                v[:package_url] || "")
        end
    end
when :flavors
    IMAGE_FLAVORS.each do |k, v|
        STDOUT << sprintf("%s\n", v[:flavor])
    end
when :build
    V = $opts[:version]
    if V.nil? then
        STDERR << "ERROR: a valid version must be specified with --build (-b).  List with --versions\n"
        exit(-1)
    end
    if ! ONLOAD_VERSIONS.has_key? V then
        STDERR << "ERROR: unknown onload version '#{V}'.  List with --versions\n"
        exit(-1)
    end

    F = $opts[:flavor]
    if F.nil? then
        STDERR << "ERROR: a valid flavor must be specified with --flavor (-f).   List with --flavors.\n"
        exit(-1)
    end
    if ! IMAGE_FLAVORS.has_key? F then
        STDERR << "ERROR: unknown flavor '#{F}'.  List with --flavors.\n"
        exit(-1)
    end

    if ! $opts[:tag].nil? && ! $opts[:autotag].nil? then
        STDERR << "ERROR: cannot specify both --tag and --autotag\n"
        exit(-1)
    end
    tag = $opts[:tag]
    if $opts[:autotag] then
        tag = "#{$opts[:autotag]}#{V}-#{F}#{$opts[:zf] ? "" : "-nozf"}"
    end

    if $opts[:push] && !$opts[:execute] then
        STDERR << "--push requires --execute\n"
        exit(-1)
    end
    if $opts[:push] && tag.nil? then
        STDERR << "--push requires --tag or --autotag\n"
        exit(-1)
    end

    VDATA = ONLOAD_VERSIONS[V]
    cmd = "docker build --build-arg ONLOAD_VERSION=#{VDATA[:version]} --build-arg ONLOAD_MD5SUM=#{VDATA[:md5sum]} "
    package_url = $opts[:url] || VDATA[:package_url]
    if ! package_url.nil? then
        cmd += " --build-arg ONLOAD_PACKAGE_URL='#{package_url}' "
    else
        # Force an empty OPEN_PACKAGE_URL to build legacy
        cmd += " --build-arg ONLOAD_PACKAGE_URL='' "
    end

    cmd += "--build-arg ONLOAD_WITHZF=1 " if $opts[:zf]
    $opts[:buildargs].each { |arg| cmd += "--build-arg #{arg} " }

    cmd += "-q " if $opts[:quiet]
    cmd += "--no-cache " if ! $opts[:cache]
    cmd += "-t #{tag} " if ! tag.nil?

    cmd += "-f #{F}/Dockerfile ."

    STDOUT << cmd << "\n"
    if $opts[:execute] then
        res = system(cmd)
        if !res then
            STDERR << "ERROR: docker build failed with code #{$?}\n"
        elsif $opts[:push] then
            res = system("docker push #{tag}")
            if !res then
                STDERR << "ERROR: docker push failed with code #{$?}\n"
            end
        end
    end

when :help
    STDERR << USAGE_STR << "\n";
    exit(0)
when nil
    STDERR << "no action specified. try --help\n";
    exit(-1)
end
