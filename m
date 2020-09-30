Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2327E75D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgI3LFF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 07:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3LFE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 07:05:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56142071E;
        Wed, 30 Sep 2020 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601463903;
        bh=XsIo3OwcZB/YrXgr5fFvIKUd+3oyw+ZiU+SpFMwHkuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1bxiGTVkpEWkgxouRozaaxPDVg0evJiJdmeGucHqKTpn8I1OwjpNscOs/Bbbk8rI
         4DQ2+n68HVSYmOXAuEw7bKfETQb5axgNBu8WsuBRBooPebz715HjK6+bOtHVlE1f4+
         tW5hZRBVTpZpWqyKC6ixnhfT298uXukhDfNuSreo=
Date:   Wed, 30 Sep 2020 12:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-ID: <20200930110403.GD4974@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200929144351.GH4799@sirena.org.uk>
 <20200929224303.65awobe5dzwc2p4f@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <20200929224303.65awobe5dzwc2p4f@mobilestation>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 01:43:03AM +0300, Serge Semin wrote:
> On Tue, Sep 29, 2020 at 03:43:51PM +0100, Mark Brown wrote:

> > This is a *huge* patch series which is a bit unweildy to review
> > (especially given the other 10+ patch series you sent at the same time),

> Yeah, sorry about the bulky series. If most of the changes have been more
> complicated than that, less inter-dependent and less directed to having the code
> prepared for the main alterations I would have definitely split them up in
> different series. But the biggest part of the patchset is just a preparation
> before adding the mem-ops, poll-based transfers and Baikal-T1 SPI support. So
> having them submitted without the main part of the patchset would be just weird.

One option with things like this is to just not send everything at once
- even when split into multiple series it's a huge bulk of patches in an
inbox.  Unless the patches are obviously from their subjects repetitive
people probably aren't getting far enough in to look at the actual
patches or even their sizes before deciding it looks like a lot of work
and putting things off for later.

> I see you have already merged in the first nine patches. So would you like me
> to split the rest of them up into two series or it would be ok to resend (if
> required) them as one series seeing it's not that bulky anymore?

Not all of the first 9, IIRC I skipped one I had comments on.  If they
can be split that would probably be helpful, if there are dependencies
then it's not going to buy too much.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90ZiMACgkQJNaLcl1U
h9AUigf/TYq5DT2X2dbx9ok920WI57VbnM5aTbOetuQC4nHdggQwbPUpKCVStBDH
uGO45Jw0eYmvDhAlbvv27mE8vWfHa6DRw9hyS2UEmqkiAp2RDcUoR6phUGekfUht
8JMIZQIzrdeY//PR7TX518S3W4eSzAyi7bkvPNE61DMlLLOS/5X0ZyokPZAGkpPk
BiloDjax2q17Y0pZaZDjltYO3WivDmotHu4AduP7OuCYDf037LZapvkyrPBmtYnD
1SB5faRV7WK45Yi7do97wAJYhvJhjUmuCRomQa3d/Z5uBq9FOMM+LyJnqb21AD9X
7qepMKA5Lh0Xc7gVDfMVlbcDfWJkng==
=pV6w
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
