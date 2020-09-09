Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A8263411
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgIIRNy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIPcL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBEA2206F4;
        Wed,  9 Sep 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599661972;
        bh=G6V5+rrjseSZbwoAOOIF/H9RV9qG8won/T+LJdUIn9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcC8aUhafORqR4CPAJGT2pHQZbY/gh3kGAru56tbTM2VqzChgPJvPdcBCQggcf0MB
         qfV56qHpfCJvXbTgxVYOQNoTSW9RD4QRQv4L/gel8Dc1mgjUe0Wy3ZQZiFbNXuf+nR
         /9xMTu9pV6RNk8x6Sapyzzt2xXiOBf3bINuOG0M0=
Date:   Wed, 9 Sep 2020 15:32:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>
Subject: Re: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Message-ID: <20200909143206.GD4926@sirena.org.uk>
References: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
 <20200909120148.GC4926@sirena.org.uk>
 <af06cac916ebcdf6f526baa9cba98494@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <af06cac916ebcdf6f526baa9cba98494@mail.gmail.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2020 at 06:29:10PM +0530, Kuldip Dwivedi wrote:

> > | Does NXP know about this ID assignment from their namespace?  ACPI IDs
> > | should be namespaced by whoever's assigning the ID to avoid
> collisions.

> Yes, NXP is aware.

Can anyone from NXP confirm this?

> > Please don't ignore review comments, people are generally making them
> for a
> > reason and are likely to have the same concerns if issues remain

> This is new Patch for different IP (FSPI)  and scenario is different from
> DSPI driver.

If a generic issue like this exists with one patch you should expect
that exactly the same issue is going to come up with other very similar
patches and therefore ensure they are addressed so people don't feel
like you are ignoring them.

> > >  	/* Reset the module */
> > > +	fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
> > > +

> > Why are you adding this reset?  How is it connected to adding ACPI
> support - it
> > looks like it should be a separate patch.

> I observed a kernel panic in setting up the driver, and this fixed the
> issue.

At the very least this would need to be called out in the changelog but
like I say it should really be a separate patch.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Y52UACgkQJNaLcl1U
h9AqTAf/fWMxxf95EG2ZsGPtdYfSRjeCSCgERIcQz+KwEjHrU9qHLBQ0mNsCX69a
VNnVGwT3bW9Ts1AJ8bTW7HrqW6pCFakpiY3tZBV6kkHj+MoljcgRt6I1vjlAjRWW
8jJd4iFQru98oFktipTbFSQgnPMT2Y/y1q0Wc2DuclzFse2kDsdEmuAAzzqJwzZ3
M2tO1phNIbeCDBiR9dtHYuxuO+uOYBt0ujftKDawUxSCQAwJ2UmOLUE6vsChOHmF
vSHuBRQBgkWDg5g093DoIpdT1OUteuDY7ujd+tcsZEqa+RpIn8lLF5yLcxCe2N0c
7EqZ/Jyvb8qTcEnHKi1GGtx2mK31KQ==
=l0lP
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
