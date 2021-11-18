Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9AD456245
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhKRSYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 13:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKRSYd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 13:24:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1BF861A64;
        Thu, 18 Nov 2021 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637259692;
        bh=V4Jq2BzVz8jS8bhrLi1R0p8GWWgsBCgv1ZIdSsfXyYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5LG4tmUsPBiAqDlovU9mpKkwSkNk5j5gKDTQywntBVbU9cG8gsBgWBtZMejAd3cr
         k0nEh1jTuYZRfFY/RzxJYcsoJbMyNTN5sU0Utgn/AlOfPwpZAuV0iA+99Jk/Bq3bXP
         RTtQdH+8t99KwVCu5kOlkFHnIvBGzuU9M0uSPLlGpwOjjvcWUTdl6rvMdDcj1WprAx
         lHrPLFWQ3w65164VnwLQnIBIut9JDXK0yVugOfeecH1OghVgh5RMuzrztHXanRLQpJ
         0Nj83bQl1BmlxaPIY229MxvesEBhrMGHZSoUtz0xxxCog4xBa3yrN3Yvg9HPIksBMX
         Qxkictq8idC4w==
Date:   Thu, 18 Nov 2021 18:21:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Message-ID: <YZaZpx7cudaAEGIP@sirena.org.uk>
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LIjVJVUzwKb7Z0/S"
Content-Disposition: inline
In-Reply-To: <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LIjVJVUzwKb7Z0/S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 08:42:47AM +0100, Uwe Kleine-K=F6nig wrote:

> Up to 6840615f85f6 the choices you had to use the spidev driver were
> (assuing a dt machine):

>  a) Use compatible =3D "spidev" and ignore the warning
>  b) Use compatible =3D $chipname and add $chipname to the list of
>     supported devices for the spidev driver. (e.g. "rohm,dh2228fv")
>  c) Use compatible =3D $chipname and force binding the spidev driver using

>    	echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
> 	echo spiX.Y > /sys/bus/spi/drivers/spidev/bind

> Commit 6840615f85f6 changed that in situation a) you had to switch to c)
> (well, or b) adding "spidev" to the spi id list).

> With the change introduced by this patch, you make it impossible to bind
> the spidev driver to such a device (without kernel source changes) even
> using approach c). I wonder if this is too harsh given that changing the
> dtb is difficult on some machines.

Following up from discussion on IRC: it's not clear to me how option c
is affected?  The change only causes an error if of_device_is_compatible()
is true and driver_override works with spi_device_id not compatibles (I
didn't actually test, in the middle of some other stuff right now).

--LIjVJVUzwKb7Z0/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWmaUACgkQJNaLcl1U
h9AxLgf+Lt0XxMF18F9U4c/wuysxNTBcGWyZeUhfrOwO7kT2QstSKF8mUktV8VGm
QSENFNKQtYSb/TH0AtcDlhkq8q06WieXm3vqYdgtGHOwQSsglbXd2MxsaL/3pAMG
rOjtYGQfrTUhfXi8fA+t/OI9cJgvEX2BL8a8wPwtpV96YaKZ+Nr77mD8oTQxwHCg
a5o3GKGDq/GMzS/4YtkdVofvrB4Qii1E3HOeIC9ebbxeDJJWbGSYxxl/+lS4ayhc
s9Ujqk4RCa1J2oFaoyywUC2NpORqf2rcorLSNUXBEkMqmh6PRhKQfYKFkQpgb0tr
ivinVkDedfYVHAUV/Ut3VYsYxiE4yQ==
=rW+i
-----END PGP SIGNATURE-----

--LIjVJVUzwKb7Z0/S--
