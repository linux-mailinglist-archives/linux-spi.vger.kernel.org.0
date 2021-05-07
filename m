Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599853765A3
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhEGM5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 08:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234398AbhEGM5L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 08:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E43D6145D;
        Fri,  7 May 2021 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620392171;
        bh=y32fV8IFsyNahCaWCck8Bgsb71MrZYwbNZlgtBX60W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIdbOw5mDlCaJq1WudfCM96/pMNiqnxJI0g3Y7ecuhXwxekGLGwhhPFiETS7smMia
         oAYKfCnDnK2zLIqSMWwoAl2nAmvC2iHkVwmbEBf8NQeWNNtKnPEQKQ8fuPiiQc0NsK
         NchlyUHjMTDhy3Ujt+ANC/3tMnpv98l1BkU2wSAdXowwjhSH1+KPBkR2zyMQ7FyJ0R
         RzPUgqtW8DMteVCpZb/lX1Jxj1B8p4fvA5zIXoyd0uOkRi9RLp50KzQQIKD43UY1LG
         AlE/2ODqzBT/3aTDKjkGXyRcWBjaIIhj83Acik+3IJBv9LhLIGeNbroSdhNSPipNUn
         DEIKilL/ZyyGA==
Date:   Fri, 7 May 2021 13:55:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Message-ID: <20210507125533.GA6383@sirena.org.uk>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20210506191829.8271-5-p.yadav@ti.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 12:48:27AM +0530, Pratyush Yadav wrote:
> In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> of bytes cannot be transferred because it would leave a residual half
> cycle at the end. Consider such a transfer invalid and reject it.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>=20
> ---
> This patch should go through the SPI tree but I have included it in this
> series because if it goes in before patches 1-3, Micron MT35XU and
> Cypress S28HS flashes will stop working correctly.

It seems like this should probably even go in as a fix even if nothing
is broken with mainline right now, it's the sort of thing some out of
tree patch could easily trigger.  Unless anyone objects I'll do that.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVOMQACgkQJNaLcl1U
h9C9uQf9F7iIYJsr5r7vlcQFtN6JRxQBAT7SQrYpZGKtFrmxVr0ct5rCpwPxCDm6
TihuJQd9vVim/gn+GfjZvLLrbgf+QpDE8dR8l3kcUFqDBbG2LpxNBkAKvrDhc0O6
jX89AjpNdoI772ZaEFXSyexyN8jOLn3dZoWX+G+fVGaIpbbYDDn+T3CC1TPPs3hG
05o0WvEsUF/Sdl4O2GoqV7EeLIoa7ViZuhzGyzMFTGMyPvjte3ZK6lne164UZGax
lSnLoTCki6lRxiqhwsfuCRsH9VA3U9rZvAR0Slly7EkmDhkgQDgR4AkKZwK7wB9X
fTQrLj2BgqbZWIkih68wRH9AxHo6ig==
=YstS
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
