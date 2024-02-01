Return-Path: <linux-spi+bounces-955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517338456E7
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846051C20F89
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD415D5D1;
	Thu,  1 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL+PBCz3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAF15DBB4
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789096; cv=none; b=a9TfJSjShIqgBCvcFKeD4UZwyQIf/nhYskpZ1BJJ40fXVS7I+ByEcl1V4+5SEbqWpD4fJnclzIelPKdO9J9Y/vQVy89Py0SuNTtz08HBDy3A0WOMP6hLPAMPfuwoWUYrv+IqoltsfWwsVFYvmDsZ8Fz/kUdavh6DeJPe/jrgWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789096; c=relaxed/simple;
	bh=v1EK5eIpj6FCljIX/jdk2TEEGlXUFe37dH/uhRwfiXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmzS1m7fVgXlYt1XIzT0t/UxZYMSThILl8usrmem7lHPHIHhLIvXrvq/pDKB0e22ztwmLRPM0Vwt3ATrRk8Jb6a+yC+/NZcQNmD4sE2Gvox3jp/mAZkDYdjq1SUAepPwAeyvoUG2V4ggVllHux10x8Is97qnOp80JFqeDpPMD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL+PBCz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61420C433C7;
	Thu,  1 Feb 2024 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789095;
	bh=v1EK5eIpj6FCljIX/jdk2TEEGlXUFe37dH/uhRwfiXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eL+PBCz31YTi6h4k4eUCbJmJqmr6ITFMTlDyGg3ZYlEVdDmxmNrHYYWRLlsOMkDbw
	 Ein9Lmv/mpih7npOh2ErrWH/1LkPuqF/6mzSkLG8cpPtEeChJXgN6euiiVcG5FHwx5
	 hOZsOOgn2VxlS7i9wGMWBKc5cm+SR7RPuWzjEbZPVEOzRjTWaStw7MZqxaLlhOgteX
	 Q43qPB/5XdeJK+8Ec1qHNH1x8ch69jeVYBefm6lpQaIhE1yd3M6z1qwUiIRkQF0gSt
	 CSd5chpBzSIMxz+QwHBt95sDvuOmcRrIMyjl3gG3JCPzM49watiaR20GiGLIJrlJqd
	 ex2tR8Ot5NDlg==
Date: Thu, 1 Feb 2024 12:04:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	leoyu@mxic.com.tw, jaimeliao@mxic.com.tw
Subject: Re: [PATCH v8 2/9] spi: spi-mem: Allow specifying the byte order in
 Octal DTR mode
Message-ID: <4a7fb252-9a38-4ada-b9a1-d31e13adc98b@sirena.org.uk>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <20240201094353.33281-3-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izoFBLRdPvk3P82M"
Content-Disposition: inline
In-Reply-To: <20240201094353.33281-3-jaimeliao.tw@gmail.com>
X-Cookie: You can't cheat the phone company.


--izoFBLRdPvk3P82M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 05:43:46PM +0800, Jaime Liao wrote:
> From: JaimeLiao <jaimeliao@mxic.com.tw>
>=20
> There are NOR flashes (Macronix) that swap the bytes on a 16-bit
> boundary when configured in Octal DTR mode. The byte order of
> 16-bit words is swapped when read or written in Octal Double
> Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
> modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses

Acked-by: Mark Brown <broonie@kernel.org>

--izoFBLRdPvk3P82M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7iOEACgkQJNaLcl1U
h9Cw6Qf/Q6rcaXXA4OW9X+HACJCNwLnWAapE7fxy+8vl+m49TN62lMmZI8i/NrCA
9YeK/TUBGViQw7woOOJG/suuBE+fQki2iffXZW/gl/Gcc7rZzAsstbIFrYQaP5Ei
QJ5JnAipY89s8fXiHzZC6RN+j4UjapzLlTjMSIoR6CvdpnrG3yrNQOr2ynp3U4wW
IMKahUTXRsZ0UuAIOP7VbnyMQN9LMCb6gqkVRExfAzCtWIHfMzNpGSHbehrV4Dre
Mwohr4wBU8VatsK66R140NXL24W1PRi8wG0FaIjyPKv1RrtBXKX5BRwBKJrgAIzY
JpqbgLAslTg8N2c0IY/L3nqIBq5hHQ==
=Wupf
-----END PGP SIGNATURE-----

--izoFBLRdPvk3P82M--

