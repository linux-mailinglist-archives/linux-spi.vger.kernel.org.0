Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CA37A915
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhEKOZM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhEKOZK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:25:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1E196191D;
        Tue, 11 May 2021 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620743043;
        bh=wJ+4cBBj7zHK6XS8zc7+fNwV8ORjVAMlWIuJ5Iuzs8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mragve0FOBm1OVcs9ENSktykBXpTAlvDdbY6U6NYXsL4GRjFXu/8qzKrerur8//8v
         //lUW+7b6CzoMSfZ3UtBghu6ZHq2tRYyjq7uY/uhGh4l6QbnKy5eAe/PJkdhoO5hHe
         LgttsgFY2Nyso/RvJUs2oSgI4YOS2uPkS477/K9r1UwoK2R9VxwU8ovbJjeAdAnA+F
         cPFqPA66I0uf/Y9izmGbWyvYZNNN/mU6vHh9P4tco+aZBSOn8rBFmEn+6ocX6JikH0
         zKx+aFAc/FiG/AXOsmci4gnArTYyeVPYR8458InI8s35fqJfIKwircEu3f770mNoOb
         fWejAlhMINwRw==
Date:   Tue, 11 May 2021 15:23:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210511142323.GJ4496@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk>
 <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline
In-Reply-To: <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 11, 2021 at 04:52:40PM +0300, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 4:47 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:

> > > The above patches are effectively missed.
> > > Anything to fix in your scripts / my patches?

> > Like I said, patch 7 didn't apply so you should check and resend.

> I didn't get it. I have effectively rebased the entire series and resend as v2.

No, you resent it again as v3.  This was me applying the bits of v2 that
would actually apply.

> I can speculate that your scripts have a bug since they might try v1
> as well (as far as I can see they usually send a confirmation of
> application for all versions of the series in question).

They end up sending confirmations for every version of the series I've
tried to queue unless I go and explicitly delete the older versions.

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCak1oACgkQJNaLcl1U
h9BuxQf+OegOJM0y6NfKvrOgJTzp2GmTk4h80iy95DznuLEjuM5uqMUHLkySbAsF
ACndImPyX0HcJr1YWqWDnBjsp/f24gcAeWXyUYvFNUEtAyk+dBD5cagzHrRXX5ZU
WQOXqJtpO6ergLfANl22xwENmHcKyWlGVzcw3WWZjp1s1+fkp/T+p1pjC84+3IBb
v1PqVn0ozqU5ndAUVlpTWFWJ7codivp6LMPawIszqpXY5QL0j6cZlnxdLj6RJzjb
u6aZ7HlN+GIDDqfv9x/FrnLC1m0DtFw3SGKGJ/grF1iF9k25fMzP1YPu/vQokKUv
yqdh5VXfN8s2EVGn6IXTk1aqrKUWqw==
=SINU
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
