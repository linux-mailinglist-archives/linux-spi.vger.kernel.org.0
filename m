Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6021FD2E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgGNTT5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 15:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgGNTT5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 15:19:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164902255F;
        Tue, 14 Jul 2020 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594754396;
        bh=pdt+ZEgfcDRHiUJp80sY+Xk7V9Swgajn9kAukK7kVoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZ51r8Iqlc54vZBYnsf0GzJRD/OcPD+7owGHrdIuH29eXK0ZbmN1wo77NO0QOdTtC
         8OaMdI9+n0ZXkHcNykgmpmRdZOYF2sHbjijkAUMgCqEtV1EIzgsjCdaefnN7XGJWdJ
         DvS357O/aozzO/GnIN4UXDV2fcezXUuzGOPeSInU=
Date:   Tue, 14 Jul 2020 20:19:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        boris.brezillon@collabora.com, miquel.raynal@bootlin.com,
        richard@nod.at, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        matthias.bgg@gmail.com, michal.simek@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, nsekhar@ti.com
Subject: Re: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200714191947.GI4900@sirena.org.uk>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <e6d4c015-b70f-40e3-2275-89d245e817e8@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline
In-Reply-To: <e6d4c015-b70f-40e3-2275-89d245e817e8@microchip.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2020 at 06:34:12AM +0000, Tudor.Ambarus@microchip.com wrote:

> These four patches are looking good, I had just few minor comments.
> If you too think that they are ok, would you take them through the
> SPI tree? If so, I would need an immutable tag on top of v5.8-rc1
> preferably, so I can merge them back to SPI NOR and continue the
> development on top of them.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mem-dtr

for you to fetch changes up to 4728f073bfc66b8b555274ef0d7741d7f5a48947:

  spi: spi-mtk-nor: reject DTR ops (2020-07-14 17:29:40 +0100)

----------------------------------------------------------------
spi: Support for DTR ops

----------------------------------------------------------------
Pratyush Yadav (4):
      spi: spi-mem: allow specifying whether an op is DTR or not
      spi: spi-mem: allow specifying a command's extension
      spi: atmel-quadspi: reject DTR ops
      spi: spi-mtk-nor: reject DTR ops

 drivers/spi/atmel-quadspi.c |  6 ++++++
 drivers/spi/spi-mem.c       | 16 ++++++++++------
 drivers/spi/spi-mtk-nor.c   | 10 ++++++++--
 drivers/spi/spi-mxic.c      |  3 ++-
 drivers/spi/spi-zynq-qspi.c | 11 ++++++-----
 include/linux/spi/spi-mem.h | 14 +++++++++++++-
 6 files changed, 45 insertions(+), 15 deletions(-)

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8OBVIACgkQJNaLcl1U
h9Bhygf9H+xpfxdxH22PtaRszzUoz4qNi2lr2fwNL/Z5+6EnJ6gCQCiu1AjHVWsc
o0MZPls5hAEkyvp0c+Nu6z/NXHK0HIN6KuQxPbGvGCQFPuD981uFwbKlLV1hZqbG
mQDJjTyRB9TMpBEYvUNxRpNPk+QLY0XMz1H5D0/YkRXS+TzuFtqggvLmLuaI7uri
rurYlk8YAf4YZHjVRQoKu+vX+UbSSErglMvy6lDYTKN3d54vzt6iLsusghfv/G93
t8CkM3J8QCRk1o71zrxtRBeol3xkYWKowJV1kSx3zHxyQCCzcbHcWab2QLt/qSK9
FtqJVxO5UeujOgLPZXygGjBYygkqTw==
=fMw1
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
