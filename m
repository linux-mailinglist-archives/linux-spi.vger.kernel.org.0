Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE40200761
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 12:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgFSK5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 06:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732574AbgFSK5F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 06:57:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC20F208B8;
        Fri, 19 Jun 2020 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592564225;
        bh=GIHyfpmtdoRnt3hDj/nrol1WQSHP0lZsUz5oCSQRoFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTZQjOiCjsnAWqGElToyVGFjzvqVCb/t+eXA9fjVbDOLAR6m04xz7b4CIs7V1Tb6Q
         +xx/zDBVQws+RSMSrIN092I7dpmGVa7v3U+cv3i2c+EyHViVfHSR7VkQq7sIsLV5Z4
         WqHzJDmVJINinn4sJN35OuS2KOMaBsuWGSbndLKo=
Date:   Fri, 19 Jun 2020 11:57:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
Subject: Re: [RESEND PATCH v3 0/8] mtd: spi-nor: Move cadence-qaudspi to
 spi-mem framework
Message-ID: <20200619105701.GD5396@sirena.org.uk>
References: <20200601070444.16923-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20200601070444.16923-1-vigneshr@ti.com>
X-Cookie: Robot, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2020 at 12:34:36PM +0530, Vignesh Raghavendra wrote:
> This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
> support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
> cadence-quadspi driver to spi-mem framework

Are people OK with me applying this to the SPI tree?

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7smf0ACgkQJNaLcl1U
h9AJCgf9FonwA/DZUb07wl0aFcbJGqHii8lawwyZEGqOYL9qHfuLpnXAowrmNewt
n5DwzQvxqRYNCIDJNb5+i81koko+UC2YsJWgqEZ4OkHVDVJeacnW2/YSHsZPTmHl
cko1Yi3YzBEe2+dGfAQBeToMgvhB8A4x336ktfToVGKYHLPTb9kyVr7x9+uxuK5G
cViQa7wLizddnx+U6RoMR26d0Ak8dw02Ckm8isA9wsJghbgczA1zWhtxXWlzvN9D
fPZduLohNH5Im33OnwHwJdp6o1eVoXYzPMkSco8bUW4BOBPQ3RZyhwPOyjdV+gzk
eZUVhlqqPIsCpspvPVSQ3uiCxe2Gyg==
=OeKp
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
