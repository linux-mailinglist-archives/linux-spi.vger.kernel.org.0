Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8225392D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHZUlr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 16:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHZUlq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 16:41:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4612078A;
        Wed, 26 Aug 2020 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598474506;
        bh=YAxwMHz+Yv/1iH9rzNa2SizES/G0MGq8G2wczS8SfRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+9IpBVDBeL8GmjeezHfBI6XIijChUbaRSofxymmg/ymA1og/wGjwlqZI2TCZhm22
         QgTbEayVVlr5a3/omqs4kTsYwQdXcbGDlFy/GkD2buceko9lzvcMDRfKRdr3+lPjJU
         +7H+iRxNEwV+nqiHrhikWQfAKrAroHoPAE1d6RtA=
Date:   Wed, 26 Aug 2020 21:41:09 +0100
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
Message-ID: <20200826204109.GT4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
 <CAHp75VetYbnOHv3LQhq4Gvs1CFe8LnZPzFAVoNmBi5DyAmZ9Jg@mail.gmail.com>
 <20200826195649.g6k574y6ofzbagnm@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5tINJiUS2/Dn5Rhr"
Content-Disposition: inline
In-Reply-To: <20200826195649.g6k574y6ofzbagnm@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5tINJiUS2/Dn5Rhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 10:56:49PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 10:36:15PM +0300, Andy Shevchenko wrote:

> > FIFO size can be read from the property

> My personal preference is for the driver to hold the expert information
> about the hardware parameters, and not the device tree. Today you need
> to know only about this set of parameters, tomorrow you need something
> new, but you also need to work with old DT blobs... It's a mess.

I strongly agree, it is much better to just know what the hardware is
and set any properties based off that so we don't need to update
firmwares to take advantage of additional features or fix quirks that
are discovered.

--5tINJiUS2/Dn5Rhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GyOQACgkQJNaLcl1U
h9C58Af3XowqgGlgNLSZufMTCUU9dHIGYQVCVp9Dj0U96sTqwpESXAZibjojNU/4
2nRQYpJfC7tJqGa33QerNMP24IeVw9cpBKP6w0IULR/dO48nkpOpoz8g6ZwSMtdK
zfLJUzgVbahD9rsT5Riz6pkrAEpEGfx1ml4duVTL4WKr4JHxqld/hFE5ohESl7Rl
oVJwWLjl8tY9Whl7FUKzngPLRCLU0O2JATB9GrufpNQdeBYWV+a1GutdrJRfg59N
A8G+Z+T/HVmzvJyNER7/TQuD4BWDiDniTt1KriE9Cy/dr8HMa8sXIMZwEiyeoJfj
9Yd3WhL73AIgyOaN9Ob6DokBdhKr
=gGjw
-----END PGP SIGNATURE-----

--5tINJiUS2/Dn5Rhr--
