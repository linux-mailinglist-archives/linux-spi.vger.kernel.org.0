Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F312F4B61
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 13:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbhAMMe7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 07:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbhAMMe7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 07:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D90723339;
        Wed, 13 Jan 2021 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610541259;
        bh=h9vp+z5IyuvmKXzLAbhb8Rntz6LzAx339QE/OJ3/nOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3rrwfotM2eUI1TK7AANu7ae8cfrIGpC/1dMQAq4jz9eY8RerRxE5bUfgvSc1hxyC
         sSQX4XdCPnyy4ESqoi0hbMZjrpw8/uyY3A+6SxaYl2T7+RrQ6fu0jVrncMZpXL6dcH
         d4gwa5IhWP9Ib89yfFpNL0NOS+DaDxdNoxO/yG/8HqCWDE0UNNwme1SGNBPVg0g5xF
         MI+PJcjfeNYPecvBHJGqN7GXjz60aNTgHOilSrHmvNJFPsKfLDu8RbEiUmKRpVnlqQ
         bfbBg+ZNRL0Va/oVHUK+PDqAOO4ybCULnREw1jo87SXViCfzEkM0NtTCjKdP+VJyhF
         sXoBumfS6A+Fg==
Date:   Wed, 13 Jan 2021 12:33:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04
 ("spi: fix client driver breakages when using GPIO descriptors")
Message-ID: <20210113123345.GD4641@sirena.org.uk>
References: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
X-Cookie: Ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2021 at 09:49:12AM +0100, Christophe Leroy wrote:

> With commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO
> descriptors") reverted, it is back to work:

...

> What shall I do ?

I would guess that there's an error with the chip select polarity
configuration on your system that just happened to work previously, I'd
suggest fixing this in the board configuration to bring it in line with
everything else.

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/+6KgACgkQJNaLcl1U
h9CnbQf/fAtzQXX3e/4ey7wtx8MdEcgSbGpsx3rzEpk48zhiyY1XjYqXC+64WFCB
mZNlgLSCq5odAUTDBaOD0gn67E8AgVZi+NW0F8ibMLJQBEAa8wcEO7YhfEPcPJmv
3Ncha3suxToG2lWeuLceU71mP8ixfoCgodzgV58iXcFqsERnIH60lIN3MpBvjXYt
CB8YbV/g8OzUkB/rb+g/k8UvRQNO3I28DiyGnYBkYo/aM3OdGkzJnhKAc2MyH+VR
f1no1xAcxyCL/aP0BZGMQ9hAPWVyqvisw85x7Ubv5dt7MMeqNKYQfq3Wi4bD4MRq
NBrDQ7bCEF2WDrV2y4Z5iUWmhjWW5w==
=zTCg
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
