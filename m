Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81031FAEDE
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFPLDt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 07:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPLDs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 07:03:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53060207C4;
        Tue, 16 Jun 2020 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305427;
        bh=D5VxNNsWQG7Dnro1Y+aM+B4Rod1A23KmuRCGJah97io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZOoTvElAW7imPfVPdHU3wzfLaqrPFIGRturrOTRFLQADTVSjWQbP5SqaNbBZD72+
         fuK1KVqTF9OL7xXIj5AT8tu3USiek8qIpa1DjbfYoFzUnPrUKIp1nMIQtb8+VXfQSg
         BOjg18+W4AIxefHpJJetfV1EhhguP/3vwOnlHu0w=
Date:   Tue, 16 Jun 2020 12:03:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742
 support
Message-ID: <20200616110345.GM4447@sirena.org.uk>
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200610110810.GD5005@sirena.org.uk>
 <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
 <20200610164928.GJ5005@sirena.org.uk>
 <CAMuHMdUNo0tMxWsnXi4q8NwubPWHqTvzGOA-0hOr7oo2cRvvUg@mail.gmail.com>
 <20200611085004.GC4671@sirena.org.uk>
 <CAMuHMdUBp79ix5hPjXBARTrOokg-pWY+Rdno9-dd6dBTv+TRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glNuw4S6NeIZr5j7"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBp79ix5hPjXBARTrOokg-pWY+Rdno9-dd6dBTv+TRcw@mail.gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--glNuw4S6NeIZr5j7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 02:09:54PM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 11, 2020 at 10:50 AM Mark Brown <broonie@kernel.org> wrote:

> > I'm not sure it's a particular concern, especially since you'll be
> > sending this stuff in the same series as a bindings update and an extra
> > patch in a series makes very little difference.

> Until the DT bindings are split off into their own project...
> Listing unneeded compatible values in drivers also increases binary size.
> For RSPI and MSIOF that would be +2.5 KiB each.  Times tens of drivers.

> Considering the RSPI driver itself is only 9 KiB, and some RZ/A1 systems
> are really memory-constrained, I think it's better to avoid that.

That is an issue, though I can't help wondering if space constrained
systems could use some sort of automatic compaction of the ID tables
during install.  We're also bloating their DTs by adding fallbacks of
course!

> > > Nowadays we have "make dtbs_check", so if a DTS doesn't conform to the
> > > binding, it will be flagged.

> > For things that are upstream.

> The DT bindings apply to out-of-tree DTS files, too ;-)
> If they're not compliant, all odds are off.

The point here is to improve robustness and make the interface less
fragile.

--glNuw4S6NeIZr5j7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7opxAACgkQJNaLcl1U
h9Clqgf+NXdGTDeyVuyK7mHfxG3TU29aQ6SxLfp1zChued6vIWJ467CxbXbKysTU
Y90kMfKvPmR4Yx8yCB26tssThBUgY6z9HS1CgLUEHYJmeHN3qK7cgNJKydxW+wXr
QoiIedUNg3qvg+5mmP+HW0KSl7iCYLe37TdZvFrXse0Jsh7uHKg6m8s568s75byG
pl0WyBiRotsSsOUrPVFI1kQ3ofUiBecMmyWwL5SDV5fPfPnQLWZgf2KKgsFfeREo
tfPgIK6ILBuH5mmSQ4xo3xVIkVg9MMwOG+47Gzm1pkG6p3JX/dv9DiESxmZSuc6W
PpEoyXXzPoNbTny9qQTvmss7G3G2OQ==
=5KTC
-----END PGP SIGNATURE-----

--glNuw4S6NeIZr5j7--
