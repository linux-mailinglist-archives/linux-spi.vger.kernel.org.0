Return-Path: <linux-spi+bounces-3782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E692A475
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D356B21D2A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B7823CB;
	Mon,  8 Jul 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVVFIbzG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1A25745;
	Mon,  8 Jul 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448307; cv=none; b=d+9hyMTjBG6I5mxT6flp4Vn7Suu+AF7f5c7RF7bYZwxEqVFLhciCbeC6S4NkggZQwqL4HAmYmHq1S/VktIZWZcs3D7R+P2Tso/lgrqffVDPeyTAAz9FA/3Pyc0fws4/byx2IOr42GAREGY0Jouu0zvEWHRADdj3eq7upEwMBJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448307; c=relaxed/simple;
	bh=OiFBSsJEjUGVfAjx0DaaBfxREbTOm7oq/rRUOtc/ATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwXXIiZ/EmhQzTg8CfLsoYUJaKK2zH06mZX57rFXrnJIACY1NxTZNKlm8vcAfx98NCFbrsGotzWUKpkgp0NcXpQOkb77R3bU+ebMq4FyltiBvBUDNj8XjKs9tDFOOdL9mkFC22EtulF6NqCACUwngeTRqBlZp1R6icXv6nhNC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVVFIbzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69008C116B1;
	Mon,  8 Jul 2024 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448307;
	bh=OiFBSsJEjUGVfAjx0DaaBfxREbTOm7oq/rRUOtc/ATI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVVFIbzG7wsBBho3HwGLXUr3DeYLZnedO74NTc9xUx0eSIBnwF8caz0d99DFXrGee
	 gRiCpBAAmoOUvWmsaKACn+LVOtSPm3QADwdPiSLnSmfLmcwEjDiAY3IyrsiGD0c3e7
	 bpY1fLMBIpTaVQp/Lyty1m7lj899MAZ64PlDZiyweBu5qHP4Y7gDy3/b83xNjkZNSx
	 llP8EOy7zGBzfYC6klj2mDS2wxWG96LmGms0U9JkIJi3oChUCpWBcyb85tC5w6fx27
	 p+aMJjvKXyLHDf9wAhiOwa0OTuLPNpHFSGm8gVyHYlcGl4HQPByErcNRK7qCDJf/Fh
	 4HiNDb1epyxWg==
Date: Mon, 8 Jul 2024 15:18:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: add ch341a usb2spi driver
Message-ID: <5797e913-ff20-429f-81d7-5c5c72151297@sirena.org.uk>
References: <20240708-spi-ch341a-v2-1-b98af4e919bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MspsRsVKnTw17ktp"
Content-Disposition: inline
In-Reply-To: <20240708-spi-ch341a-v2-1-b98af4e919bc@kernel.org>
X-Cookie: Many are cold, but few are frozen.


--MspsRsVKnTw17ktp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 02:38:56PM +0200, Johannes Thumshirn wrote:

> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -154,6 +154,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+=3D spi-xtensa-xtfp=
ga.o
>  obj-$(CONFIG_SPI_ZYNQ_QSPI)		+=3D spi-zynq-qspi.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+=3D spi-zynqmp-gqspi.o
>  obj-$(CONFIG_SPI_AMD)			+=3D spi-amd.o
> +obj-$(CONFIG_SPI_CH341)			+=3D spi-ch341.o
> =20
>  # SPI slave protocol handlers
>  obj-$(CONFIG_SPI_SLAVE_TIME)		+=3D spi-slave-time.o

When I said "these files" I meant both the Kconfig and the Makefile,
please sort the Makefile too.

Otherwise this looks good.

--MspsRsVKnTw17ktp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaL9S4ACgkQJNaLcl1U
h9C2AQf+LOIAq0TY7tH8YF/mkN2sLjY8a8Ixdb2Yj/E2Sbz1ah0NWxNUsGZn+XVn
uv2nmi5YbOCWj4btamML6RTximHl/Q59JqD6Pk9EefBy77RbQLkdyyDufy+ThNMZ
EKA72b0bWSnpqutkgb08bQ7MMv1FPt159aXup3HicDJoBGw5dMlxvTlRUTCAMTly
br99DFS6NM6YPFVlfZKutt31Gk3zdycTlLeTCdBEF2u+ShFy+luXn+ttK7cP0/+O
HEdulgkdtprqIr02YTKfSLMZA0hwU54OSX2i28QuqI4f53ikmCXYQuuCoKqyKxw2
by28dCSWBmM+F61qzNECBGoGRbXCzA==
=5z3N
-----END PGP SIGNATURE-----

--MspsRsVKnTw17ktp--

