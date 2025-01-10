Return-Path: <linux-spi+bounces-6309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B2A09455
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC5B18881A6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C121147A;
	Fri, 10 Jan 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLi8UcH9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2384211464;
	Fri, 10 Jan 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520761; cv=none; b=dzw8daPMki79fhnxcou9Tl9oJg/twaselpayOCvreds62WTpSsosxEgHOSSLFt1yHO9YEscnFMtCCUlfc4wj3CU4F7mj3Sf+FFKEUUKnBF1+1rPvIuNGrkv6gWrtck7yZJiN2vN4O3GbwzJwt16EPW1jNP5Q0d32ViJItz7KS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520761; c=relaxed/simple;
	bh=aNCFEV4RXYP85CjPd7vNqTGzYYPEBIBQoTBIen40yHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx5OSmaDFlpKZBpEkpGl5dvVH1P3/q6IZJ6P+zoUpGrqBcQ4MJKaQztBvWwPJ5eV4UVQzisYSUMbBZtLVKvJRmOTnNEhsz8N/NCHOOKmdB5zWO5EVxO4x6SwOYGbNmtQZZWsPi8MhQtjySEaIGwLXfagzGInHRIrfjgtoVWa8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLi8UcH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C0AC4CED6;
	Fri, 10 Jan 2025 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520760;
	bh=aNCFEV4RXYP85CjPd7vNqTGzYYPEBIBQoTBIen40yHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLi8UcH9DGe79azEcqPclXToIx5qw10enSJS5mjJaQRBBZ+5CLBrfh7Mpi7iMW0TO
	 A/rbMrNTS+PA9NpBPcVMM2z4ku1oxppk3W6llOIBhZvOuDHhGVRljWiAOR1U+h7yFg
	 tOqGBw0ZgHBSqZRgs8RWqGihl1fJ89d10Xtujow1iFSpmcSQgrYpctK/HiN6tIbDI+
	 n5yG5j4ZixygYt6rjBddVkMwyc9Hf5TbHnNKtMpk9hIBLXmn5EBUF3ghvXFuOE1FRu
	 mrmh66XV3EANLgY1TKzwxSp7POGpX7PmaPlVbxRNm2IDDx7avzqsmJ+qIFj+4ZvpJn
	 l1C5E9zSehWHg==
Date: Fri, 10 Jan 2025 14:52:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
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
Message-ID: <c9043531-c733-4153-a814-79aab387883e@sirena.org.uk>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
 <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
 <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
 <87tta6ag5b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5dtr3CwiZ2FNoyO"
Content-Disposition: inline
In-Reply-To: <87tta6ag5b.fsf@bootlin.com>
X-Cookie: RELATIVES!!


--D5dtr3CwiZ2FNoyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 03:37:52PM +0100, Miquel Raynal wrote:
> On 10/01/2025 at 12:42:47 GMT, Mark Brown <broonie@kernel.org> wrote:

> > This breaks the build:

> > /build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting type=
s for =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct =
spi_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_=
op *)=E2=80=99}
> >   580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)

> Crap, that's a fixup that landed in the wrong commit (mtd: spinand:
> Enhance the logic when picking a variant). I'll fix it.

Please only resend that patch - the rest builds and tests fine in my CI,
I'm just checking a merge fixup.

--D5dtr3CwiZ2FNoyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeBNC0ACgkQJNaLcl1U
h9DAqAf/Qrz25ymjeY3vF9YJzCAUUyBS18sTyjX0LHFtT3TgKFe5BYRlKvM8thbH
laiQ60LjJlTDfHpTNzluTCzAgMXm72nOcj/jI4aNjM++Vr/I/xwvVZWbnIH6eZXN
/6oik+AWx+8+dkg/KM9xeJmz1c7efDMcu1KPjM4jv1cuGHe/SMAy0HroYpo6o1+d
WMMbRDqbjT+aZF/9ZnqhOxl1+UaPqyhWYWMlmrT0HbsD+DGGfSXjiPKYVe3+gv7s
n3Oxrkni3O74YgOIN1Tg924Beg9+V7xFVjC+xdzZ0l/uY22fPkMHM+lVFwz9Qy0r
ZmvCpIfRn+q++xWYtiLBpITHKteMvw==
=Dk/0
-----END PGP SIGNATURE-----

--D5dtr3CwiZ2FNoyO--

