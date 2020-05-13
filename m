Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB821D1129
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgEMLVU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 07:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732496AbgEMLVT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 07:21:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3573320753;
        Wed, 13 May 2020 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589368878;
        bh=1rM3FpjaWvSlq2GT/NFR1D7yxdKbGJ971Atj6aZc2yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuhH0snCqTgyXK73vkjq4nWdUwTe8fMeut0GdsMCMiahxuPGfwDpOkR1/TB51yCiK
         8qdbnMgMXleLVbKQosV+7fUXktbSL0TO/GUAbUlI237/y/oyXuQBo4bRuw4V1oLZC8
         tkIqmZ2H1HwD0Cc2sMqkDuCh+TzFs6eWPt/hoPy8=
Date:   Wed, 13 May 2020 12:21:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200513112116.GE4803@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508133336.GK4820@sirena.org.uk>
 <20200512200733.bdbbhkjkwjd5yzqq@mobilestation>
 <20200513102324.GB4803@sirena.org.uk>
 <20200513110407.uaosfxebsgnllsf4@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20200513110407.uaosfxebsgnllsf4@mobilestation>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 02:04:07PM +0300, Serge Semin wrote:
> On Wed, May 13, 2020 at 11:23:24AM +0100, Mark Brown wrote:

> > The conversion to YAML format should be the very last thing in the patch
> > series,

> Hm, haven't heard about this requirement. Could you point me out to a doc or
> some discussion concerning this for future reference? It's not a first DT
> conversion patch I've submitted and non of them were addressed with such
> request. I do understand that the order of DT concerning patches can be
> important and agree to fix it by updating the original legacy binding first,
> then perform a conversion. But placing the conversion in a tail of the series
> just seems unnecessary. The patch can be dropped from any place of the series
> if for some reason Rob would be late with review.

This is a practical observation based on the fact that there is a huge
backlog of reviews of DT binding conversions and that those conversions
typically go through several review cycles and that not everyone who's
sending patches to the kernel is fully up to speed on processes or has
strong English.  By telling people (including other people who find
instructions on the list) to put the conversion right at the end of the
series I am avoiding any ambiguity or confusion about ordering with
regard to any other patches to the DT, including any new patches that
get added to the series.

> Personally I prefer placing all DT changes in the head of the series, so Rob
> wouldn't need to search through the whole patchset looking for the DT-related
> patches.

Ideally the YAML conversions would be done entirely separately to other
development rather than as part of a bigger series, they're pretty much
orthogonal anyway.  Sadly there's obvious content collisions with any
new development that adds DT stuff so that's not always the most
practical thing.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl672CsACgkQJNaLcl1U
h9CvIgf8CclGE4F4cQcTkCuqaYdGr9ohJ2hjT7jc11cc7QMWD/qMRJp3MiooztOw
uZbiDEGdSvfLq8OyAIQzKsbwaSp7JB9Fex40Xxw4YQwI0aKS3eGDoAjpbQ9pNaBX
Lu2P43EHmVbsGqRB+FQ1eyRWK9mHCSMBRD4Vi+4eKgmajrP49rhKKgVEQLEv0TDB
CUGxIaXw/hzzpcSMnibBRzU+0x7rXzxR/twRQyuRSGWtdWwdXs7StavwUtg/1Vzz
8PzW69SHXfq51QITjsEsRQBiUwm9e5t1QOfxL6HPbjYPjzPnDNxRWcvJu+m3KITV
7qkM0+jJ+R/al+sS+pG2410lS7ISTA==
=n6l5
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
