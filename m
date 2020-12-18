Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE82DEA6E
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgLRUpJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 15:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387682AbgLRUpJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Dec 2020 15:45:09 -0500
Date:   Fri, 18 Dec 2020 20:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324268;
        bh=FHEoFO/2rytdu5VZklTtZU1f7kCAwk3tI8XN0yShfQE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZPRtXDdss7HGtCia5eE0SJHMLLhwGKB/QXjxvxiktZB62FEpBkARwWJpyyjEVyyL
         cPhVzxuOF9JMe42dr0DzoNGXwV94nHs48+9bwBjgQO01AKjuu+rLuDPCljC1Y269wU
         JNu2YMWf212sH/04HnmhcN3g1MiH5PfE8eZdnV/lJ6y4kGfkhA85LfGUqV6K6twpWA
         /QULPHoGrwDIar4pWhSUP7J+RDeKUnHot2jrrGShNPULRL6VoMj460Nuc8dn1DSxWA
         sgpHO5wFYXz8YtIMDkP9Zo4bDuuI9V8iHDUsay0ZbQl6WAxdDZ2sMJvzquIC4FFnRF
         eokbjuqrE1hyg==
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        lukas@wunner.de, bbrezillon@kernel.org,
        tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201218204414.GG5333@sirena.org.uk>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
 <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
 <20201218191936.hb6sq7zr3zdirar7@ti.com>
 <20201218204102.GF5333@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <20201218204102.GF5333@sirena.org.uk>
X-Cookie: Password:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 18, 2020 at 08:41:02PM +0000, Mark Brown wrote:
> On Sat, Dec 19, 2020 at 12:49:38AM +0530, Pratyush Yadav wrote:

> > Anyway, if the SPI maintainers think this is worth it, I won't object.

> This gets kind of circular, for me it's a question of if there's some
> meaningful benefit from using the feature vs the cost to support it and
> from the sounds of it we don't have numbers on the benefits from using
> it at present.

...although I do have to say looking at the implementation that the cost
seems low, it's just a flag set on an existing transfer.  The only issue
is if we'd get more win from coalesing the entire transaction (or entire
transmit) into a single transfer that could be DMAed and/or requires
fewer trips through the stack which does make it seem like an unclear
tradeoff from the point of view of client drivers

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/dFJ4ACgkQJNaLcl1U
h9CG+Af9EpkMpglPLVubuN097h2axmsNXo9hXZa/vbZu+hYPoNUkicGdmvuK6xpO
uPgtkvPbrwCqa/vzYbcvnGFxd7GTbSsOKxYIJgeGP+cCwsvCBPdt15zwL3xjqsEt
BNpwz/gHAs4+bTzDW82ZN7Iwiqmeh0cUUjAZwRNo2LZOOopGIfdFh6bH47dVin9z
Bwe70eRv98kRcEkXf86TTk2+Y10L2u6sp4B4gPgscggvq41gtUrOEYo+vNg5FZna
RYwS5OGLRf41mS5TGr/jx/vefhcm1Mz8g5Bmb5KDNPWhP/QbY+I24F6GrNhr85zV
lyAHbpBOa0twJHc051myuf9+SkbyBg==
=6aAL
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
