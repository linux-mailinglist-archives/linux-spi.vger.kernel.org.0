Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA787934
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2019 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405954AbfHIMBv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Aug 2019 08:01:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIMBv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Aug 2019 08:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hUtaPSltEcXHVj72o+olbdV6HgeE8OWSIe3V2Uuu1E0=; b=HYR+RmxIHYcnV12KQgaa45QYm
        GoLpS+CUr2+B771DY9+uhonKQLK7YsOJAwGv75D3RZbMPZIBuW8boHuc9XkIts0Daloey31CHcgUa
        WH+rTEag4wVkzNL5wEJyHMs0PXe5Yxd8Nl1mueXt6MmxoZmfr8yfY9cc0f5GK8L4jy0Ek=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw3aU-0005uE-Rc; Fri, 09 Aug 2019 12:01:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B8B46274303D; Fri,  9 Aug 2019 13:01:37 +0100 (BST)
Date:   Fri, 9 Aug 2019 13:01:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Message-ID: <20190809120137.GB3963@sirena.co.uk>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-8-arnd@arndb.de>
 <20190808222408.GS3795@sirena.co.uk>
 <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 01:29:13PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 12:24 AM Mark Brown <broonie@kernel.org> wrote:

> > On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> > > The driver has always had a FIXME about this, and it seems
> > > like this trivial code move avoids a mach header inclusion,
> > > so just do it.

> > This appears to be part of a series but I've no cover letter or anything
> > else from it.  What's the story for dependencies and merging?

> Sorry for missing you on the cover letter. The patch is part of a series
> to make omap1 part of ARCH_MULTIPLATFORM. I'd like to merge the entire
> series through the arm-soc tree to avoid dependencies:

Acked-by: Mark Brown <broonie@kernel.org>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NYKAACgkQJNaLcl1U
h9D0Mgf/YWgKanEmJ6JDhVz0YRrbGtKA8AWG2fRI2pGeEytOfrDSw7hneA7X5s8z
h4/FRWERBh3ITDppRQSAK0n/A9qeD5rERsYSRCqAoMWMLKEkvuYwyCWwZQgdtH33
SNzuCxSqJYCuGS7xhq4K3rAm6f7xKmiZdznNEw85e5ko/vKsep9rvM/GypIE4eFH
q8p6nexDb6VAQrJoaq6APDLZxygD6QNvokmhM0rjgSpX7VIwBwuYJOKhO9+dwglw
9sQ/rq8KIuYpIWQ1idwf7c3NCGeJ9kbhjaHC31QhDZlSYRyV1mtmoocSCkU3Hg2D
rA7q8CGPt8k2fysNcaxG/yrZBUY4QA==
=ujey
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
