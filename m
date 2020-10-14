Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30D28E7DA
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgJNUZM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 16:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgJNUZM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Oct 2020 16:25:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64CC32222C;
        Wed, 14 Oct 2020 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602707112;
        bh=y60T8MfAN6VUb/ve7bAl/0bz6h3acfP3VAK+B6ENBgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1b3XRaOpODmwcqPvQPtoc1WOTMFE6JFgWfR3qphGMun7Y89YqRvEvNfwCTTj/8TTl
         Wsy0nwDtC06JPuZOcIYNFrR3Sqv9LKuz5eD0HAJDJ4KsbHLT6Zypjs9rGCEE3NzJPV
         sgTDgv9vKGECjKnNhNnwhmjhGKL9zxs9Qp840EwM=
Date:   Wed, 14 Oct 2020 21:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201014202505.GF4580@sirena.org.uk>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <20201014194035.ukduovokggu37uba@skbuf>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2020 at 10:40:35PM +0300, Vladimir Oltean wrote:
> On Wed, Oct 14, 2020 at 04:09:12PM +0200, Lukas Wunner wrote:

> > Apparently the problem is that spi_unregister_controller() drops the
> > last ref on the controller, causing it to be freed, and afterwards we
> > access the controller's private data, which is part of the same
> > allocation as struct spi_controller:

> > bcm2835_spi_remove()
> >   spi_unregister_controller()
> >     device_unregister()
> >       put_device()
> >         spi_controller_release()  #  spi_master_class.dev_release()
> > 	  kfree(ctlr)
> >   bcm2835_dma_release(ctlr, bs)

> Also see these threads:
> https://lore.kernel.org/linux-spi/20200922112241.GO4792@sirena.org.uk/T/#t
> https://lore.kernel.org/linux-spi/270b94fd1e546d0c17a735c1f55500e58522da04.camel@suse.de/T/#u

Right, the proposed patch is yet another way to fix the issue - it all
comes back to the fact that you shouldn't be using the driver data after
unregistering if it was allocated as part of allocating the controller.
This framework feature is unfortunately quite error prone.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+HXqEACgkQJNaLcl1U
h9Cemgf+N9ktvf3Pu2FKW2QsiXZWpEOe9n1qxhO3C3TsMVR7uUof7Il0d78U3gQW
Qub+c1JdauKYEX1f8HsEYw46qw4mTEApvJftks7F6Eyk6VXgWTdOI8dL1D9Z9cK5
Q1iSG2S09kTtSJinL2XozoF/RtIqdQarNX72ZJxeHlXLnpyYOrjwAazgb+Wk6hLW
TKugaZxbYoVczPvAuBIHWrNyngnYAWyNazrbBR/oUiSyXLGm/3PUNA6Ta0odClnW
4zHdD7wcj7eo6oorQC9MBRyvAb8Rak9qmBdKAujl6FWZnyXF2SYMoFhykCI0D3ec
X4fJEnbKTejyLXbKGlL9Buge3X3kMg==
=c+5j
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
