Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2425394A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHZUqZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 16:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHZUqZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 16:46:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 051D52078D;
        Wed, 26 Aug 2020 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598474784;
        bh=OYUU0rJGxFEHOinAaW2j6zIQrhMSRz1MO1iyL7hSvy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfzQkAOrTZ1e30KpO/wAknFCm4uLPu7Ctx9VQNaxzW+epw05O4sGqxqzr+nM+1Ze0
         GM37nb9IaY2DCnAZtJnTCeW2MFvUNj+IccTAGvw+1bZaC4Zztz97mDVOweX1sIGxCP
         meyObtzPcfzAS4wRRXMo2iyvnqTNb2pBIcqTnrII=
Date:   Wed, 26 Aug 2020 21:45:47 +0100
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
Message-ID: <20200826204547.GU4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
 <20200826204108.reuy7ieqabutwuwo@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p8mP+8RrBGerSNjm"
Content-Disposition: inline
In-Reply-To: <20200826204108.reuy7ieqabutwuwo@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p8mP+8RrBGerSNjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 11:41:08PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 10:34:04PM +0300, Andy Shevchenko wrote:

> > Theoretically you may declare your HID in the same / similar way as
> > PRP0001 and use same compatible strings and all other DT properties
> > (when they make sense and not duplicate ACPI functionality).
> > But better if ACPI people can tell you (I Cc'ed Rafael and ACPI
> > mailing list) if it is gonna work.

> Something doesn't look right about PRP0001, what's the catch?

Microsoft decided not to implement support for it in Windows, it's
essentially there for embedded style x86 platforms running Linux so they
don't need to reimplement so many wheels and can just reuse existing DT
bindings but it causes problems if you want to run Windows (and possibly
some of the enterprise Linux distros, I can't remember if any of them
had concerns about it) on the platform.

--p8mP+8RrBGerSNjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GyfsACgkQJNaLcl1U
h9C2Xgf/U5iXD2Fm8wqFbVSfKajaqTfB7OsyGR/oZoQPfSiJrkaSENbsx4sevNjQ
ZrQ8z8Opo6Zi45t872miyS3Ib22XSU9/obKAkqaLxdVAWpGHvbf0qIv/mqh1VoQw
gcuJojxCD2M0k84Oww40ud41LKKLVPhFxLeSwKPJhvsGC2f49Lki2TkdggeY/4lY
r/TXKE96dl0TCwL1qvKFsC9Mc0LqIQKDKnsJSOSi9MwwEZQY+w/GWuhS3Iyl6EnX
wmsiwv+fc4lnwc/Uq9Kd0qzNTqmgeZ1d7j3mSvWb6Ptpr9vN/3NC4QvcELcFzxD1
z9VjMG1tUZOZPqskLzZ+fYa6hwf4Ww==
=WdfB
-----END PGP SIGNATURE-----

--p8mP+8RrBGerSNjm--
