Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99892740C5
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIVL0Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 07:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIVL0Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 07:26:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC30B23600;
        Tue, 22 Sep 2020 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600773984;
        bh=J0uu7XoNtCxw7G7HdjNB2VjwLyrJRqie0Z+bn2dQZek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wh2WRyYx+MrHASIK0QwkU5Fzn+g7Ktzgz+voWlTTlJYJ9e/DI5Z7mzZXnsuKe5nsY
         QRg9nHwmP/gj9DoKVjobwwwEEXrrI2qfna3A4pSlZOhan2ElHqx6RYEioQAO7sN9Bw
         6NVX6Voa+xgjeFR89oe8Hb8tiOrRpci8O69InURA=
Date:   Tue, 22 Sep 2020 12:25:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        kernel@pengutronix.de, Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/6] spi: fsl-dspi: Use devm_spi_register_controller()
Message-ID: <20200922112531.GP4792@sirena.org.uk>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
 <20200922093228.24917-2-s.hauer@pengutronix.de>
 <20200922094437.GL4792@sirena.org.uk>
 <20200922110652.GC25328@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="51uid+Ur/3ko9cBW"
Content-Disposition: inline
In-Reply-To: <20200922110652.GC25328@pengutronix.de>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--51uid+Ur/3ko9cBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 01:06:52PM +0200, Sascha Hauer wrote:
> On Tue, Sep 22, 2020 at 10:44:37AM +0100, Mark Brown wrote:
> > On Tue, Sep 22, 2020 at 11:32:23AM +0200, Sascha Hauer wrote:

> > > -	/* Disconnect from the SPI framework */
> > > -	spi_unregister_controller(dspi->ctlr);
> > > -
> > >  	/* Disable RX and TX */
> > >  	regmap_update_bits(dspi->regmap, SPI_MCR,
> > >  			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,

> > Is this fix safe - what happens if we start another transaction between
> > disabling RX/TX and the unregistration taking effect?  Similar concerns
> > apply to some of the other patches.

> I asked myself the same question until I saw that a dozen of other drivers
> also do it like this.

Right, it's unfortunately common for people to just use devm without
thinking about it too hard and it doesn't always get spotted :(

> data. IMO this only works when all drivers are fully managed with devm_*
> functions and runtime pm so that the remove functions for all drivers
> become empty.  Until this happens spi_unregister_controller() has to be
> split up in a function actually unregistering the controller and another
> one freeing the resources.

It's probably easier to just not have this option for allocating driver
data as part of the controller TBH, it's probably mroe trouble to use
safely than it's worth.

--51uid+Ur/3ko9cBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p3yoACgkQJNaLcl1U
h9B7SQf5Ab7JcYxYCp4+9Q6eAj4RnJ0Mx/dcSsiWeuOrGmHXgTHdYE6Iw/JAzzgq
nELbqfUSi3uVCSSm/0hw4DgSDy5Khh34aCoQ/H5U5qt5r2WmJ7hYNiI5Fk8I9rL4
N6Z//00yCqzbn22LZtSey3zr+NymejlMoHNHcyLkT4ZBmOQnYNYhjs6TrIDrrP9+
1dEtyFI4DbLmFyUUviLkh/NqjKHCBCjfFYW3YVVyzUgE+aGZ5Hegksoef0STVfyT
oFcrISmZgKRGb05J6N592sQyZznLngVNUF8gCi+55tDIl8rzgxrBG6ebM45KgRCF
Oqfp2EeXYSmpOf2o4307vFi0zjOl8Q==
=HlM2
-----END PGP SIGNATURE-----

--51uid+Ur/3ko9cBW--
