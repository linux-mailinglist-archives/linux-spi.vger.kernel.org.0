Return-Path: <linux-spi+bounces-6352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03BA10A88
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 16:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547F57A17E2
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3B154BFF;
	Tue, 14 Jan 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu/9pFaj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33014A4CC;
	Tue, 14 Jan 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867884; cv=none; b=iDmCsC5pGhsW/YxF88plxBNdl+NqexCKwQmpPMz65lkWzvFGbdpAc3tYlKV+d3vUQ03vSVk+KCwYw8NEMdbXuVtHY2HrHG3ORQbfuKbAkWczVwht2eydyIWVIFclVZAEI+dprE0umPPd4C3bd/h75AtOS8q3S4cdayJPbGvloqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867884; c=relaxed/simple;
	bh=dV7A7VJAGHTtWu/S7xXcA8BcPXYKQZhkeq6pa2Goexo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOUPPQ7RDHbHH+/Ev3JKtgqshprbxfsKsDorDgTUvQ7qN5U7bF5RWL9wsC4rYsOPWyVUIxEVrRzT5QbIWzOG4WM3RITgJz4a4/t9pCfssjD+xaYoO9LclWRYuVe3BwyjzaeE1aNe39PcpAYUeH81EbrA2WO24hD+iw8HkiXcyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu/9pFaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57A0C4CEDD;
	Tue, 14 Jan 2025 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736867883;
	bh=dV7A7VJAGHTtWu/S7xXcA8BcPXYKQZhkeq6pa2Goexo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu/9pFajRI6OFPR54X4zaadjDYvXKGcbBr2W4xsyhguKlnfoKTEmPNdwyaBr1UTQ/
	 BtH4x/U02Z7Epjan3mU/bHnJuWVacAFguzj0zJSwUsyKKJuY5aCbVmue1P11XFZHlq
	 fneGg5/K5f1ggjMgGxadtKdQoMP5EvqfNW7mghGMh1GHjFsKhpLEBQaU0BoSY9WWTo
	 Kx0edjfHEIel0E8oqTP12sOx2vjs41z7nkJCu4jaXh+Xw2VdEP0NBtnRvqoyowxmWr
	 9uqwaCWzedp1RFXZFCgpVs+quvcpcUJ5VMcNPSx+G63H21mmluXVOF0JbOi2UPmd6s
	 YGuCHLm2kLNpw==
Date: Tue, 14 Jan 2025 15:17:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-spi@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
Message-ID: <a20383dd-57cc-4c0d-8bab-09a9260f2378@sirena.org.uk>
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
 <173678670956.71125.2320310623665812760.b4-ty@kernel.org>
 <87h661u2z9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2iPXVcBfzc1mAQZJ"
Content-Disposition: inline
In-Reply-To: <87h661u2z9.fsf@bootlin.com>
X-Cookie: Sauron is alive in Argentina!


--2iPXVcBfzc1mAQZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2025 at 11:03:22AM +0100, Miquel Raynal wrote:
> On 13/01/2025 at 16:45:09 GMT, Mark Brown <broonie@kernel.org> wrote:

> > Applied to

> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

> > Thanks!

> I'm wondering whether it's relevant to pull the branch you shared
> as-is. Do you plan on pushing this patch of top of it? Or shall I wait
> -rc1 for the SPI NAND part?

Well, it's not a branch but rather a tag which complicates matters a
bit.  I could cherry pick the patch over and make a new tag I guess?  Or
you could just not do allmodconfig builds with clang?

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mem-dtr-2

for you to fetch changes up to e896c04890aeff2292364c19632fc15d890d436c:

  spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op() (2025-01-14 15:07:11 +0000)

----------------------------------------------------------------
spi: Support DTR in spi-mem

Changes to support DTR with spi-mem.

----------------------------------------------------------------
Miquel Raynal (20):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
      spi: spi-mem: Add a new controller capability
      spi: amd: Support per spi-mem operation frequency switches
      spi: amd: Drop redundant check
      spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
      spi: cadence-qspi: Support per spi-mem operation frequency switches
      spi: dw: Support per spi-mem operation frequency switches
      spi: fsl-qspi: Support per spi-mem operation frequency switches
      spi: microchip-core-qspi: Support per spi-mem operation frequency switches
      spi: mt65xx: Support per spi-mem operation frequency switches
      spi: mxic: Support per spi-mem operation frequency switches
      spi: nxp-fspi: Support per spi-mem operation frequency switches
      spi: rockchip-sfc: Support per spi-mem operation frequency switches
      spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
      spi: spi-ti-qspi: Support per spi-mem operation frequency switches
      spi: zynq-qspi: Support per spi-mem operation frequency switches
      spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
      spi: spi-mem: Reorder spi-mem macro assignments
      spi: spi-mem: Create macros for DTR operation
      spi: spi-mem: Estimate the time taken by operations

Nathan Chancellor (1):
      spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()

 drivers/mtd/nand/spi/core.c           |  2 ++
 drivers/spi/spi-amd.c                 | 26 +++++++-------
 drivers/spi/spi-amlogic-spifc-a1.c    |  7 +++-
 drivers/spi/spi-cadence-quadspi.c     |  3 +-
 drivers/spi/spi-dw-core.c             | 10 ++++--
 drivers/spi/spi-fsl-qspi.c            | 12 +++++--
 drivers/spi/spi-mem.c                 | 64 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-microchip-core-qspi.c | 26 +++++++++++---
 drivers/spi/spi-mt65xx.c              |  7 +++-
 drivers/spi/spi-mxic.c                |  3 +-
 drivers/spi/spi-nxp-fspi.c            | 12 +++++--
 drivers/spi/spi-rockchip-sfc.c        | 11 ++++--
 drivers/spi/spi-sn-f-ospi.c           |  8 +++--
 drivers/spi/spi-ti-qspi.c             |  7 +++-
 drivers/spi/spi-zynq-qspi.c           | 13 +++++--
 drivers/spi/spi-zynqmp-gqspi.c        | 13 ++++---
 include/linux/spi/spi-mem.h           | 56 +++++++++++++++++++++++++++++-
 17 files changed, 237 insertions(+), 43 deletions(-)

--2iPXVcBfzc1mAQZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeGgCYACgkQJNaLcl1U
h9C5Dgf/RQhmGbs3CM6H/hRKhwFsGtKWssBC2kOLN+PiUG1tXi0R4xXhhCG1YZ+I
mmbh18x03b5AkS7mgA7/Hv3cBlWU20+9Lbum30vy3m/6tv65PbMRKhJP7Wp8fVZ4
peAWt9t/DOgczBGOKn1hOmdK0DKl5Ud53TcrLs8Euo21rg0fwPYzTomir2KOCSSw
eR3zY6WsfdKAvS+jx0sbRJc3QoI92Lt5vOilGl4nTf2YG7aXt4kYryWg9srWJ3bp
dID0aBfHHIxncNmQFigJhaxoG70pMR35LG3ZeN4FTwzyEVyg1/nP4yGYDG5MFyfA
FLHg1nVdJ8hdV+MnnPPsYH4aGXTdCQ==
=4HD+
-----END PGP SIGNATURE-----

--2iPXVcBfzc1mAQZJ--

