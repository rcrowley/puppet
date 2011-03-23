require 'puppet'
require 'puppet/indirector/ssl_client'
require 'puppet/ssl/certificate_authority'
require 'puppet/ssl/certificate_request'
require 'puppet/ssl/host'

class Puppet::Indirector::SslClient::File < Puppet::Indirector::Code
  def ca
    raise ArgumentError, "This process is not configured as a certificate authority" unless Puppet::SSL::CertificateAuthority.ca?
    Puppet::SSL::CertificateAuthority.new
  end

  def save(request)
    name = request.key
    instance = request.instance

    if instance.certificate_request
      instance.certificate_request.class.indirection.save(instance.certificate_request)
    end

    ca.sign(request.key)
  end

  def search(request)
    Puppet::SSL::Host.search(:for => Puppet::SSL::CertificateRequest)
  end

end
