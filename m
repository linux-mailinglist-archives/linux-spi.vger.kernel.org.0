Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0E38966F
	for <lists+linux-spi@lfdr.de>; Wed, 19 May 2021 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhESTUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 May 2021 15:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhESTUm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 May 2021 15:20:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CC79610E9;
        Wed, 19 May 2021 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621451961;
        bh=CxcjeXZphMX8ikSAW2LO8uJN2ihmCuUCEEwRVbN9D64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSd5m9KJyLTnId6P36+q7OP6uzbpi1F5D6EjClmCZnsqr8IO1MPqHe6OIIuMT4KGT
         KpPRqvNevSsYV1A/VFjEbTG9aBAu4AylNczwHnCAHhA/k4JnCp7So1ZmFCXohu1lvU
         XlHrJjrcjUpc3+2mhqHYkOUYmeMp5diczczM+DBI+QETaguAEYOEKbwvDXc/B4xaB4
         7Lgvww82oDmgsrLZSLWdAwznDoGFvZKODayku9Sa6lAjHcIHgRlTKm6y71fV3fENQr
         nbCW4brWMJRvJGz0vUwTWhYYvI3udKVUio3bOjzYPGXS43xQKRkEle0LyWPN6j4P+f
         9sErHwMiDcYow==
Date:   Wed, 19 May 2021 20:18:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v5 0/3] MTD: spinand: Add spi_mem_poll_status() support
Message-ID: <20210519191836.GH4224@sirena.org.uk>
References: <20210518162754.15940-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <20210518162754.15940-1-patrice.chotard@foss.st.com>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2021 at 06:27:51PM +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> This series adds support for the spi_mem_poll_status() spinand
> interface.
> Some QSPI controllers allows to poll automatically memory=20
> status during operations (erase, read or write). This allows to=20
> offload the CPU for this task.
> STM32 QSPI is supporting this feature, driver update are also
> part of this series.

The SPI bits look good to me - should we merge via MTD or SPI?

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmClZIsACgkQJNaLcl1U
h9DUugf+L02+HoVRB3gbN5ZpyjjoHmHs9up8UEcNStI4z5NEGfSDlLbFbODRNFlP
E3sFR+ORhCM9vziPNYxXzkt6iqlVMmxNDyKntLntzno7g3v37ycpdpo1EVfRqCst
Zgi7FauC4EhvCQcWdh4MZZJw27U8T/zhoGNK8X8J6+eZkz/TWfTPZETa7C/p31pB
F3+Z8Nfd6EFKMJ++dJLmjgDpQPkcUV8xdiQIqKAAQFp8GTWNk5bKk3rZvA35VNcm
ERAEJyYhESA4iIBzVQMTdsZp1mPZUW2zOWTMgYuqsha766iYTz1DcM3tCwtPs/4I
1F+iui8vnadvaJxuv0ckWb+cZpfCGA==
=WZaQ
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
