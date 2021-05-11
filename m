Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5D37A807
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhEKNsx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 09:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhEKNsx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 09:48:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D7E61364;
        Tue, 11 May 2021 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620740866;
        bh=UmLVfYv/Ytt9Rgiry4s8eNtetCcYoRGB/Ct/IuvwlNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjjmCPIvBh4x6Ha6g0MQt/leM4pPUE873yViHt7Zon76Otxf7gxaWdFvUW2crS1CC
         zRLvcXRhaeoLqr5FybQqySx7oz4mIbMqqN2/b2oR8U7I6nswxIEHHo3l42+UVWW9qR
         WH7AcpiiY1aVotn7YQVtIyxNabroCbR+H7vmrPLKTnnEbtHXPg4JzWn/tUl9gB0bBM
         JfjH7EX96+9mdFV4UdfgKyAY1ukQPhBHsi9QJ0dN2kE9uABn1Tc86xg26jLVx7/fM3
         v2pd+xdW0F0DT40zKG+c/RriiSZUHHb/Ub7DiwfUeEbigMn2gMWIgLAjASJ9yP4xW4
         Az0Lnr1hmGrSg==
Date:   Tue, 11 May 2021 14:47:06 +0100
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
Message-ID: <20210511134706.GI4496@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline
In-Reply-To: <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:

> > On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > > Set of cleanups here and there related to the SPI PXA2xx driver.
> > > On top of them, adding the special type for Intel Merrifield.

> > [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
> >         (no commit info)

> The above patches are effectively missed.
> Anything to fix in your scripts / my patches?

Like I said, patch 7 didn't apply so you should check and resend.

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCaitkACgkQJNaLcl1U
h9CNZQf/XCg3kAZe8x4TQDVH7+UnadT7m/gM1TitiXHxim8Yi52rdkJB13fVwXU/
TTVM8xqpSBe9KVjRy90TB5fDxXdv/X/EJtI5L9LRu8c9PXxig8jEaEmDyCw+ezDS
BvdurHa9xSStpjA0dgFL/ntYxESHBq16OoTXw2Qhk4K+D9ouv67Y3kpaRW5fucRo
lFC6fAdA3T0Ju/QuA53WSs3gXy3PPbt3iKx/HNIRKEQy0AzzoKbTgEPiU+iMGNCC
41k/czYtvqH5zC6LrzTqq/gUEsw9fiAGCsfTqUKEwyB9LLRTbS+7ehYwkVzGfJ0H
ma+ZEGEWIuAPq7a5d/chIl9RdBbr5g==
=HvNy
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
