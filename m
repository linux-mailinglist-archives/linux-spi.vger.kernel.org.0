Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2F25491D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgH0PVZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 11:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgH0LdA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Aug 2020 07:33:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACF322B40;
        Thu, 27 Aug 2020 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598527973;
        bh=5EXplaVXNI+IHFzq1tVAP2yAGUXR9mfdt5BaX3Eq9FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnqH2UurJYyKagUdSIUZIvaKa853kKWzU5p1R3C1/o7PeWY8DoJNwn6QOtYWMSaQM
         erpjZu5+pVs3JEgFBnQPJP8j1BXy33UA7ep3ic6p9Mg1ZzE04CcFHZzZjX1jNMM5Jh
         gQPeRG8AxN0/5DHRwXhMZOWi9nwmQalyZlPq2Ano=
Date:   Thu, 27 Aug 2020 12:32:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200827113216.GA4674@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
 <20200826204108.reuy7ieqabutwuwo@skbuf>
 <20200826204547.GU4965@sirena.org.uk>
 <20200826210657.z526xjhhkq6vkxgr@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20200826210657.z526xjhhkq6vkxgr@skbuf>
X-Cookie: Causes moderate eye irritation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2020 at 12:06:57AM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 09:45:47PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2020 at 11:41:08PM +0300, Vladimir Oltean wrote:

> > > Something doesn't look right about PRP0001, what's the catch?

> > Microsoft decided not to implement support for it in Windows, it's
> > essentially there for embedded style x86 platforms running Linux so they
> > don't need to reimplement so many wheels and can just reuse existing DT
> > bindings but it causes problems if you want to run Windows (and possibly
> > some of the enterprise Linux distros, I can't remember if any of them
> > had concerns about it) on the platform.

> So if a silicon vendor doesn't care about Windows, what incentive does
> it have to even register an official ACPI/PNP ID for its devices?

Not that there's any registration process or anything, there's some
namespacing but that's it, but the main thing would just be keeping the
ACPI bindings and DT bindings separate.  ACPI has some strong opinions
on how systems are built and described so while you can use the PRP0001
stuff to parse DT bindings on an ACPI system it doesn't alway fit well,
and there are some things where you just plain shouldn't use PRP0001
since the ACPI and DT models for that sort of device diverge so strongly.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Hmb8ACgkQJNaLcl1U
h9B/KAf/TZJSBmxaYq4h8SUowHGREwHtVaLdaCnflawd6gDO2QF8RPV57eClAnLS
G7UDFlscVt90VKQ+6DDiYMyEROOQEyOPSXF9do7/uAlnYpwiiW34cbCHCJ7aZZh9
LTBOxhKioz1sxuFrwUIPSWS2HFdFayu8xSl6op0MWjABI+R6pwILHPsx+ks5jkSN
jCDn5IZTxFqgP9pB/xtUl2/njhQ8wwVTYg3Outr5+gl2gMgPC+mAhwsrYv53mzUu
XtPDZ9AvJc/hXRoN1+2LsE+w8dhmWkofhLavT55sS5ncKlqf2DzOXmRV0UUqR+Io
Bxgrb3GnGd503w/KsxUmXzusS3x+tg==
=b08t
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
