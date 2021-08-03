#!/usr/bin/env ruby
# gitlab-ci YAML generator for dynamic build matrices

require 'getoptlong'

###############################################################################

USAGE_STR = <<END_OF_USAGE
./gen_gitlab_yml.rb [options]

    --prefix   -p  <prefix>   specify the image prefix to which the tag will be appended (require)
    --flavor   -f  <flavor>   specify build <flavor>, can do multiple (default: 'all', all flavors)
    --onload   -o  <version>  specify onload <version> to build (default is 'latest')
    --zf           <truthy>   build with TCPDirect (zf)  (or not, if optional <truthy> is '0' or 'false')

    --template -t  <truthy>   generate template section

    --help     -h             show this help

END_OF_USAGE

$opts = {
    :template  => false,
    :prefix    => nil,
    :ooversion => 'latest',
    :flavors   => [],
    :zf        => false
}

begin
    GetoptLong.new(
        [ '--prefix',   '-p', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--flavor',   '-f', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--onload',   '-o', GetoptLong::REQUIRED_ARGUMENT ],
        [ '--zf',             GetoptLong::OPTIONAL_ARGUMENT ],
        [ '--template', '-t', GetoptLong::OPTIONAL_ARGUMENT ],
        [ '--help',     '-h', GetoptLong::NO_ARGUMENT ]
    ).each do |opt, arg|
        case opt
        when '--prefix'
            if !$opts[:prefix].nil? then
                STDERR << "ERROR: --prefix can only be specified once\n"
                exit(-1)
            end
            $opts[:prefix] = arg
        when '--onload'
            if $opts[:ooversion] != 'latest' then
                STDERR << "ERROR: --onload can only be specified once\n"
                exit(-1)
            end
            $opts[:ooversion] = arg
        when '--flavor'
            $opts[:flavors] << arg
        when '--zf'
            $opts[:zf] = true
            $opts[:zf] = false if arg == '0' || arg.downcase == 'false'
        when '--template'
            $opts[:template] = true
            $opts[:template] = false if arg == '0' || arg.downcase == 'false'
        when '--help'
            $opts[:action] = :help
        end
    end
rescue StandardError => e
    STDERR << "ERROR: #{e.to_s}\n"
    exit(-1)
end

if $opts[:prefix].nil? && !$opts[:template] then
    STDERR << "ERROR: --prefix must be specified\n"
    exit(-1)
end

###############################################################################

def gen_template()
    return <<~YML
# Builds all the flavors for the given image tag
# variables:
#   IMAGE_PREFIX
#   ONLOAD_VERSION
#   FLAVOR
#   USE_ZF
.docker_build_onload_template:
    stage: build
    image: docker:latest
    services:
    - docker:dind
    retry: 1
    before_script:
    - apk add --update ruby
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER $CI_REGISTRY --password-stdin
    script:
    - |
        IMAGE_NAME_DEST=$(./build_onload_image.rb -o $ONLOAD_VERSION -f $FLAVOR -a "$IMAGE_PREFIX" --zf $USE_ZF --gettag)
        docker pull $IMAGE_NAME_DEST || true
        ./build_onload_image.rb -o $ONLOAD_VERSION -f $FLAVOR -a "$IMAGE_PREFIX" --zf $USE_ZF --execute --push
        IMAGE_NAME_SHA=$(./build_onload_image.rb -o $ONLOAD_VERSION -f $FLAVOR -a "$IMAGE_PREFIX$CI_COMMIT_SHA-" --zf $USE_ZF --gettag)
        docker tag $IMAGE_NAME_DEST $IMAGE_NAME_SHA
        docker push $IMAGE_NAME_SHA

YML
end

###############################################################################

def gen_build_stanza(prefix, flavor, ooversion, use_zf)
    zf = use_zf ? "zf" : ""
    zfarg = use_zf ? "--zf " : ""

    return <<~YML
onload#{zf}-#{flavor}-#{ooversion}:
  stage: build
  extends: .docker_build_onload_template
  variables:
    IMAGE_PREFIX: "#{prefix}"
    ONLOAD_VERSION: "#{ooversion}"
    FLAVOR: "#{flavor}"
    USE_ZF: "#{use_zf.to_s}"

YML
end

###############################################################################

if $opts[:template] then
    STDOUT << gen_template()
end

if $opts[:flavors].empty? then
    %x{ ls -d */ | grep -v _archive | sed 's/\\///g' | sort }.each_line do |flavor|
        $opts[:flavors] << flavor.strip
    end
end

$opts[:flavors].each do |flavor|
    STDOUT << gen_build_stanza($opts[:prefix], flavor, $opts[:ooversion], $opts[:zf])
end
