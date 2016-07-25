require 'spec_helper'
require 'securerandom'

describe Brandcaptcha::Client do
  let(:private_key) { SecureRandom.hex }
  let(:public_key) { SecureRandom.hex }

  subject { Brandcaptcha::Client.new private_key, public_key}

  it 'has a version number' do
    expect(Brandcaptcha::VERSION).not_to be nil
  end

  describe '#script_tag' do
    describe 'query params' do
      it 'should contain public key' do
        raw = subject.script_tag
        expect(raw).to include("k=#{public_key}".freeze)
      end

      it 'should contain error callback' do
        params = { error: 'error_callback'.freeze }
        raw = subject.script_tag params
        expect(raw).to include("error=#{params.fetch :error}".freeze)
      end

      it 'should contain tag container' do
        params = { tags: 'tag_id'.freeze }
        raw = subject.script_tag params
        expect(raw).to include("tags=#{params.fetch :tags}".freeze)
      end

      it 'should use security protocol' do
        params = { ssl: true }
        raw = subject.script_tag params
        expect(raw).to include('https://'.freeze)
      end
    end
  end

  describe '#check_answer' do
    let(:captcha) { SecureRandom.hex }
    let(:challenge) { SecureRandom.hex }
    let(:remote_ip) { SecureRandom.hex }

    it 'should not accept empty captcha' do
      captcha = ''
      expect { subject.check_answer(captcha, challenge, remote_ip) }.to raise_error Brandcaptcha::Exception
    end

    it 'should not accept empty challenge' do
      challenge = ''
      expect { subject.check_answer(captcha, challenge, remote_ip) }.to raise_error Brandcaptcha::Exception
    end

    it 'should not accept empty remote ip' do
      remote_ip = ''
      expect { subject.check_answer(captcha, challenge, remote_ip) }.to raise_error Brandcaptcha::Exception
    end
  end
end
