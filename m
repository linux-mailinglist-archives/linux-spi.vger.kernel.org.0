Return-Path: <linux-spi+bounces-3905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87182937531
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A911C208E1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A378C76;
	Fri, 19 Jul 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA9Z6z1k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDA6F2F0;
	Fri, 19 Jul 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378556; cv=none; b=JvBMtvS4A78CBafqWDbUIGYWOYzzEZoFPkyy0W6MXhW6nNKd91G6+rvUVhhdR+6DRFJCxObpWw1oANqplLMtdLO0MS4w0FmFvn6wazZH++/uXi+l62cw9/6G97mlW06xtr0nDC0xyCfpFT4j/ZHRechbvgpVDKxmItjgX7t8XXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378556; c=relaxed/simple;
	bh=1RtUkoc9phOsamZGd/p285MVOD6wLvFUEKT+1gRE58o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpP+aRAhNHGD3H51CJwKbJysJfRYSXyjIK5cNP+SuCYLaDxYmemuezt5hwuBoDdwqusypIV9rWGdZjW8xX5ozWm51bu5HoEGrEJFf/CITBQEd01QA1+o+HR89j30ns2zg7fnYcymzVHjMLSJI3/Lm82etTSXGFt5gdSmERdrvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA9Z6z1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA57C32782;
	Fri, 19 Jul 2024 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378556;
	bh=1RtUkoc9phOsamZGd/p285MVOD6wLvFUEKT+1gRE58o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nA9Z6z1k+gFmKbcouTJ0SUUAJiGlsKBlnILplevLqu3e0/yv2eAx0ceW0HGhqdepE
	 uF+ehvMy0rd9LDIYhB2ZRBJzMhW8ZVcNI8yBlYvWlsTPOxC5jgnd9okx+7E+yTzClw
	 x0g4MlQcvxLEfsyYjhasItyCsl9MQBMOAIujUfmVl+FdhaPcHU2kdtfl0l3uzLzM9q
	 5LV/3zKgxMiCwIqRrFHo8Vbgb4UqJ6SM5+HjQ/b1qk4kmzqx2NOSLnDRiFpUrzVKnL
	 8puKLr8HeUR4h4lfH5l4gLdok6htkyzZkoj45onhf9ykxkxZ+PvgGflgbcwUPKV8yO
	 d9rcT2QVnXIZQ==
Date: Fri, 19 Jul 2024 09:42:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: trivial-devices: Document elgin,spi-lcd
Message-ID: <20240719-clunky-skintight-7dde4efd7cb7@spud>
References: <20240718200540.955370-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0EteTe1feTDpiy71"
Content-Disposition: inline
In-Reply-To: <20240718200540.955370-1-festevam@gmail.com>


--0EteTe1feTDpiy71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 05:05:38PM -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
>=20
> Add an entry for the "elgin,spi-lcd" compatible string.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 7913ca9b6b54..49dee2a1f6b4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -110,6 +110,8 @@ properties:
>            - domintech,dmard09
>              # DMARD10: 3-axis Accelerometer
>            - domintech,dmard10
> +            # Elgin SPI-controlled LCD
> +          - elgin,spi-lcd

As mentioned on the dts patch, this needs to be far more specific. Are
there no markings etc on the panel?
I still can't find any information online about this board, other than
linux/u-boot lists or related repos.

>              # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
>            - fsl,mma7660
>              # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> --=20
> 2.34.1
>=20

--0EteTe1feTDpiy71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpom+AAKCRB4tDGHoIJi
0uB9AP9rQdNewDgtKcfoFuFzR38cMQy2cD5mjR8Sgz90DGCARgD+PC1YmYYYBYeI
e6UdqRTEKVKXBb3acfYMW8hrm1SoRwQ=
=drtA
-----END PGP SIGNATURE-----

--0EteTe1feTDpiy71--

