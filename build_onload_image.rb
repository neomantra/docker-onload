#!/usr/bin/env ruby
# Build helper for OpenOnload Docker images
# Copyright (c) 2015-2021 Neomantra BV.

require 'getoptlong'

$ONLOAD_VERSIONS = {
    '8.1.3.40' => {
        :version => '8.1.3.40',
        :zf_version => '8.1.3.8',
        :driverid => 'c71e5318f0cc60edbe8fb390bb778a5d',
        :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/8-1-3-40/SF-109585-LS-44-OpenOnload-Release-Package.zip',
        :md5sum => '2cf23e45999e4c411c32ea13e91bcc49', 
        :zf_package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/tcpdirect/8-1-3-8/XN-201046-LS-7-TCPDirect-Release-Package.zip',
        :zf_md5sum => '48a42da3468244d0bf65a97ebbea05cd'
    },
    '8.1.2.26' => {
        :version => '8.1.2.26',
        :zf_version => '8.1.2.38',
        :driverid => '55285faa7791a719ba067d52108964c4',
        :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/8_1_2_26/SF-109585-LS-43-OpenOnload-Package.zip',
        :md5sum => 'b758408d51aec33f36e698009173eb13', 
        :zf_package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/tcpdirect/8_1_2_38/XN-201046-LS-6-TCPDirect-Release-Package.zip',
        :zf_md5sum => '2d50b5da3d3cbb49384eb95d8765d1a2'
    },
    '8.1.1.17' => {
        :version => '8.1.1.17',
        :zf_version => '8.1.1.23',
        :driverid => '1d52732765feca797791b9668b14fb4e',
        :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/8-1-1-17/SF-109585-LS-42-OpenOnload-Release-Package.zip',
        :md5sum => 'd3845b7c35798787de551e09e4272785', 
        :zf_package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/tcpdirect/8-1-1-23/XN-201046-LS-5-TCPDirect-Release-Package.zip',
        :zf_md5sum => 'f966ad385cec3d632d3a6b9bb1ce64d9'
    },
   '8.1.0.15' => {
        :version => '8.1.0.15',
        :zf_version => '8.1.0.19',
        :driverid => '1d52732765feca797791b9668b14fb4e',
        :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/8_1_0_15/SF-109585-LS-41-OpenOnload-Release-Package.zip',
        :md5sum => 'a016c90b5a1bc98ed4fef8d9e6407839', 
        :zf_package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/tcpdirect/8_1_0_19/XN-201046-LS-4-TCPDirect-Release-Package.zip',
        :zf_md5sum => 'e36bc271f3c4fe25a8bb8498e9799206'
    },
    '7.1.3.202'   => { :version => '7.1.3.202',   :md5sum => '6153f93f03c65b4d091e9247c195b58c', :driverid => '1d52732765feca797791b9668b14fb4e', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/7-1-3-202/SF-109585-LS-37-OpenOnload-release-package.zip' },
    '7.1.2.141'   => { :version => '7.1.2.141',   :md5sum => 'bfda4a68267e2aa3d5bed02af229b4fc', :driverid => '1d52732765feca797791b9668b14fb4e', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/7-1-2-141/SF-109585-LS-36_OpenOnload_Release_Package.zip' },
    '7.1.1.75'    => { :version => '7.1.1.75',    :md5sum => '39b2d8d40982f6f3afd3cdb084969e90', :driverid => '65869c81c4a7f92b75316cf88446a9f1', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/7-1-1-75/SF-109585-LS-35_OpenOnload_Release_Package.zip' },
    '7.1.0.265'   => { :version => '7.1.0.265',   :md5sum => '4db72fe198ec88d71fb1d39ef60c5ba7', :driverid => 'd9857bc9bddb5c6abdeb3f22d69b21d1', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/7-1-0-265/SF-109585-LS-33_OpenOnload_Release_Package.zip' },
    '7.0.0.176'   => { :version => '7.0.0.176',   :md5sum => '851ccf4fc76c96bcbeb01e1c57b20cce', :driverid => '6ac17472788a64c61013f3d7ed9ae4c9', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/7-0-0-176/SF-109585-LS-32_OpenOnload_Release_Package.zip' },
    '201811-u1'   => { :version => '201811-u1',   :md5sum => '357e64862aa4145e49d218fd04e63407', :driverid => '2d850c0cd0616655dc3e31c7937acaf7', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201811-u1/SF-109585-LS-31_OpenOnload_Release_Package.zip' },
    '201811'      => { :version => '201811',      :md5sum => 'fde70da355e11c8b4114b54114a35de1', :driverid => '357bb6508f1e324ea32da88f948efafa', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201811/SF-109585-LS-30_OpenOnload_Release_Package.zip' },
    '201805-u1'   => { :version => '201805-u1',   :md5sum => 'f3b3761b4bfd74fec311fa0fe380ec0a', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201805-u1/SF-109585-LS-28_OpenOnload_Release_Package.zip' },
    '201805'      => { :version => '201805',      :md5sum => 'cbc523076c63b61fc853094a9af25e56', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201805/SF-109585-LS-27_OpenOnload_Release_Package.zip' },
    '201710-u1.1' => { :version => '201710-u1.1', :md5sum => '99593ea209282ea669c1c0618e15bb02', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201710-u1-1/SF-109585-LS-26_OpenOnload_Release_Package.zip' },
    '201710-u1'   => { :version => '201710-u1',   :md5sum => '725ec834ee08720b36a161944a02cf2a', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201710-u1/SF-109585-LS-25_OpenOnload_Release_Package.zip' },
    '201710'      => { :version => '201710',      :md5sum => 'f22e9046694c11d83ca1ad520f7e8c4a', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201710/SF-109585-LS-24_OpenOnload_Release_Package.zip' },
    '201606-u1.3' => { :version => '201606-u1.3', :md5sum => '4313539336d14df264e5b945486f9e92', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201606-u1-3/SF-109585-LS-23_OpenOnload_Release_Package.zip' },
    '201606-u1.2' => { :version => '201606-u1.2', :md5sum => 'fd3993a35b9e18aa32cb86fb9502623b', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201606-u1-2/SF-109585-LS-22_OpenOnload_Release_Package.zip' },
    '201606-u1.1' => { :version => '201606-u1.1', :md5sum => 'f8ff1f18208dc95e912c636177b88bb1', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201606-u1-1/SF-109585-LS-21_OpenOnload_Release_Package.zip' },
    '201606-u1'   => { :version => '201606-u1',   :md5sum => '21d242f4da8d48eb825e0c95c5010883', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201606-u1/SF-109585-LS-20_OpenOnload_Release_Package.zip' },
    '201606'      => { :version => '201606',      :md5sum => 'a94dc9b45bda85096814d85e366afdea', :package_url => 'https://www.xilinx.com/content/dam/xilinx/publications/solarflare/onload/openonload/201606/SF-109585-LS-19_OpenOnload_Release_Package.zip' },
    '201509-u1'   => { :version => '201509-u1',   :md5sum => '01192799b6e932a043fdf27f5c28e6be' }
}
$ONLOAD_VERSIONS['latest'] = $ONLOAD_VERSIONS['7.1.3.202'].dup

$IMAGE_FLAVORS = {
    'bionic'   => { :flavor => 'bionic' },
    'bookworm' => { :flavor => 'bookworm' },
    'bullseye' => { :flavor => 'bullseye' },
    'buster'   => { :flavor => 'buster' },
    'centos7'  => { :flavor => 'centos7' },
    'centos8'  => { :flavor => 'centos8' },
    'focal'    => { :flavor => 'focal' },
    'jammy'    => { :flavor => 'jammy' },
    'noble'    => { :flavor => 'noble' },
}
# Archived Image Flavors
#   'cosmic'   => { :flavor => 'cosmic' },
#   'disco'    => { :flavor => 'disco' },
#   'precise'  => { :flavor => 'precise' },
#   'stretch'  => { :flavor => 'stretch' },
#   'trusty'   => { :flavor => 'trusty' },
#   'xenial'   => { :flavor => 'xenial' }

###############################################################################

USAGE_STR = <<END_OF_USAGE
build_onload_image.rb [options]

ACTIONS
    --versions                show list of onload version name (use with -v to show all fields)
    --flavors                 show list of image flavors
    --gettag      <prefix>    show the autotag name of --autotag <prefix>

    --build                   show docker build command
    --execute                 execute docker build command

OPTIONS
    --flavor   -f  <flavor>   specify build <flavor> (required for --build or --execute)
    --onload   -o  <version>  specify onload <version> to build (default is 'latest')

    --url      -u  <url>      Override URL for "packaged" versions.

    --tag      -t  <tag>      tag image as <tag>
    --autotag  -a  <prefix>   tag image as <prefix><version>-<flavor>[-nozf]. 
                                 <prefix> is optional, but note without a <prefix> with colon,
                                 the autotag will be a name not an image-name:tag

    --zf           <truthy>   build with TCPDirect (zf)  (or not, if optional <truthy> is '0' or 'false')

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
    :ooversion => 'latest',
    :flavor    => nil,
    :tag       => nil,
    :autotag   => nil,
    :buildargs => [],
    :zf        => false,
    :dockerfwd => [],
    :quiet     => false,
    :cache     => true,
    :verbose   => 0
}

begin
    GetoptLong.new(
        [ '--versions',       GetoptLong::NO_ARGUMENT ],
        [ '--flavors',        GetoptLong::NO_ARGUMENT ],
        [ '--gettag',         GetoptLong::OPTIONAL_ARGUMENT ],
        [ '--build',          GetoptLong::NO_ARGUMENT ],
        [ '--onload',   '-o', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--flavor',   '-f', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--url',      '-u', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--tag',      '-t', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--autotag',  '-a', GetoptLong::OPTIONAL_ARGUMENT ],
        [ '--arg',            GetoptLong::REQUIRED_ARGUMENT ],
        [ '--fwd',            GetoptLong::REQUIRED_ARGUMENT ],
        [ '--zf',             GetoptLong::OPTIONAL_ARGUMENT ],
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
        when '--gettag'
            $opts[:action] = :gettag
            $opts[:autotag] = arg || '' if $opts[:autotag].nil?
        when '--build'
            $opts[:action] = :build
        when '--onload'
            if $opts[:ooversion] != 'latest' then
                STDERR << "ERROR: --onload can only be specified once\n"
                exit(-1)
            end
            $opts[:ooversion] = arg
        when '--flavor'
            if ! $opts[:flavor].nil? then
                STDERR << "ERROR: --flavor can only be specified once\n"
                exit(-1)
            end
            $opts[:flavor] = arg
        when '--url'
            $opts[:url] = arg
        when '--tag'
            $opts[:tag] = arg
        when '--autotag'
            $opts[:autotag] = arg
        when '--arg'
            $opts[:buildargs] << arg
        when '--fwd'
            $opts[:dockerfwd] << arg
        when '--zf'
            $opts[:zf] = true
            $opts[:zf] = false if arg == '0' || arg.downcase == 'false'
        when '--quiet'
            $opts[:quiet] = true
        when '--no-cache'
            $opts[:cache] = false
        when '--execute'
            $opts[:action] = :build
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

def get_version()
    version = $opts[:ooversion]
    if version.nil? then
        STDERR << "ERROR: a valid version must be specified with --build (-b).  List with --versions\n"
        exit(-1)
    end
    if ! $ONLOAD_VERSIONS.has_key? version then
        STDERR << "ERROR: unknown onload version '#{version}'.  List with --versions\n"
        exit(-1)
    end
    return version
end


def get_flavor()
    flavor = $opts[:flavor]
    if flavor.nil? then
        STDERR << "ERROR: a valid flavor must be specified with --flavor (-f).   List with --flavors.\n"
        exit(-1)
    end
    if ! $IMAGE_FLAVORS.has_key? flavor then
        STDERR << "ERROR: unknown flavor '#{flavor}'.  List with --flavors.\n"
        exit(-1)
    end
    return flavor
end


def get_tag()
    # check tag arguments
    if ! $opts[:tag].nil? && ! $opts[:autotag].nil? then
        STDERR << "ERROR: cannot specify both --tag and --autotag (or --gettag with argument)\n"
        exit(-1)
    end

    if ! $opts[:tag].nil? then
        return $opts[:tag]
    end

    version = get_version()
    flavor = get_flavor()
    tag = $opts[:tag]
    if $opts[:autotag] then
        tag = "#{$opts[:autotag]}#{version}-#{flavor}#{$opts[:zf] ? "" : "-nozf"}"
    end
    return tag
end



###############################################################################


case $opts[:action]
when :versions
    if $opts[:verbose] == 0 then
        $ONLOAD_VERSIONS.each do |k, v|
            next if k == 'latest'
            STDOUT << sprintf("%s\n", v[:version])
        end
    else
        $ONLOAD_VERSIONS.each do |k, v|
            next if k == 'latest'
            STDOUT << sprintf("%-16s %s %s %s\n",
                v[:version], v[:md5sum],
                v[:driverid] || "",
                v[:package_url] || "")
        end
    end
when :flavors
    $IMAGE_FLAVORS.each do |k, v|
        STDOUT << sprintf("%s\n", v[:flavor])
    end
when :gettag
    if $opts[:tag].nil? && $opts[:autotag].nil? then
        STDERR << "ERROR: must specify either --tag and --autotag (or --gettag with argument)\n"
        exit(-1)
    end
    STDOUT << get_tag() << "\n"
when :build
    tag = get_tag()

    if $opts[:push] && !$opts[:execute] then
        STDERR << "--push requires --execute\n"
        exit(-1)
    end
    if $opts[:push] && tag.nil? then
        STDERR << "--push requires --tag or --autotag\n"
        exit(-1)
    end

    version = get_version()
    vdata = $ONLOAD_VERSIONS[version]
    cmd = "docker build --build-arg ONLOAD_VERSION=#{vdata[:version]} --build-arg ONLOAD_MD5SUM=#{vdata[:md5sum]} "
    package_url = $opts[:url] || vdata[:package_url]
    if ! package_url.nil? then
        cmd += " --build-arg ONLOAD_PACKAGE_URL='#{package_url}' "
    else
        # Force an empty OPEN_PACKAGE_URL to build legacy
        cmd += " --build-arg ONLOAD_PACKAGE_URL='' "
    end

    if $opts[:zf] then
        cmd += "--build-arg ONLOAD_WITHZF=1 "
        cmd += "--build-arg ONLOADZF_VERSION='#{vdata[:zf_version]}' " if vdata[:zf_version]
        cmd += "--build-arg ONLOADZF_PACKAGE_URL='#{vdata[:zf_package_url]}' " if vdata[:zf_package_url]
        cmd += "--build-arg ONLOADZF_MD5SUM='#{vdata[:zf_md5sum]}' " if vdata[:zf_md5sum]
    end
    $opts[:buildargs].each { |arg| cmd += "--build-arg #{arg} " }

    cmd += "-q " if $opts[:quiet]
    cmd += "--no-cache " if ! $opts[:cache]
    cmd += "-t #{tag} " if ! tag.nil?

    flavor = get_flavor()
    cmd += "-f #{flavor}/Dockerfile "

    $opts[:dockerfwd].each { |fwd| cmd += " #{fwd} " }

    cmd += " ."

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
