Return-Path: <linux-spi+bounces-10734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4EBF2C72
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E614FAB29
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290E3321C6;
	Mon, 20 Oct 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De1mxxBd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B53321C3;
	Mon, 20 Oct 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982086; cv=none; b=aZQpX0XQY1clkibBYpuFk4PGQUmQUVvYI8oq5oFUzn910YRoAU1O/1TLARxA0o9t3Nc/9JyvoBB+OJF9Aqoy1anDmLkhYpJVur/cqMbKmj2ui2F9YclGdziGFaf9/fH99P7p47w0URC5Xw4UQZmSkoW6MJmcZPmCS0s/X0HTFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982086; c=relaxed/simple;
	bh=0shQKZ6LMkY7eu+foeqCzGr2kMlEmfoaK6oMFy9Q3fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOC0SyFCka2UzrA+YrkNE2uGb3JOzYDVMgoESXA6XyUp+q4sZE9FkAgF37hVyr/9dLlYMbsVuMo+oUNzRTQ3vMl+MZ5B0E7yubtWPMDgIYrceBIj+n2iWqgDiY81wmmHR0eEzw3VnlDvv7e95V98cl6AMGkvl87wxN9C3aQPnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De1mxxBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DAC4CEF9;
	Mon, 20 Oct 2025 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982086;
	bh=0shQKZ6LMkY7eu+foeqCzGr2kMlEmfoaK6oMFy9Q3fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=De1mxxBddZqMNleN87F+pQxQO9G//qIlPV7tFewpeYUIjnWrJvbkgzf5+ZE6H2uPl
	 HsKeowTy6HQIWgilMsO/ACqB+7Q7qcUi03DvuN3BKf5rHM0AE2kx0mTzqQgukoG5Df
	 G0aCfX3EtwRjEy0ckL46C4eVjqpJ8hBU035OmuvibVjrgcTyJQWpdyNoe7RMiVGY3s
	 QddLVA9H1YWfE9N4zNdxP/D3ai5zdXIPbHqP8dTQ3caEsDCHyeQ0uWZG8E2Hqk2hWb
	 F68SASIw7WIPsQM/y+XvSnSZ77lu3wuwNSBx2+zAHM9WYfYkcSy/8k1lzb8UpCN2L1
	 DwDWjoLvxVURQ==
Date: Mon, 20 Oct 2025 18:41:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <20251020-utility-remedial-4b4dfc716409@spud>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EtcE87axyRT4niT6"
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-3-elder@riscstar.com>


--EtcE87axyRT4niT6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:51:45AM -0500, Alex Elder wrote:
> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.

Also, you should really explain why this spacemit device is the first
one to be in what's been an fsl-specific binding for now in the commit
message.
pw-bot: changes-requested

>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml =
b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index 0315a13fe319a..5bbda4bc33350 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -22,6 +22,7 @@ properties:
>            - fsl,imx6ul-qspi
>            - fsl,ls1021a-qspi
>            - fsl,ls2080a-qspi
> +          - spacemit,k1-qspi
>        - items:
>            - enum:
>                - fsl,ls1043a-qspi
> --=20
> 2.48.1
>=20

--EtcE87axyRT4niT6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZ0QQAKCRB4tDGHoIJi
0jw3AP9fIzYzUtEKSJLqkolLXPEWaL3paAWpO+XlKFabuMCkVQEAj6t4t3UyUduk
YQnlq9gBr5tZn+FNWIUYFR5JDC/WXww=
=0LUZ
-----END PGP SIGNATURE-----

--EtcE87axyRT4niT6--

