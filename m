Return-Path: <linux-spi+bounces-8041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38157AB194C
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8996854208D
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22122E418;
	Fri,  9 May 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agPE/e38"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D92A1BB;
	Fri,  9 May 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805831; cv=none; b=FO62oZC9uxuI8p6WqlJHMp6kUWQI0ekKfDuw7UcSV+YUxV+TKiOw0ntFZPeFgegc2x60HNIBBD6OcZd1uB9LanTccK62cBteli5ncJVwKBRWdRK7oGJ/0A/VuSlyOCnisozIf08WzDcxahyUstoaq58n2Oh8tHcW0ztNb/XIKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805831; c=relaxed/simple;
	bh=MWAkGidqBX5HBclIK0w8IRw+9+HbrMS7tiBfUakCTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Wz7N5pU86DsHvufIg8Q3aOs60gji4G2cYFDY2SbxwikOo4LnokAnspmfpUsWQKBCRDInxNYgybc9Jt/hzMkXcEUdjGZ4n4UOHIy2At1nfGpEuupZxauvTF8QuG5w7M0qvjlG/hi6v7EOCK3iLCx9f+StYE2DhasPXidJ+45so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agPE/e38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25259C4CEE4;
	Fri,  9 May 2025 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805830;
	bh=MWAkGidqBX5HBclIK0w8IRw+9+HbrMS7tiBfUakCTeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agPE/e38PsyLDYEY7NP19Kk/S3Aki2UA+OUsmF/Ur0wiu8MwfK13WMkYRpSoktZ3x
	 qYhMlflMGek/F7qJiDASfOQAKDQ6iFuoBSsknUIWyjckHs6AZdS7ZrXCECZMGA31zE
	 henLbXb4ceM4pH+zqlVlSM4xAyb55uw08vNs1Ym1d//KHxWGl/adzIG9kTipPnwVAy
	 0sSfriM3YS2b34KI8jzLtNhpKru+SAeetkxbzMyHW02ewuvB/G71gm9lu/RiCOtc2S
	 KJMndkwXkLJqRZDKcI8jvOv2pjcUAvQI6J0KaWcVHwUSz8qPEQmE7ZNFXzpw9z/G/u
	 irnqM44abmMJA==
Date: Fri, 9 May 2025 16:50:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: fsl,dspi: Fix example indentation
Message-ID: <20250509-anew-slept-032f64ac6034@spud>
References: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JLtz9K+e58T54EQF"
Content-Disposition: inline
In-Reply-To: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>


--JLtz9K+e58T54EQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 01:21:31PM +0200, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For both
Acked-by: Conor Dooley <conor.dooley@microchip.com>

(idc about both appearing in tree with an ack Mark)

--JLtz9K+e58T54EQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaB4kQQAKCRB4tDGHoIJi
0qShAQCd9ufBaxXRPbap/bGPVseVhTYkT+wTdHHy2pa1ltrV8QD+Jy6vOTleDf2K
GCgM3WPo4O3ActnatJPM376WaePb7AE=
=7huX
-----END PGP SIGNATURE-----

--JLtz9K+e58T54EQF--

