Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13132249F71
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgHSNTP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgHSNRZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 09:17:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6982620738;
        Wed, 19 Aug 2020 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597843026;
        bh=7df/TUJeBHIe2mB9oBXeBkh+EQRwdiNjiD4KxxgBqo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiFLbqLVGPsc5ZLdPoBXadBWxwCXIuCXj+DLmeuRmAJbi0i4prTzbnKTFqxjvo2Jc
         SOnV3SDpiYOhITUy1MUOizr4HKdYczHnqgaTeenFPoT6m3Qw1xrctuSouGv9UH4QNz
         dQo8rz9ZIpHFAzXMOqElmv/oBQX2bSYCmqIKn5/o=
Date:   Wed, 19 Aug 2020 14:16:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Message-ID: <20200819131635.GD5441@sirena.org.uk>
References: <20200819123834.GB18122@kozik-lap>
 <CGME20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b@eucas1p1.samsung.com>
 <dleftjtuwy23zk.fsf%l.stelmach@samsung.com>
 <20200819125822.GA18970@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20200819125822.GA18970@kozik-lap>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 02:58:22PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:51:27PM +0200, Lukasz Stelmach wrote:

> > Honestly, I don't know and I couldn't find out why. It makes stuff
> > work. There has been a commit like this before

> >     0f5a751ace25 spi/s3c64xx: Enable GPIO /CS prior to starting hardware

> > Apparently, it was lost in

> >     0732a9d2a155 spi/s3c64xx: Use core message handling

> Then describe at least this... maybe Mark knows why he brough back old
> code after refactoring?

I'm not sure what's being referred to as being lost in the second commit
TBH.  The first commit is simple code motion rather than a correctness
thing, and more related to the handling of GPIO controlled chip selects
according to the description (which people should be using with that
controller anyway where possible IIRC, the native chip select has too
many assumptions about what it's doing).  I don't know that I ever
actually used a system that used the native chip select as the actual
chip select.  Perhaps some quirk was introduced where the chip select
signal does something?

The commit is also lacking a description of what the issues that are
being fixed are.

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89JjIACgkQJNaLcl1U
h9BNQwf8DubxsPLcMMxLcGFtVMDtvgwTAWvvC87/lyUd+XdYf3m9RPcpkI5Opjgx
PWrzGQRqtWRJoGOSciM6ePbqWIHFg2Ip/JyLZj82ppSXtc37TtIdg9aY0EQLgT95
iOUYZ97paaOoy7tZ1hM7aNqZT9ZhF/ChEJsv6Astxq2U9V6gVl3/CGXfhJ473RR9
g1BzoJuSS2rTx4/mTepuKb4nw4paoWW6wClhHMUuwLfscRkys22Xuze0DW+xRCGw
r8AF4Athe1vxECWZAsX1zkgEgo9BfBVx6A6WB1PqVVEgbewcFZbEF4Ih7sIYcnI9
GM1ikUdE2Z1PkJR/gkZ6yEDnhs2X/A==
=IS2d
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
