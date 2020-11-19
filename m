Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA802B9615
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgKSPYi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 10:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgKSPYh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 10:24:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E46A24695;
        Thu, 19 Nov 2020 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605799477;
        bh=vhsM6OOWsmV75YH35wM6eBKYq0pu3NlFsI0c/iS85Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itGY+rODjctume7lqREVvVgTm0PipbbooAkT9XKeItLpchquNp7qpaiFyg7lwNNg3
         GQz4bB+sDcOnLZuuFxPmVYzJiDmlkv62Rg+Y8+jk2gyyqNqEIvpEz/OLcMR/n2uOoU
         8AmMuKMJmPmGiqWpHdm7eQ3hslokzd1xig76cxrA=
Date:   Thu, 19 Nov 2020 15:24:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] spi: fix resource leak for drivers without .remove
 callback
Message-ID: <20201119152416.GB5554@sirena.org.uk>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 04:20:57PM +0100, Uwe Kleine-K=F6nig wrote:
> Consider an spi driver with a .probe but without a .remove callback (e.g.
> rtc-ds1347). The function spi_drv_probe() is called to bind a device and
> so some init routines like dev_pm_domain_attach() are used. As there is
> no remove callback spi_drv_remove() isn't called at unbind time however
> and so calling dev_pm_domain_detach() is missed and the pm domain keeps
> active.

> To fix this always use either both or none of the functions and make
> them handle the callback not being set.

Why would we want to tie configuring PM domains to either of these
functions?  We certainly don't want to force drivers to have empty
remove functions to trigger cleanup of domains, this would be
counterintuitive and this stuff should be transparent to the driver.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2jh8ACgkQJNaLcl1U
h9CEIgf+KS7hlI8RaH9Yz5nFvPMDnGif1tpYzZmGdG66LnEwmLJyYByEKxWPMUfd
XKVQk6ebTw4Te+w1s+0vVdQDToqluN2VL1h4246SeMdvs+3m9W0EdNa4TmxcHL8p
Z9BwEfGyZnr8fP9rEUJRtuctsM9XTqwBHN9JpD7tiF5zS5nEG0YCXil/sfv840dG
4A8dK+JWidPoV1Io297kXk9DFKEk13x0ZwW6RzmSb+RYO/KXC89wXFG/zkx++q2O
2glLn1xEXL9j9a5foxnKZbDCrfrS0Qvq5i0nFbtMJQ9NA41alrnL8hAUaDWkOqnp
JkKmG2gIh4zoqy4lrBQHgT+0C9y3BQ==
=qkpy
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
