Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2462B966E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgKSPmB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 10:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgKSPmB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 10:42:01 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10442469D;
        Thu, 19 Nov 2020 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605800520;
        bh=mqSuhL+C5LO9HZszz8keWBeiJzbUUK81OVta7LoQeCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJNBhCHw4Cgd+2A3MiT+WaUWkZCU5XMU/GV0eSQcjPqqvMVbdpPedYr7hFa+IcEY3
         nCfVM/oxsCz56qUNSzqJJ/jnSvP1hss9l/v7T2bkP0VoR8iEAWb4XrZ3Ykv1Mvjac2
         0KqGRbZS+F5Jhgabi5p3cB1XraX658CxdbhX7TJo=
Date:   Thu, 19 Nov 2020 15:41:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fix resource leak for drivers without .remove
 callback
Message-ID: <20201119154139.GC5554@sirena.org.uk>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
 <20201119152416.GB5554@sirena.org.uk>
 <20201119153540.zehj2ppdt433xrsv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20201119153540.zehj2ppdt433xrsv@pengutronix.de>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 04:35:40PM +0100, Uwe Kleine-K=F6nig wrote:

> Yes, I thought that this is not the final fix. I just sent the minimal
> change to prevent the imbalance. So if I understand correctly, I will
> have to respin with the following squashed into patch 1:

> -	if (sdrv->probe || sdrv->remove) {
> -		sdrv->driver.probe =3D spi_drv_probe;
> -		sdrv->driver.remove =3D spi_drv_remove;
> -	}
> +	sdrv->driver.probe =3D spi_drv_probe;
> +	sdrv->driver.remove =3D spi_drv_remove;
>  	if (sdrv->shutdown)
>  		sdrv->driver.shutdown =3D spi_drv_shutdown;
>  	return driver_register(&sdrv->driver);

I think so, I'd need to see the full patch to check of course.

> (Not sure this makes a difference in real life, are there drivers
> without a .probe callback?)

Your changelog seemed to say that it would make remove mandatory.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2kjMACgkQJNaLcl1U
h9DMBwf/dedpAjqkzElw+dzhL1GCU1NwUYjdZMsBqMQxXUJK3qPAKYJRqciI3lG4
GE8UzhtmRYoo+YUNwaLCdhdHnGEKIfczkdJf3fLCVBxUiMM5er/YjBjgOgiBkfnT
GJ6m8mnbdBH3aYOjlDkky2KocW0zqtBZUZf26f2FErYh8Cxz7oGo2h2l712ZB53P
ndiDJlf4LivEp6l49wk0mi34ephD6qIUE86kip0FKZyC7Zl4INlfd+f9iHO2NzuV
lWT50hU8SX+IhIo4kd4Osf57+d/x73g7FcV0psaQNjk6VMm+bqaszYPTVm2CniUD
gROjCQ0xWuhnGXoHCw7HJjly5a7+vA==
=Oeu8
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
