Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2025358D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHZQ4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 12:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgHZQ43 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 12:56:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D7242078B;
        Wed, 26 Aug 2020 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598460988;
        bh=n+FlLUZEHzpBx6mMAwJWTS/V8TvqHk1aUqPCZTwiEkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCIFuT0rRj5eNvQ/UT7fsMNifBxjOadHC2Oic4hZxMT+4WYmIzEmhq/iP1DbZk01M
         pXXXK14YWkAz6bTAbUzG8h6WnwAcM9N4IC1vzA6pjwRgV4Ku626p6GsHAuy9tH+WVO
         0nZAYfj1KaXX8lUb0p6psFx4bYWvZT/2VLUXAhAc=
Date:   Wed, 26 Aug 2020 17:55:52 +0100
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
Message-ID: <20200826165552.GK4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lZZ4ablUVnt2XgAh"
Content-Disposition: inline
In-Reply-To: <20200826144744.c4yzgoovk6f4t3id@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lZZ4ablUVnt2XgAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 05:47:44PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:

> > >   { "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], }

> > Based on some other stuff I've seen with ACPI on NXP stuff it looks like
> > they're following the same scheme but only caring about that one SoC for
> > the time being.

> So, no argument about caring only about ACPI on one particular SoC for
> the time being, but there's a big difference between a solution that
> works for N=1 and one that works for N=2...

> Showing my ignorance here, but is there something equivalent to
> of_machine_is_compatible() for ACPI?

The NXP0005 is the ACPI equivalent of a compatible (comprehensibility is
not ACPI's forte) and they're tying driver data to it there.

--lZZ4ablUVnt2XgAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GlBcACgkQJNaLcl1U
h9BLigf/TIGALBkqja0OQjdO58y/qR6xZAoxEEA+ktFP38R6iI4QgxbjhtGqNspL
jgkdWi/2hWrdAelSs8OhnKNU/rZKg/2gZdr/Pgvm5+ZxZX1js8mg9Hdsz2LsruTI
Z2lOefOm2b0WOm+7Lp5c4MR7ctrqlLKp7GZCd/TZbCO/QDQ2kjub47llggdQmR0Y
A31Yn02huKuuisa8sBBRo8VxOQaeewlXczM0eX3HfpPeKDDEXD/1cc627msfpf+S
uUZPjAhokAACrIyGEJLxW6KQJZl8YaATRbHKKPtVwHEuT2/nEShSPwC96dqVfeOw
cCSuVGn39chIew8+vOGNdjUiTB2Srw==
=8OEf
-----END PGP SIGNATURE-----

--lZZ4ablUVnt2XgAh--
