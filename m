Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A125C365
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgICOvG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 10:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgICOP1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Sep 2020 10:15:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4D6206EB;
        Thu,  3 Sep 2020 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599139402;
        bh=uxrMI+2jcG7Rhw4PCRtsAWbNUWIO2z+gwQ/cr3AcOcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8ytrwH16XsbRuGogX7XR0cM8l3saDTV7V6rLJqztA3BTdEm8sKCVMgP9+guQw5oh
         oX9mOY7DAMKky8hGQ1SKM2O4XgfH9OYRZknrqyBOiFB1S6jyiBp4KzSrTKAj5L+IxY
         Km69Z3dSrT+aWrT+Mz5zDXcBLLs6dyRRrDBlQyfs=
Date:   Thu, 3 Sep 2020 14:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: spi-imx: correct interpretation of num-cs DT property?
Message-ID: <20200903132241.GB4771@sirena.org.uk>
References: <ecfa135b7b83a31bed821ec0740ab3cf1d39da15.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <ecfa135b7b83a31bed821ec0740ab3cf1d39da15.camel@ew.tq-group.com>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 11:22:20AM +0200, Matthias Schiffer wrote:

> - If num-cs is set, use that
> - If num-cs is unset, use the number of cs-gpios
> - If num-cs is unset and no cs-gpios are defined, use a driver-provided=
=20
> default (which is 3 for spi-imx; this matches the number of native CS
> pins in older implementations of this SPI controller; i.MX6 and newer
> support up to 4)

That sounds like what's expected, though we coould just skip the first
step.

> Also, would it make sense to add num-cs to all DTS files for boards
> that actually use fewer than 3 CS pins?

No, it was never a good idea to have that property in the first place
and there should be no case where it helps anything.

> At the moment, the num-cs property is not explicitly documented for the
> spi-imx driver, although the driver understands it. I also suggested to
> add this to the docs, which Fabio didn't deem a good idea (I don't
> quite understand the reasoning here - isn't num-cs generally a useful
> property to have?)

Could you explain what benefit you would expect having num-cs to offer?

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Q7iAACgkQJNaLcl1U
h9DI4Qf+IFmOS7dEEhxYZrT/kDf0F1Z6Kj6qTImRT4ImOPc1hhlzs6e9o2HxAj95
SfPAinxGHrl9ClrK2J8e4XG7xxu+UNfom6FGwma3oz0nhwPJ+kJx6LaQYDdEdCYc
mgK3XD+n87gwKoS4DdbZxpFTdAE2XR+ngKlDJUdhYmlWxKgGZuWzJfw4ehTZlqbg
Rvgr9CY+AT6mKFDq9dZS2AxFXpD5LLqOHj4XX25MjpWS9AdSjWuWyop24WbvF2nj
YJqrMqto0ygGJdW94+ugGz2T+82EOI6Bm17NcpYzXHcSFT7d97GCC2kQbTQmIDql
1sAVyODUHKz5reRHSSFsIebJiRJSjQ==
=CrVc
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
