Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B72DD2C1
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 15:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgLQOQQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 09:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgLQOQP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 09:16:15 -0500
Date:   Thu, 17 Dec 2020 14:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608214535;
        bh=e9WYQ01ToT4WB38rpZwYi8eicooJMQHuLcVOHBEHNCk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfbC6T9/rP3QUQ9Ej5+mOjfIudYh8Ktk5WtKqekZSIa7/M46/vucTJTvZ11tJVHuX
         W8sAXsUY4WSDArcS7lCsFlKGCzI8ND4fpibkeE1NToT8h3FKG41oa22HUyh3O5rqZV
         4UBgEcBkBZ76HTWWHGk1PJHj0KkTeGeUsnsxim77qK8Qu3b3fMYrGT0cqkJ4RvdDJu
         hvyThgpU2gXxbQdEg6R6pgelXQiotycabCtXyrzyO6KUlgLzQlnhPhbzXFmzbk71/f
         kFsaAwh313BarThXZMdDQx/H5EL1bIqi4VC4tPps16swu7MiEPyq4ok5NZ/rCMebfn
         VLHb8hr7Nvnlw==
From:   Mark Brown <broonie@kernel.org>
To:     kostap@marvell.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, bpeled@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH 2/3] spi: orion: enable support for switching CS every
 transferred byte
Message-ID: <20201217141522.GE4708@sirena.org.uk>
References: <20201217112708.3473-1-kostap@marvell.com>
 <20201217112708.3473-3-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20201217112708.3473-3-kostap@marvell.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2020 at 01:27:07PM +0200, kostap@marvell.com wrote:

> Some SPI devices, such as SLIC (Subscriber Line Interface Card)
> require toggling the CS every transferred byte. Enable such
> possibility by creating a new DT property and enabling SPI
> device mode update. Add according support in the spi-orion driver.

I'm pretty sure we already support this - if the client driver sets the
word length to 8 bits then SPI_CS_WORD ought to do what your change
describes as far as I can see.  What's missing there?

> ---
>  drivers/spi/spi-orion.c | 20 +++++++++++++++++++-
>  drivers/spi/spi.c       |  6 ++++--
>  include/linux/spi/spi.h |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)

This is introducing something into the core and adding a user of it, it
should be two separate patches.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/bZ/kACgkQJNaLcl1U
h9A1nAf6AuL8XdBBLMpokHOs8mQs/hlegWxD0ciHQyCxxyRkBkw1KvbpFORg3Xy3
1C8U4ZFiLD4mW4MJEDKXXenH6R5AYt0ubqYHYyELTcPhDH0dA2d+3h5Wv3f4Ek8r
dwHHi29zHFGnip2bU9dXpsMhbcCMTKr+oHMd4ZL83FPSiAs7i1qXZ+vwiaO98BZF
fcoYgPx5CduPPeikJ9ls/MvFYWannAtO8LQWYtWndjzSjStmf0KREXCODj6i3DGl
NIIQX0lTHgQvtZphBhoJQu7u/JHTosVb5hdqe8HAzmU930tNHJrcX4fg+fa2Hkta
gOS/rGT6J8U8grofMYMYg3hfrqBWdg==
=c2pW
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
