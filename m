Return-Path: <linux-spi+bounces-2848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44958C5AAA
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AD11C21C4B
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362C1802DB;
	Tue, 14 May 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0kPQXSE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5761802AE;
	Tue, 14 May 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709244; cv=none; b=TOOxxX3uhCnuFBrU+W9mO1ArJGY7QsTXnH7YRBkKF/gO1Ha0ZKJh92fijKXJ+AJv/QGf8b0pf+4g5kRfxOfGi19EKXKZbMJrliVjBP0y8agTqyWji0xTBSTmks3dC0aWDHmRHzOmb+c2sfl80iKd9PLSnWHTKb93H4nOms6sgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709244; c=relaxed/simple;
	bh=Og2bulaEiyhJKBbZNSuOSTrvk7DGpRodAs0PpN4so9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ5cxF83/mKIY0WZqMCepd53WO/czVFmbytvXoxZjh7RuqyIe8f9N7XU/oiV1Hlr6ukVHsfUp8IJMFClKKUsPy5KqWXRgalxqHIoGsWEZcXTzDYJBdT95cUXFCSapqc+hN5NEXz3V/ZHm4ItCwblbd/LKtxlOCCyIuxbzdLFznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0kPQXSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F77C2BD10;
	Tue, 14 May 2024 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709243;
	bh=Og2bulaEiyhJKBbZNSuOSTrvk7DGpRodAs0PpN4so9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0kPQXSEKrzRVNE1rhsk7LR8Y9DVKojRyOJxI/q9ASeeyJ3kLTNTZnffMQkUmLQ46
	 Sxj43rQN30djUDw/EFF51Z7/6OdMnffKTRs3ZdJHhqCu4Svv/xM+W0Vy9F6rRYnbDJ
	 MvbgCZR92nyN5lQbIVP24wAzTX6BEGDtvl1WsU675/u9cxILjccBD2dw75Gb4DNrHV
	 gcHSxg1wqowP2s18cUU8Ix7R0s7UnmC3xhiBEooaZgPiPz6600v+ly8JxK1CbW2lbM
	 cxKG0nrkDwW1/kqFp79n7zlPcgYmZb+/Ueo+NTcCLSA83vCtPkZclWRg9rCSyxhLBF
	 RxLuVOzH3kUtg==
Date: Tue, 14 May 2024 18:53:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH v2 2/3] spi: spi-microchip-core: Fix the number of chip
 selects supported
Message-ID: <20240514-epileptic-enrage-44fe37b417ff@spud>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
 <20240514104508.938448-3-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vyFYGc/Uj8F56sfy"
Content-Disposition: inline
In-Reply-To: <20240514104508.938448-3-prajna.rajendrakumar@microchip.com>


--vyFYGc/Uj8F56sfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:45:07AM +0100, Prajna Rajendra Kumar wrote:
> The SPI "hard" controller in PolarFire SoC has eight CS lines, but only
> one CS line is wired. When the 'num-cs' property is not specified in
> the device tree, the driver defaults to the MAX_CS value, which has
> been fixed to 1 to match the hardware configuration; however, when the
> 'num-cs' property is explicitly defined in the device tree, it
> overrides the default value.
>=20
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers=
")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

I gave you a reviewed-by on v1, here it is again:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  drivers/spi/spi-microchip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
> index 634364c7cfe6..c10de45aa472 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -21,7 +21,7 @@
>  #include <linux/spi/spi.h>
> =20
>  #define MAX_LEN				(0xffff)
> -#define MAX_CS				(8)
> +#define MAX_CS				(1)
>  #define DEFAULT_FRAMESIZE		(8)
>  #define FIFO_DEPTH			(32)
>  #define CLK_GEN_MODE1_MAX		(255)
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--vyFYGc/Uj8F56sfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOlNwAKCRB4tDGHoIJi
0mh9AP0e3B6+xx/518heUOBQSktIwp5X7vszCM4FRNeMALAPlAEApV7oxlTbfDp6
VOdPHK8/UYURoluxXJ5VzI1bZDU6cwU=
=yQ4T
-----END PGP SIGNATURE-----

--vyFYGc/Uj8F56sfy--

