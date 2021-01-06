Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC92EBE15
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAFM6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 07:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAFM6p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 07:58:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20EF5229EF;
        Wed,  6 Jan 2021 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609937884;
        bh=HSMx8d9zy+tZkY9keTyJN0MxqU4glFmqhX63BZf7qyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f93pOZYmLaNT4qGfs8aJ7j9C7Y7hvOgFgp0N8HFPrG76q8mQboC2kzKhkH4i/fWDP
         c9te+0IBQw7P40nSPWAyi0tdXab7QVdGf23Ws3+k1146ZDKPChFyXpdTTvnpGCBTPK
         M+KUT6WmZt0L0x5UL3sSzg+/1ku1kxs6T01dIWIDi3zkGp8iqBo+f2T3WBBbCDS9L6
         gx+nYD1d9vjWaHrfIYGK8Cfir48CUCFgS30hqbDwTtnK3rHZtw2xSZHZ5ZdK20/Lj1
         9xrE7bIx4CEJjISblFjKTDMrLvYKt5vl/em8DFFrcAxYkREVrG7nxHMmmRLkBrR4CO
         ID/cxOJmDQg7w==
Date:   Wed, 6 Jan 2021 12:57:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI
 controller
Message-ID: <20210106125735.GB4752@sirena.org.uk>
References: <20210105232815.3218063-1-bert@biot.com>
 <20210105232815.3218063-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20210105232815.3218063-2-bert@biot.com>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 06, 2021 at 12:28:14AM +0100, Bert Vermeulen wrote:

> +    oneOf:
> +      - const: realtek,rtl838x-spi
> +      - const: realtek,rtl839x-spi

These should list exact models, not wildcards.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/1s78ACgkQJNaLcl1U
h9BWEQf+NleJ5fXZOwgfeBGDb7tGHF0T9waVgNLaLZ1hg/wrDNi9cw40Y0EieKhm
2UceJlnz4L8BSh+4RyojYk6G9sKLsqRgl2YV6Glb4RYtTxlbfAqi7RwLLz8DFlFs
o251gz9g05/+TxIaK07LBNSuZAq15MuyRX+j2f+AWDzHm1lyV5lNmTvoXVVaHc8Y
ksYYot0SBsvHJ8zS8ZVvY8dfb2EpYKE91K0YbPkFxe30Nna61oQvV8Dllt601Wwm
t8qMnk8Fp/UUmevV7+35vswn9DCOUxVpd/NGNIrtUlcCCuh0UYjfmx2FXvPlmERX
5Dfr1HoX4FdQbODlEIx6urt/wRUv3w==
=4t1j
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
