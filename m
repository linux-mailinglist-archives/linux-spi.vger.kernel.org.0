Return-Path: <linux-spi+bounces-11057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEBC36A53
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 211DD34C542
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF204337689;
	Wed,  5 Nov 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx6nxMHA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239C334C2B;
	Wed,  5 Nov 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359514; cv=none; b=d+Bv2YH7V0VZGOIOwyABQNoJfMVWlcBD/RUgEuV8VNFcj9zKGTqbDDPUmMdBHDahNL9yCMBSn3gVMTyP34VcieqTJL7S0zTUR+MLiIbWTmNudGkJZu8lMcb8R4eYREatb+N1svzcc4TBN02Y8WI/BAv/lN1uiKhy9ML4uz1YwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359514; c=relaxed/simple;
	bh=jtQ6gEaQkzmYc07dmXo9QQFsS8gV6DmjYJ4TO+qHYGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/RwqfeVLMKW3/nKJ7MmDLt+3S/p9TeJuDQUJdzJAu1jxTz+N8T0LhQ6sNRlQe6ez2HOHHmxxoSxN59ee6or7yYRleMVHTlocM+apXzgt4WHRjSNpXGuDVcwom/U0wliHx3qepokmZU8np6DJfG0pwyIn2aub939HIENnYje9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx6nxMHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4DEC116B1;
	Wed,  5 Nov 2025 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359513;
	bh=jtQ6gEaQkzmYc07dmXo9QQFsS8gV6DmjYJ4TO+qHYGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dx6nxMHATznO5a67WfGEYEyTibBUzhlWgJPru/yRj/Hv8ahqTpqdD1VD0+nB/i8iV
	 nb93S1jksm2LS7do+VINUKNk61t6PzjkhkKOlecvghf/hVqdLZBUVl37ZIDYdPTMp5
	 JjRdGNA5kHN4O5borDM0eYWuKR/z1UTBmGyf0xNhxIqjHWc0vyitcM2kx60doP+EnO
	 cb0idfAwq2iKMq1f529MVbhLPj3muyohpV3K6DP1cGpqSyZ2mgGp7nKEGT9tEdjlt8
	 6TPiyYzWkuLGjZMPf9LuJFRzoPci97DXGyzKN37TEWdKvtaM/cYCMt0oRxTVU6t8Nx
	 KHiSf+qGmkiDw==
Date: Wed, 5 Nov 2025 16:18:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v2 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <aQt41uGfmbs7Qa7x@finisterre.sirena.org.uk>
References: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
 <20251105152823.730422-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahMTsRXk43UBu4Jy"
Content-Disposition: inline
In-Reply-To: <20251105152823.730422-4-prajna.rajendrakumar@microchip.com>
X-Cookie: If in doubt, mumble.


--ahMTsRXk43UBu4Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2025 at 03:28:23PM +0000, Prajna Rajendra Kumar wrote:

>  drivers/spi/Kconfig              |   9 +
>  drivers/spi/Makefile             |   1 +
>  drivers/spi/spi-microchip-core.c | 442 +++++++++++++++++++++++++++++++
>  3 files changed, 452 insertions(+)

> +config SPI_MICROCHIP_CORE
> +	tristate "Microchip FPGA SPI controllers"
> +	depends on SPI_MASTER

Reusing the same filename and config symbol is almost certainly going to
create issues and confusion for people upgrading their kernel or doing
backports.  Perhaps CoreSPI instead?

--ahMTsRXk43UBu4Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLeMcACgkQJNaLcl1U
h9DBEQf+I+GMNJBKyuyNbyKECoiylM6NJCpRPBtRkDC8FlF/4NmPRyJVc2NtggBJ
0oE+Z29HdILxT7LZGiFS9Bohm1aV3polVze54vy08v+AGpmVWavecwP0A8267I09
cgRP/g6g2uS5wsSoi5KaFNKzKHbv7iY/4VMyQqR45a9wmsnzHc5jCjGutCRbmIgy
ehRT21gKFbzMDbL8uBgRwszxHj6xuYJ17NfiBCcbl/wRZV+22deriTxUywW8QIT7
abi9fowOftdD9fD8mjyKZ8gQ++hFFBrS6UpWtSbSdpLHnmAtREK/4RNsimAfIq6x
jRzSeE1l+fF0eV4OPnzRnvVWq4ms/w==
=ohJB
-----END PGP SIGNATURE-----

--ahMTsRXk43UBu4Jy--

