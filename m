Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55712C27FB
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgKXNcG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 08:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbgKXNcD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 08:32:03 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25084204EC;
        Tue, 24 Nov 2020 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606224722;
        bh=BGnFCsRilCxxOmWz7iQ42Ucm36iQboKeAVs9xqB4tOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu96mBZF7quamjsgCKq03GBLRZKJSiOwwxUpzQfeWUwa+JZTSKRHJVvxcVwLimCJX
         R5yeiYPriLNA78j836u6Hafic4LhaMUT0zxeitLJxtkvcDpdvqXcT+KoxKjakFFBm4
         uvTMMFMZneRyAluqFG7YHOpngjmBkijSLnzs5xx0=
Date:   Tue, 24 Nov 2020 13:31:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: Use bus_type functions for probe, remove and
 shutdown
Message-ID: <20201124133139.GB4933@sirena.org.uk>
References: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
 <20201119161604.2633521-2-u.kleine-koenig@pengutronix.de>
 <CGME20201124120324eucas1p189ec6eed6d6477e27a194f9d75d7b43a@eucas1p1.samsung.com>
 <9b86504f-c5f4-4c85-9bef-3d1ee4cbaf9c@samsung.com>
 <20201124130107.2yvgk7kheep5gd6z@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20201124130107.2yvgk7kheep5gd6z@pengutronix.de>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 02:01:07PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 24, 2020 at 01:03:25PM +0100, Marek Szyprowski wrote:

> > > +	if (sdrv->shutdown)
> > > +		sdrv->shutdown(to_spi_device(dev));
> > >   }

> > In the above function dev->driver might be NULL, so its use in=20
> > to_spi_driver() and sdrv->shutdown leads to NULL pointer dereference. I=
=20
> > didn't check the details, but a simple check for NULL dev->driver and=
=20
> > return is enough to fix this issue. I can send such fix if you want.

> Ah, I see. shutdown is called for unbound devices, too. Assuming that
> Mark prefers a fix on top instead of an updated patch: Yes, please send
> a fix. Otherwise I can do this, too, as I introduced the problem.

Yes, please send an incremental fix (in general in a situation like this
I'd just send a fix as part of the original report, it's quicker if the
fix is OK).

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9CzoACgkQJNaLcl1U
h9D/qAf/UOUyww85zv9XA0vyhU1IeYPoa9Q+LladkX1G22c+xHOQZcI4HnHnUZOn
KnGrWIQYl3x9ad8T/uxUXZDKaR72iM/tH868n4htLeP5CmYCnOHtvfPBZ2yN77xN
AABxgxbuIIabfuLuJlVuTzTfv7vPlQ0Rbk59wwy1gaeoaZNYSVE9fBF//kEkFddi
tuDNtJxGF5CP3VNhowGo36XNxFeFWyhI/+m0EE70l3BvrCT2pHL3vuJ/DcfyZL+j
AFg8GZ7tjqzX9YIxrY9+Hv34ScZnJ+VZ1lsxgXdL+c3Hh/8i5bsE4rPbKUlHtyhd
gXLGwFqhr+s0KPfw183NgrVdx3vQpA==
=Vga9
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
