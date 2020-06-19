Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F385200F75
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgFSPRw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 11:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392555AbgFSPRt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86344218AC;
        Fri, 19 Jun 2020 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579869;
        bh=UEOOXWngWN83R5j4Pi/o/Dcm/fqzKyyBB3Vt398Ofeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXN+mD5PP3w4cOHhOURB1wp6S0pItj9Lv2MtK4xP8u/KcD/DeA76FrZ4Xux1jUVHZ
         7bs8c8lFp4lWayAEscM4naiGN3Cm1p8hOLJwYUkKANHvLXbN09AauMtq+P7o7yoBGc
         1WPUPT+rPAVWsTNqLXp2J01bb9664fCb8LEq4G8o=
Date:   Fri, 19 Jun 2020 16:17:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, bbrezillon@kernel.org,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
Subject: Re: [RESEND PATCH v3 0/8] mtd: spi-nor: Move cadence-qaudspi to
 spi-mem framework
Message-ID: <20200619151746.GF5396@sirena.org.uk>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200619105701.GD5396@sirena.org.uk>
 <0007c019-1ecf-1913-56a7-facffe345b1f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <0007c019-1ecf-1913-56a7-facffe345b1f@microchip.com>
X-Cookie: Robot, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 19, 2020 at 11:47:08AM +0000, Tudor.Ambarus@microchip.com wrote:

> Would you please provide an immutable tag on top of v5.8-rc1 so that I
> can merge back in spi-nor/next?

Here you go:

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/cadence-mtd-spi-move

for you to fetch changes up to 31fb632b5d43ca16713095b3a4fe17e3d7331e28:

  spi: Move cadence-quadspi driver to drivers/spi/ (2020-06-19 14:26:54 +0100)

----------------------------------------------------------------
mtd/spi: Move the cadence-quadspi driver to spi-mem

----------------------------------------------------------------
Ramuthevar Vadivel Murugan (2):
      mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
      spi: Move cadence-quadspi driver to drivers/spi/

Vignesh Raghavendra (6):
      mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
      mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
      mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel
      mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path

 drivers/mtd/spi-nor/controllers/Kconfig            |  11 -
 drivers/mtd/spi-nor/controllers/Makefile           |   1 -
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 .../spi-cadence-quadspi.c}                         | 541 ++++++++-------------
 5 files changed, 222 insertions(+), 343 deletions(-)
 rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (74%)

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7s1xkACgkQJNaLcl1U
h9CkZwf/bn/NzkeSHpXBj+R11qSg1PNvnUXgrdmG3O2NoZyp3uimOHDbJOXGe/4Z
9V4XQpiJRI1PPz+7mEQbbKev+mGBt4mVuZ3TlTYn9w5omw33LJhBjnTdwgA/Ik3j
uAHE2kytqegcm30R27bLC5kiNQYT8RKm8MqkgYxwrUREapBGPHJ3LASu1c9mBjns
2FFv7w8YpjzK0cGCE8h/PGT/kPGvnkatMOs5sOXCXfCan3ZQ9F++d6hquYRAhYEG
T1D+GSJJAYOL0pJ2/B39g7ha+EILEhh9P9pNcKw68IM9NdbDMYjE0MJrJ4oj1q4f
JuLI56TLnG1VpcXzRvUAbHgsIkfL4w==
=VBZQ
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
