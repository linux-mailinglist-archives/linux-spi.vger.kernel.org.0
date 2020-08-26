Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857A2535AC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZRCn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 13:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHZRCn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 13:02:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CC420737;
        Wed, 26 Aug 2020 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598461362;
        bh=uWBwLrd7S1Yp+nZTjHPbZcVY0podVwESHryIx8RQH3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuKxJ0TDh87RUVYEuCIhxbMKSVimWIkMT/cm+vl7rbEQizVxzNQAUvGfs1f0rvQfo
         xpg2hUM5K1+Wgs9Ad+ByUWisayz14qiD0gSbStn5wRlxzZ68IwzagYtw5xc20fabys
         BjI4niK/EqQkZZwaGdzKSXnEfNpiPok6EaJjXHi8=
Date:   Wed, 26 Aug 2020 18:02:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826170205.GL4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
 <20200826160950.i3k2oy6w2dlvmj34@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S6vg04ofUPzW4qJg"
Content-Disposition: inline
In-Reply-To: <20200826160950.i3k2oy6w2dlvmj34@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--S6vg04ofUPzW4qJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 07:09:50PM +0300, Vladimir Oltean wrote:

> I don't even know if NXP0005 is made up or if it's written down
> somewhere in the PNP ID registry. NXP0006 seems to be assigned to the

Well, any ID is made up to some extent.  I am concerned about the
allocation of IDs too, it needs to be coordinated with NXP since it's
being allocated from their namespace, but unfortunately in general
there's no sensible way to go from a chip/feature name to an ACPI name
due to ACPI's specification mechanism.  There's also not any kind of
central list of IDs.

> In the ACPI spec there's also a _HRV (Hardware Revision) object, which
> comes as a simple DWORD. We could use acpi_evaluate_integer() to read
> that, and use it as index into the array of fsl_dspi_devtype_data, if
> we declare that as ABI within the driver (and new SoCs would be added
> only at the end of the enum). Then we could use the NXP0005 _HID for
> everything DSPI.

That's not something that it's particularly idiomatic to actually use in
ACPI and you end up with the same namespacing problem assigning IDs so
I'm not sure it makes life any better.

--S6vg04ofUPzW4qJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GlY0ACgkQJNaLcl1U
h9Bozgf/Sz7mY5RFESRs7ctTI2nM5uKnrKtvcFPSKn1Xsj12Sh164fQPPeOKpxnj
bPxpi3txdmYil0BWOO3rZ1NqAVLNoI0+ojuCpGryNonUG+xWvSOLHcIcRGeewI5J
0Z5aX/VR8NIWM9te2nAvwfm0xy1b/DqgLP91v/jd46B/cL2+hpq9OoejiuQgcQBU
98TqyC8vb24xnV6nBbbUl4yUrkdhfABO0SqKibPnTWPTrhm6Al1gWvck6ZnfCZcm
d0vKvMsblW5Z6nORNOVuEEc7V+3xihn1iD1x8W9tKTazKJrbgRWXtlbItTZJqEka
yb+i0TPtKDvt15TC4GqRMFDI2UUavA==
=n6mB
-----END PGP SIGNATURE-----

--S6vg04ofUPzW4qJg--
