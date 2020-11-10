Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E12AD7E7
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgKJNnx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 08:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgKJNnx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Nov 2020 08:43:53 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F84420731;
        Tue, 10 Nov 2020 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605015833;
        bh=8a93PI75TfxaQ/45J7emDK1Y8Q31siD/1/I+xtXuprk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onGLtCfW9xKqxLvawwxMVgVhxER7U4G8YaW6HCGl5H1Oc57M6y6rsASGGm5EV0csi
         08nKnppFYrxJw8xcq0+KhtqR5TmjJyOb7SOEzbBBDCuiYVgtRGwCDDyPsPKohqgvzK
         HqyN/6m2iyy9nSjZprAZzrqY6m0ood8Ew2dHCvLQ=
Date:   Tue, 10 Nov 2020 13:43:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201110134338.GB5957@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
 <20201109202052.GL6380@sirena.org.uk>
 <20201109210531.wp4dmug4w2r4kh4p@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20201109210531.wp4dmug4w2r4kh4p@mobilestation>
X-Cookie: Disk crisis, please clean up!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2020 at 12:05:31AM +0300, Serge Semin wrote:

> If by general Rx-only half-duplex transfers you meant that the client
> SPI-device shall just not care what the MOSI level, then the only
> acceptable solution of the noted in this patch problem is to fix the
> client driver. Since in case of the MMC-SPI client device sometimes it
> does care about the level.

Yes, that's how the API is at present (as you say) and is the more
general case for SPI devices that I've seen - I'm not *totally* against
adding something to the core if there's enough users that could usefully
use it but if it's just one or two then it seems like it'll be more
robust to stick with the current API.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+qmQoACgkQJNaLcl1U
h9B0Rwf+KopRKnXYo5wqZqMUc6Z6nfo2YpwZsWiUO1Sy8+hG9keAbGxcnu5bOGDJ
90r9oFQxqTjVPKZ556EN5XNqKBijwQMnBPjvCBnfV7U31rvhcd5xiOMh6GXCi18H
yuvD88KqsXweetYSO7EHqr0MARsZ8OT7khH4/U2b+37uvhfIHDsICIkPHRp4jQQH
p5hOgTE8uoHNPz6pMzEBmXEMq/yR3Hvt4gMSPAioVH/0sKgB77fMlAdpDyXZewl0
tQiilBL5bv2mq9IDl/4J3oJf0gM4VT2k4oOehY5wpaXZgn5LJlJVl7DUxJBlmG0r
4kUkW4N97ZkMpwo/MulisIT+1LpECQ==
=ZOI9
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
