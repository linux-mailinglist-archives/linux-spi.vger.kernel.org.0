Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C288476187
	for <lists+linux-spi@lfdr.de>; Wed, 15 Dec 2021 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhLOTTT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Dec 2021 14:19:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42584 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbhLOTTS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Dec 2021 14:19:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A08161A6A
        for <linux-spi@vger.kernel.org>; Wed, 15 Dec 2021 19:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E50C36AE4;
        Wed, 15 Dec 2021 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595957;
        bh=5JU7ynWQzzR4euZy14PY1jKmBHmiP38yte9RLHc3U0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QI6cAF9XiyocUYPSIBT8YDYNpoQDscNgFvdpK1dVF2LIbp0O0uRwawUsa3i420Xlf
         F/1MMhDdJEFaTecRfrb3+AlYlm3UYPCwpOr/MZLIZTgERE/+64jR8KP7/H44VnoEGM
         dSYVZNqfRH4vuM0X+LNn2E2vGA0U1ocF6CeAQZVP5Na1nwXjlgHwgb3+SU8KXYlzfY
         3c2Rt9srtPTiTHmt5BhOeksIN2DKogqndMaGYFzS1ar2RVVOi36k7kI7SlV2Gjd9ez
         XZTlwdf4NtcsygZKRQ+iC2Zsnoioi/yh+APMSq13Bf/jXplNVM/wAgu9k7qP652BF0
         j1hKTw+qC+HlA==
Date:   Wed, 15 Dec 2021 19:19:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <Ybo/r8neydqTxN6N@sirena.org.uk>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
 <20211214114140.54629-13-miquel.raynal@bootlin.com>
 <20211214172410.2b26c17e@collabora.com>
 <20211215184426.67fd3912@xps13>
 <20211215200548.75630b61@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x0lCV/3SpWhllQQZ"
Content-Disposition: inline
In-Reply-To: <20211215200548.75630b61@collabora.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x0lCV/3SpWhllQQZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 15, 2021 at 08:05:48PM +0100, Boris Brezillon wrote:

> There's also a second option that doesn't involve patching existing
> users: add a spi_mem_controller_caps to the spi_controller struct, and
> check this instance in your spi_mem_default_supports_op()
> implementation. Note that the buswidth check done in the generic
> helper is already based on caps exposed by the controller
> through spi_controller.mode_bits ({RX/TX}_{DUAL,QUAD,OCTAL} bits).

This approach is quite nice for things like this - having things as data
rather than code.  The only issue is if any of the caps end up varying
by operation and we need different capabilities but that doesn't look
too likely here I think?

--x0lCV/3SpWhllQQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG6P64ACgkQJNaLcl1U
h9DQLQf9FKkMlv6u0xrj+isJyQzPPc8PCpMYhHnjjIR0DpEH+nlecLFLQqJCVtM8
w015gZThnnB0eHh+go1jistjbjkZ8bm4EPVCOHOP80BNTvMDwRXzO9+/SADjg/KQ
UebYewRoVLdpiITf+t/7xOOc7Pjei7o/lhQCLcMZBkDlTwzeubP3GGA/u9n/96Yk
5GGa++iBBk4KVMs78192QHYUsOlMewb+GBJPBz8P67xJPT6wnnQ+8tEmA3GmYGsL
DGUiSXp6EfGzk9l68+S1K3qhd9a0qHoK+4hZgZJFi5l9B1bWvFF68n84L0hG/3at
PUc84bNPkCPi12NwekBA+hR/wNBr3Q==
=SHzq
-----END PGP SIGNATURE-----

--x0lCV/3SpWhllQQZ--
