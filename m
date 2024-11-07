Return-Path: <linux-spi+bounces-5648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093309C0CA9
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC6F1C23F63
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779232161FA;
	Thu,  7 Nov 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKTWxS50"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A6216443
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999711; cv=none; b=NtSP6oej/8r7hCUAajqURPGCPYEttjxBHYAjyB6YLGW5dx03CtnHRwNMLnjGd4RmnH3TdPMj7EaGnpDAEMNB810WsFJQr0PUHnFw/Vf4dwB+jV3ASRXhFVaEWSfEcjpOpOImpm5dpgkKvHFJa93ixNYrULJKPMT5gp59KEKIXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999711; c=relaxed/simple;
	bh=paankYmJQRECpd98G1Q22WUKvs4Rk7C3en/qFTL5HTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdBCVbgUNTlIc2MdnQ6B5Ju55/zPFXwM2d/E0QQpmTOK7zluYOYcDSy+b0yx+e4eNZ1AoMCK85zbtaY88rA5FVwhocSgW6VKOKXtDAfqexHfUyZj8KfFoWNDji2GFZK2UPRzk/esEdkb/zQaR7DfqydVavvqtVJY3/b+IX2Bu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKTWxS50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0E5C4CECC;
	Thu,  7 Nov 2024 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730999710;
	bh=paankYmJQRECpd98G1Q22WUKvs4Rk7C3en/qFTL5HTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKTWxS50PRtubCn66KXYYV/EqQuwSQCBXvQGToBnx7lAaVTps6KiAZoEKvMsXa06h
	 sj/gSJvCNtMSVTzm84g3Th1DQlg43FxI+kZoRxdrRNYdirD9BmoS6jsiHhwNLtr12m
	 +s5G6xfgqVsLfT1dWSEST7JI0kPp5ZD/8E7c+tCggKE6w5Z9NQYX61pZS7Zms8IeE/
	 inpKeo4QEz0/0/Uae98vrtS6VDOgZrkTuybIwrA1gywfra+RMDMD1OAqd6BLDVV+Rt
	 WRbP0oQKD1yvSsn/FrlZqD4sF4PZGkHlMUSt0+7nRZjC3gLWCt5JB91C9X6l2+LZhp
	 Y4XlEr+nBtZmA==
Date: Thu, 7 Nov 2024 17:15:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org, Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/24] spi: spi-mem: Add a new controller capability
Message-ID: <f0ea6706-17a2-4500-b426-a53c836c52b8@sirena.org.uk>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-3-miquel.raynal@bootlin.com>
 <586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk>
 <871pznqqdb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7aoKoHXbg0c1jiz1"
Content-Disposition: inline
In-Reply-To: <871pznqqdb.fsf@bootlin.com>
X-Cookie: Professional driver on closed track.


--7aoKoHXbg0c1jiz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 11:40:00AM +0100, Miquel Raynal wrote:
> On 01/11/2024 at 20:17:33 GMT, Mark Brown <broonie@kernel.org> wrote:

> > After applying this patch (I bisected the series) my Avenger96 board
> > started failing to probe the SPI NOR flash it has:

> > [    3.567876] spi-nor spi0.0: probe with driver spi-nor failed with
> > error -95

> Would you mind testing the series with this change on top and tell me if
> that fixes it?
>=20
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -184,7 +184,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>                         return false;
>         }
> =20
> -       if (op->max_freq < mem->spi->max_speed_hz) {
> +       if (op->max_freq && op->max_freq < mem->spi->max_speed_hz) {
>                 if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
>                         return false;
>         }

Yes, that seems to have been the issue.

--7aoKoHXbg0c1jiz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcs9ZYACgkQJNaLcl1U
h9BanQf/VDGt8OfnUN5O2fdVfWMjqxwt0/k1sp3cjo1HWRquSXtdw3SsV6v7VfsO
GPl8v9atScopqUOlC7xpbUfb2pEELvQ7koNlysmugdJl1QLz12Zkh1rjkOwQ0QSD
bnLy0a44MA3r/zrmxK8LrJAwQ+jX84IFa75zCkkpcntxcQDAUZH8L6eZs3jukt/v
4U56AxHpNvYEXkF1AxBPxG+ahQXE3l5tvUO3nxq2JkeemWkcuCZymqHQmxuiPoor
rKW6fy8u+/OPCPWqtQ3OXZpGI/HEbcSJ+lQRsUy/wR36boLvyF4QJrlfp5LoML9w
VmtV6urSLkDPc3kW8dtrMgv8w+1vVw==
=/8dT
-----END PGP SIGNATURE-----

--7aoKoHXbg0c1jiz1--

