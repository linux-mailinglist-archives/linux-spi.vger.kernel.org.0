Return-Path: <linux-spi+bounces-6279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F8A0910D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4893AA610
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBBD20551A;
	Fri, 10 Jan 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpD0sW7U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B284A1A;
	Fri, 10 Jan 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512978; cv=none; b=Toy9QiKsAEURI8u7oW0bN8RblYmX1yxmFKAIVXhedZXldXPnnTBHvktBPrn+oGFkUCCBc8VrZpX3//mlk+F81+nwSwwbEj5koFvsRYDIibL4svV2IlQFGYhKIvMFQeuvPb8Wimu1+NTByc6OMUVDy98GOP0RciJlkfbe2XRalqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512978; c=relaxed/simple;
	bh=jQisMlTjYfeo02yHCaf8/3pDTMXN8QMfrZ/MAhEXiCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqPVodjHZvwWppQk3N8sXjNwvj8I+ZvRP5AzAwZ2irtpmFbG6fRHRjPIZC8eT9TLAU89xcNfxUzKO4U6EtuufksJej661wl9tLgsa+ILYZMdU7voIZ/cGQ4BOwzPoAzrtpp0rJgYJJBpv4wvxtRjglSZgM84+cHjIqJEz54dWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpD0sW7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0816AC4CEDD;
	Fri, 10 Jan 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736512977;
	bh=jQisMlTjYfeo02yHCaf8/3pDTMXN8QMfrZ/MAhEXiCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpD0sW7UIABuucxd/Qx8pWVveKRBTPjoee4MF0KjKw8i5YDBoDzL5JYvu4BaELO0t
	 M/U8H/SXs0PIabw+VP/Wmcv2zkse9maGzd/9rSoZgJ6hC/Lu3TEGJ9VrLXjmmeRFg1
	 vFZp71KV7rVxbfsUrwau0sxqutt53V+fSRgOWgFQTeVLDgWzOazdvg68BZ9FapN4Et
	 JWbE4PuKzWFwlzYvCA+Uzkc1/eq5V73FfErBUEePlT0QeeVOCwHPXy/saY0DV/C3w1
	 EubDaTDdWlxizzmd69Sr4YfE+GSogwgowB31K0GFRmk2/goQYinjInn1BjN5IFfOdI
	 Cy3tqd/O7Qjaw==
Date: Fri, 10 Jan 2025 12:42:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,
	Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 20/27] spi: spi-mem: Estimate the time taken by
 operations
Message-ID: <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
 <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RVMhmV/ewGAzdaKp"
Content-Disposition: inline
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
X-Cookie: Many are cold, but few are frozen.


--RVMhmV/ewGAzdaKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 06:06:05PM +0100, Miquel Raynal wrote:
> In the SPI-NAND layer, we currently make list of operation variants from
> the fastest one to the slowest and there is a bit of logic in the core
> to go over them and pick the first one that is supported by the
> controller, ie. the fastest one among the supported ops.

This breaks the build:

/build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting types fo=
r =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct spi_=
mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op *=
)=E2=80=99}
  580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/drivers/spi/spi-mem.c:12:
/build/stage/linux/include/linux/spi/spi-mem.h:427:5: note: previous declar=
ation of =E2=80=98spi_mem_calc_op_duration=E2=80=99 with type =E2=80=98u64(=
struct spi_mem *, struct spi_mem_op *)=E2=80=99 {aka =E2=80=98long long uns=
igned int(struct spi_mem *, struct spi_mem_op *)=E2=80=99}
  427 | u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op=
 *op);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/linux/linkage.h:7,
                 from /build/stage/linux/arch/arm/include/asm/bug.h:5,
                 from /build/stage/linux/include/linux/bug.h:5,
                 from /build/stage/linux/include/linux/thread_info.h:13,
                 from /build/stage/linux/include/linux/sched.h:14,
                 from /build/stage/linux/include/linux/ratelimit.h:6,
                 from /build/stage/linux/include/linux/dev_printk.h:16,
                 from /build/stage/linux/include/linux/device.h:15,
                 from /build/stage/linux/include/linux/dmaengine.h:8,
                 from /build/stage/linux/drivers/spi/spi-mem.c:8:
/build/stage/linux/drivers/spi/spi-mem.c:593:19: error: conflicting types f=
or =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct spi=
_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op =
*)=E2=80=99}
  593 | EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/include/linux/export.h:56:28: note: in definition of mac=
ro =E2=80=98__EXPORT_SYMBOL=E2=80=99
   56 |         extern typeof(sym) sym;                                 \
      |                            ^~~
/build/stage/linux/include/linux/export.h:69:41: note: in expansion of macr=
o =E2=80=98_EXPORT_SYMBOL=E2=80=99
   69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
      |                                         ^~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-mem.c:593:1: note: in expansion of macro=
 =E2=80=98EXPORT_SYMBOL_GPL=E2=80=99
  593 | EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
      | ^~~~~~~~~~~~~~~~~
/build/stage/linux/include/linux/spi/spi-mem.h:427:5: note: previous declar=
ation of =E2=80=98spi_mem_calc_op_duration=E2=80=99 with type =E2=80=98u64(=
struct spi_mem *, struct spi_mem_op *)=E2=80=99 {aka =E2=80=98long long uns=
igned int(struct spi_mem *, struct spi_mem_op *)=E2=80=99}
  427 | u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op=
 *op);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~

--RVMhmV/ewGAzdaKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeBFcYACgkQJNaLcl1U
h9BhIgf+KXE1JExJo+WBN7mYcyQ4HitVxI+rVexdbI+QMmjPpB2umRebJU2u0F2O
zJlk5R6eGXdOn3H83H0CacUm11VVNZmqP1yUSytO4sjiyHdh7Zp70UkidrhA0O9F
pRM9l9bBbWV3FzLgZCYjZ03y6A+A9CrIsGRVAuX/rAUHENGshIN+Wa1j4ZwRkI+u
Nid4YWfQkB1UjSFhcx6d9iDq65hTlrHDn5ThFmIDGZCTS8NRcUAevtkdwoU9thC7
1xTCkJ92ejUGQ3TTzVrlg6qsnSJTAARPhDZ8WasEfN+L/LWyRI181QAMRKG4oOOi
swVXAClyqCX9avFjDoBP8aArkjRb4A==
=qXZ3
-----END PGP SIGNATURE-----

--RVMhmV/ewGAzdaKp--

