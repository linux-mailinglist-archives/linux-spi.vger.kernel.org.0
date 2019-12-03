Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F39110269
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLCQf3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 11:35:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLCQf3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 11:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r6m1p6iz/ZLXeiykJGdEzzkQHCD0mD0wLBa122C3/ok=; b=MVCFMzV5dOqogocPNLWzLR40v
        g/hl5c5gwXux8bd2wUwY8eJ1x+FfKGrI14FNF1B1gEBmpGc1NzIZsk/4yz7N6r94Il9iRsTdkcwzk
        FhpmDumi0pA+RqCu/In/SO7ycLNHlyQv6Godmsps8x0gqaDYFm+TAM3dp09tNGDoagrMM=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icB90-0003H3-Ng; Tue, 03 Dec 2019 16:35:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 00D63D003B4; Tue,  3 Dec 2019 16:35:21 +0000 (GMT)
Date:   Tue, 3 Dec 2019 16:35:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: Side effect of SPI GPIO descriptor usage
Message-ID: <20191203163521.GM1998@sirena.org.uk>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 02:11:51PM +0000, Phil Elwell wrote:
> On 02/12/2019 13:43, Mark Brown wrote:
> > On Mon, Dec 02, 2019 at 12:10:11PM +0000, Phil Elwell wrote:

> > I
> > can't see anything in that change which sets the flag, can you be
> > more specific?

> bcm2835_spi_probe in spi-bcm2835.c sets ctrl->use_gpio_descriptors to true,
> and of_spi_parse_dt in spi.c includes the following:

> /*
>  * For descriptors associated with the device, polarity inversion is
>  * handled in the gpiolib, so all gpio chip selects are "active high"
>  * in the logical sense, the gpiolib will invert the line if need be.
>  */
> if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods &&
>     ctlr->cs_gpiods[spi->chip_select])
> 	spi->mode |= SPI_CS_HIGH;

Right, I see what you're saying now.

> > In general it's a bad idea to modify mode at runtime, and it's a
> > bad idea to mix multiple means of configuring the polarity of the
> > chip select (eg, mixing DT configuration with other means).

> Applications using spidev to implement user-space drivers need to be able to
> set SPI mode, CS polarity etc. at run time. I agree that there

I'm nervous of spidev user doing stuff like that with the chip
selects, with DT even spidev devices should be registered
normally, you will get a complaint if you register a raw spidev.
There's no free pass for "oh, spidev can do anything we don't
care" here - the DT should describe the hardware, if some of the
hardware happens to be implemented by spidev then fine.

That said we do have other in kernel users that do change modes
at runtime, though I'm not convinced many of them have GPIO chip
selects.  Linus?

> are many ways to set the polarity of a chip select, and it may be that
> too many are being used with GPIO CSs declared by DT, but I don't think that
> completely explains the connection between use_gpio_descriptors
> and the automatic setting of SPI_CS_HIGH.

That's the result of there being too many places where the
polarity of the chip select is set so the code is pushing to at
least only implement this in one place so things are clearer and
more consistent.

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mjscACgkQJNaLcl1U
h9A5nAf+KL/EMG9AeIeRv8/4LbT1CbXUDlGeuE6JyVP6WkAZaVRqab2gbl4rUOAI
vuIKIOJ76vkvjOG9deGsO2N+rIRmXfKt+U0Nz1z92Qg4OjkAybQbiv0ObJU2C5QJ
HUoMtPJ4HlGgOoct0EXfz/MlwLC3CtXaAM9j6rwE+kZCfLAgJ2I4N6yK4H6/030Q
dw/Q+opbvHM2AFKfLPOCInDryDmQrwcstyPHmWKfsrkoJdyZ8QS1G9EydnQQIBYR
31IsXVzDWE8ziAuc5gF5+FN4/cBbdQxtcIHCx3mDVYcB3F6xEKDRPd0aDglAMP1J
51pDSdVPkHYzoUB7PiuvqGH9KtFr1w==
=h29l
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
