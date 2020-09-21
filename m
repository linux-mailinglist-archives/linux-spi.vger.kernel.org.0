Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02A3272340
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIUMBW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 08:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgIUMBW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 08:01:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02FA214F1;
        Mon, 21 Sep 2020 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600689682;
        bh=dXheWyxz6WWyQqi01eWSM5jnC3I6vWUg+7gz+arQsnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fzozi3sOTwlPhdjXZk22ncWUD9M3NKPVU1YneZ0elWvjzcwBZ0y4jHR2LKhOf7Ro9
         SbR9NDgqh6QG2TRYvOfO5/ADPH0/68yZHe/IRoYZzE4VDCeEfwT1Hrveol1ooztdn9
         +7LZPQLv4++as+UOAQBYNQdLgLKdvRHzrXXyr6CY=
Date:   Mon, 21 Sep 2020 13:00:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-spi@vger.kernel.org
Subject: Re: users of spi_unregister_controller() broken?
Message-ID: <20200921120029.GA4792@sirena.org.uk>
References: <20200921110805.GI21278@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200921110805.GI21278@pengutronix.de>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2020 at 01:08:05PM +0200, Sascha Hauer wrote:

> I see the following KASan use-after-free messages from the fsl-dspi
> driver. It seems that after spi_unregister_controller() has been called
> no references to the SPI controller device are left and the device is
> freed in spi_controller_release(). This also frees the driver data
> structure which is allocated with spi_alloc_master(). Nevertheless all
> users of spi_unregister_controller() still use their driver data after
> having called spi_unregister_controller().

> Any idea what to do about this?

Drivers that need to use their driver_data in remove() should either use
devm_spi_register_controller() or not use spi_register_controller() to
allocate driver_data.  Depending on what the remove function does it may
not be practical to do the former, most likely it won't be.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9oldwACgkQJNaLcl1U
h9CyYQf/fx78LWC1r5FMaCzoQA6JHYWj2z/PW7xsSHXCirfbWWfWZnpb1uuFldm7
607Dnfu6bE9Z5Q22holUXjC4YLWYGIwtqQO1YoY3SHo0I7Tarqty3v8DLXkOcuOL
7Ll4kD3GT8x0pC50A9AYm3AQfZHntMqviLSBBFayWnLF02OGtcKqwU6UzumHvz81
dPJ2GwKPPh+bNGGEgAAJWQ24WkdofGnQtR/kCakQBKLuBvmd6dy9nrUIdf9AjbbI
6rmWfDQ8hovP6rhKuQw8PvzkNDMQOgs4gLj2JNtv3rmsAoiFj5/6r0z1xt/6hUxl
U6YOpW6u8HkmMbxRZitFAWAGOB6rrQ==
=6EMp
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
