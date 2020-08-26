Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C362253762
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZSnb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 14:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZSna (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 14:43:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9562078A;
        Wed, 26 Aug 2020 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598467410;
        bh=ZJ576EINgrbUWdEegD3xeGZDqrWiQvY5FxNFvWpJz48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAqwZSV8AloRU2wMta74svPgkPWdde6saSpbbfaGaBLEJpS1NNQ5vEdksVVHBMrZm
         NKMg/aMDQctJnBPfMb4c2rrohs129CLAyXYc/KsXOTkurPBcb5awaN2qqtC+Mxyn2p
         7zyPmKYwQLRwonZ7U8VTCNmng3CjQRQAbWj2SmzM=
Date:   Wed, 26 Aug 2020 19:42:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826184253.GQ4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <20200826165552.GK4965@sirena.org.uk>
 <20200826183338.rwacm5cstialye7p@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6tPipYVl+OcoAvSh"
Content-Disposition: inline
In-Reply-To: <20200826183338.rwacm5cstialye7p@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6tPipYVl+OcoAvSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 09:33:38PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 05:55:52PM +0100, Mark Brown wrote:
> > > On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:

> > > Showing my ignorance here, but is there something equivalent to
> > > of_machine_is_compatible() for ACPI?

> > The NXP0005 is the ACPI equivalent of a compatible (comprehensibility is
> > not ACPI's forte) and they're tying driver data to it there.

> Where I was trying to get here is that we could have a single _HID for
> the DSPI controller, and corroborate that with the ACPI equivalent of
> of_machine_is_compatible("fsl,ls2085a") at driver probe time before
> assigning the driver data.

Oh, there isn't an ACPI equivalent of that.  DMI information doesn't
capture anything useful about the chipset, only the system as a whole
(assuming it's usefully filled).  See for example

    sound/soc/intel/common/soc-intel-quirks.h

--6tPipYVl+OcoAvSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GrSwACgkQJNaLcl1U
h9BTwwf/UC9FE5te5yLO50ORMpLbd43woAa1RASjtbHEXqqBUGNX07IBofYnizJd
Phnq9LBl9N/uri6BSPQ/jTNszToqnL4U9am4WrwTkpLPMZf8bUl23R36QMsUfQLf
wtJKpbRhjZbBx1mXDTjICFquc4VblqQb8qpR41/M7+GBCooUeLYSWd1tALg0Kynh
8Au7PM96cdOj+uUYytnDh3ZftBGv8l7WxXVChTByIglgMVDt0nV7wLZTRigz3RVJ
dY14oJB2VNZcQNIlBew4FtzggcFG7eWzPNScouMYMGN7hl9Y0Wn6KmK2cwcsEMpV
0cg/JUQ7ht/paLcQbWzr1Mhp471Org==
=WS/5
-----END PGP SIGNATURE-----

--6tPipYVl+OcoAvSh--
