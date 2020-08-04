Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6223C13E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Aug 2020 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHDVPG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Aug 2020 17:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgHDVPF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Aug 2020 17:15:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DE22075A;
        Tue,  4 Aug 2020 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596575705;
        bh=tbCDeBlFPTN3tR2opupaPgmE296pCaRtjKYPZNrKFxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tk4CLVIc/F98FWYpkvEKaxb5qTlpa1/kmW4bFZjBWySL4/Oa1FKan5BnJJQzCcAcs
         zHQOD+s0GZHqjPvCktBrqyPWsfcQLFOOsbS1T0MpI8rN0E50bkY8iPqC0ZImcK9wtv
         wQhIHqAnwKP6Nj4rVEA0gq2oQkjOAzleJhyGyJWY=
Date:   Tue, 4 Aug 2020 22:14:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] spi: dw-dma: Add max SG entries burst capability
 support
Message-ID: <20200804211443.GE5249@sirena.org.uk>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731092612.GK3703480@smile.fi.intel.com>
 <20200731125954.jeeqmccnknqllwxh@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <20200731125954.jeeqmccnknqllwxh@mobilestation>
X-Cookie: Every solution breeds new problems.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 03:59:54PM +0300, Serge Semin wrote:
> On Fri, Jul 31, 2020 at 12:26:12PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 31, 2020 at 10:59:45AM +0300, Serge Semin wrote:

> > > Note since the DMA-engine subsystem in kernel 5.8-rcX doesn't have the
> > > max_sg_burst capability supported, this series is intended to be applied
> > > only after the "next"-branch of the DMA-engine repository is merged into
> > > the mainline repo. Alternatively the series could be merged in through the
> > > DMA-engine repo.

> > This needs to be thought through...

> There is nothing to think about: either Mark completes review/accepts the series
> and Vinod agrees to merge it in through the DMA-engine repo, or we'll have to
> wait until the next merge window is closed and then merge the series in
> traditionally through the SPI repo.

Well, the merge window is open now so this won't get applied till -rc1
anyway.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8pz8IACgkQJNaLcl1U
h9AYKgf9HNtd2FGIEieYPkuzAQcSJQLGew4KZucymrWjbuTvb5SMMej/oB9leesx
GfKcCECfT73+aZrNC8QQHPkjRvmX7ciK5qtHuNMQ8H+ewnXF/vPsonvirE4RuskD
bhAXbs2ZZxU6eOvigw4+hDleEJ+xtsuyk3D7PggkrtQ+3S0hBlhfuXJVN8SnVrzf
Z33AHm+uHWCOTKODQiZdY/LsVYgeFbU11rMrujdc0UbXKa616aLa/PMTqGHGOIJV
tVu6hT5jGnKxABexOzXGeKqQKExVCIKg94MLUpcj75pcTnm6plesfAaCDxO18Ufo
/G6U4/JDVcfZjfiwn/MzeE8YPoWfMA==
=JKrs
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
