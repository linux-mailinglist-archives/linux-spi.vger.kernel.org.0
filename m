Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE42CF283
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLDRBn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 12:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLDRBn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 12:01:43 -0500
Date:   Fri, 4 Dec 2020 17:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607101262;
        bh=4ltAGqyePwzC6mMogfJkZa93IzO6bxiuOkFWcBWhhME=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZR9O3t2sEReXp8CvktbnVg0x5nBMcxC/hNpv/tsM95tRcSPu/EwGhG4t2058oBTR
         SLaeYyPWB3s+7ixmyf0wl2FrFukUK+Gh8EX3Bb0zCzZwS3UkrbuZSCmjGNJsWdtP4k
         hggyrhd7H7et8ZiVgQyWkaaJ1G5mNRE4GEPUjFlJK0uCO6YBjFEWGkTjK9Sy+jXkTb
         j6nyKOGz0DhK3BIGYthpXyYffIfQnIRKmK6XtgutIIe4MEJVqrBbnv7T2tJGiE05hk
         Wpa4U9PMG5aaWjDMsPwutsJMFSEjH8eJAKTJEIjF+8YlhLSJxU2uZ4kTQYp+JRJqt9
         VnY9h2K+Cfabg==
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
Message-ID: <20201204170058.GA4558@sirena.org.uk>
References: <20201202214935.1114381-1-swboyd@chromium.org>
 <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com>
 <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com>
 <160695644776.2717324.633265815704005177@swboyd.mtv.corp.google.com>
 <CAD=FV=WDYdfURHWf8qGOSwT+7Y5i=9FMgRn5hYZA-oTfR6KoFQ@mail.gmail.com>
 <160704063968.1580929.17834773484656581141@swboyd.mtv.corp.google.com>
 <8d864844-11d8-0eae-d85c-29136f035c1b@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <8d864844-11d8-0eae-d85c-29136f035c1b@collabora.com>
X-Cookie: Not a flying toy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2020 at 10:13:52AM +0100, Enric Balletbo i Serra wrote:

> I am fine either way. I'm fine with pick all the patches and go through t=
he
> chrome/platform tree if Mark is agree (I think this patch has no other
> dependencies and the patch applies cleanly to my tree) or all can go thro=
ugh the
> Mark's tree. If I need to an IB I can also do it without problems.
>=20
> I'll leave Mark to decide who has much experience solving this kind of pr=
oblems.

I'm happy to take both patches, there are some others in this area in
the SPI tree so it might minimise bisection problems if I take them but
not sure if there's any actual overlap there.  If someone could resend
them as a series?

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Ka0cACgkQJNaLcl1U
h9BlBQf+OitvqxWFwbekqNW1Zy+tBC5mf9XOX/XVfwfXx/Ol8Reo7KEuaSHgfMTS
ZdCnI/SA7ajzD8UGbkoli1TJxsVEKogr2RFUYR6NtPjYpnboPZZXR3NOjrMtzNrq
H1dvMuq5ArRgdLHdmURBeTfPhc4yrLbSoubumzt/E355kgwklsgf8mHVEHt8X2fe
SWa9u77sp/4JnWgLAqcT5W4T76QvP0Oz/o4RA0xZEhENVDrJw2HBlmG6q49dOadl
DplosqeIZmqEIXXBrpUJrm07S54mcWNT2ZB7/LCaZsr5+28dkLzmPU53zoo/SJrV
YyRjFT00tHqbS0qmdNGGP4jcVL6Ypg==
=JM/D
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
