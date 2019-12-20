Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA3127A60
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTL7c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 06:59:32 -0500
Received: from foss.arm.com ([217.140.110.172]:49974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTL7b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Dec 2019 06:59:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14EAA30E;
        Fri, 20 Dec 2019 03:59:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81DEB3F719;
        Fri, 20 Dec 2019 03:59:30 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:59:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Subject: Re: [PATCH 0/3] spi: spi-ti-qspi: Support large NOR SPI flash
Message-ID: <20191220115928.GA4790@sirena.org.uk>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
 <CAORVsuUA3KTMFMiLJbFfSMMB3LupCZWm-2BBs46z6scGH45Vdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <CAORVsuUA3KTMFMiLJbFfSMMB3LupCZWm-2BBs46z6scGH45Vdw@mail.gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 01:24:15PM +0100, Jean Pihet wrote:
> Hi Mark, Tony, Vignesh,
>=20
> Ping on this series V2. Can you please check the reworked patches?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38t54ACgkQJNaLcl1U
h9Aaogf/WuUttHC80Y9Ni4mFv9SvJBial9ZQaebF3n1tvNzRkHZMGCtAj9cQ+zCE
9eLgFFJX8gtKGJE9+BrZD4+L0cUUVyT3ZN33hxZQ/AEabjhdX9W1M6ofPQZ0BPKn
ZOv6JTDrhPTA9bspRgO9grd0JizLZRGfeYneRq+ZvCYcDof7nO/Tha7XyQeWYpxF
5FsjekdG/mgrb8LXxOtMwCzChU2NQYkzVYi4UHNDsXd/Ab5ghIsnJna1merDrmDF
SF71vi/OgYUf5acGVo9fU8VxK5lnVDBGKpd4zcdUiLNaydFcxsvZNyGw4m4YxS3C
ZWC0jqzFumBqveyki9wd3vnkviOKkA==
=fdM+
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
