Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B402ABE59
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgKIOOi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbgKIOOh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 09:14:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B79206ED;
        Mon,  9 Nov 2020 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604931276;
        bh=kLJzaopBrWpFidVU7xRvPTiQ3M4h0ap58VBp21YzxYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jb8Tfl/071h1BNkQ95G0MdcMqzm0ItDQ91+UFxaDdcTP/Hn4YNNpN3L99eqPfm1eE
         iTtKIyIl30zgvi2L/4YXmciVZ5xR/lk9i9XeWhcEx7rqBAE3OSbNOiS8IGnLwAhJuR
         mYM+oWmy3+Hzzxh9jMiJiyv0s+Mz/Ziy5SENX1Ek=
Date:   Mon, 9 Nov 2020 14:14:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109141422.GD6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 08:47:10AM -0500, Sean Anderson wrote:
> On 11/9/20 8:29 AM, Mark Brown wrote:

> > In this case it also looks like the controller hardware requires
> > transmit data and therefore should be setting SPI_MUST_TX and just
> > removing the in driver default anyway, though that will have no effect
> > one way or anther on the issue you're seeing.

> There is a recieve-only mode, but it is not used by this driver. Perhaps
> it should be.

I'd expect it'd perform better, especially on systems that are
apparently struggling for CPU bandwidth like yours seems to.

> > Please also try to avoid the use of master/slave terminology where
> > reasonable, controller and device tend to work for SPI (though MOSI/MISO
> > are going to be harder to shift).

> Here I use it to draw distinction between the SPI master and the SPI
> slave, which are both devices in different contexts.=20

If you find the use of device to refer to the device being controlled
confusing consider also using something like client device instead,
there's a number of ways to do it (there's a list in Documentation IIRC).

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pTr4ACgkQJNaLcl1U
h9DamAf9GViNS0tl9IE38rF2GQEVHH0m8fIjSSQYDUg/HaV3KWTlgA+RxBct/6Su
0kWc3OyLDS0kbdA70oliL0kA+AQEbPnvxx6W3ktbW9HvGbf03yPhlVayBdx9QxZJ
Gz2eWEe05CPdrQwMEo8LnjrfeL1uycSgalHjDbotqu2DBbcrvHoZkt8bL5+0EdcH
a0MP1HmvpfvX+l36JPx8m6kOay+2cXYcQwIJ8FMV6rOZXpmgdlpT9UTTqMnUji8V
BFLLRgEaNi6WG8WXhB8pm3o/z9w2ukz62EPCkeNEGB36a6WI8D9zxSNQ6bM/ZszD
wqk4bWzbFhknKP96ou7EqTa6wlbLqg==
=+WcS
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
