Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A131DD32B
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgEUQkB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 12:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgEUQkA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 12:40:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B5D2072C;
        Thu, 21 May 2020 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590079200;
        bh=AfI9fmUuFN9xXeTYe0PWSZoP2kgFN0oEZnj47UWorQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxuSU3uZYzpRLRdfe6Rz7HLoMY3bYg9op1wwP4N0PdBGZPEFoO/2RdlRUJkMufXCN
         k+uSn09pgwURuO7SDRb3U6qQ8aMF1Yb9d5sweGPvl86oLvc98dLElPyf6p82Wjnwr/
         do5Lo8UULK6bwoTOnwcV2rAUBlsuroCTbYwvqnMk=
Date:   Thu, 21 May 2020 17:39:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v6 00/19] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200521163957.GG4770@sirena.org.uk>
References: <20200520163053.24357-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <20200520163053.24357-1-p.yadav@ti.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 10:00:34PM +0530, Pratyush Yadav wrote:
> Hi,
>=20
> This series adds support for octal DTR flashes in the spi-nor framework,
> and then adds hooks for the Cypress Semper and Mircom Xcella flashes to
> allow running them in octal DTR mode. This series assumes that the flash
> is handed to the kernel in Legacy SPI mode.

Are people happy with the SPI bits of this from a MTD point of view?  I
don't have any concerns and could apply them on a branch even if more
revisions are needed for the MTD side.

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Grt0ACgkQJNaLcl1U
h9D1OQgAhiDwTKnfU5U/brtlpuvixDO+Q0C2aTYod9BlC6/J0LiO/hDJeEvk37Pr
hAyYy3T36TEfkovmaLsQTTthWIkmvU+GhZhOmBUpGTPsINXBUDCM5oIV7D8k7axY
okkAhFALSCWJk9KSkaYyQAKXH1JdAAh+3kodj4zU+jGaa9NOpsjJmIapIQ+9/iTn
48Rn8Du87lLkYGQkA13k7sdi4sghM/8Nx3fvjPgEG9K65J+DE2nds2v5mrD0HPDx
G+4+54Z0N9/QT4ZVebUEb4fMuBRlB0tpMnaQhd/ll/VJ7XNppMBtKhlMeV7TUF/+
z9wWlZEKa3CYCCbQdluJq1GlHlhAIg==
=fkrh
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
