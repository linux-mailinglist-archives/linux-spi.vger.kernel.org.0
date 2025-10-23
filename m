Return-Path: <linux-spi+bounces-10795-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D45C03175
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33E2050657A
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552434B1A7;
	Thu, 23 Oct 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5QoS1dF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633130E83A;
	Thu, 23 Oct 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245543; cv=none; b=Kn4HJq4rLGYvfp0acIP11L9rYwQw5DJ+QJErtw6EbtOQ22lmAkm9SDH42unyhPEL09vB7CiNNPwn8Jw2cdyQd7lQ8ywQAO7F0W2habSA/NwDdJeZ7I1ueT0B1KAPf1iUAaar0qwk3mRoHVX4H8AiuaME7c8iwzf/cmSLtJpQNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245543; c=relaxed/simple;
	bh=iNwcnFlrFMVa5EKGN1iC6ANOgbWoVEcUG/+IRxZZob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcZcS0JqCSCTi8yTTEscPcehe8a38rwdbDRg0yV05lYnSU9A3S2cjorq+df2rAJZDQos1iA88sPUHeQMMlgMOjHs6KZGZUMNlncDRFJB/t3CSG0C2FOLbyfAaSGrz+XyuGrloghTvs6s+NRwpntF6Q7TFoE0no2Id8Z6HdiDMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5QoS1dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B07C4CEE7;
	Thu, 23 Oct 2025 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761245542;
	bh=iNwcnFlrFMVa5EKGN1iC6ANOgbWoVEcUG/+IRxZZob4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5QoS1dF3wNe9aYKaLnjUxCs6RBEWGey7PVz9UvpoJmaC2/M8pHXD6ZC9avAI8I4X
	 ThyuWU/EzNKKFk1a4hV7Zp7ZEt3Qi077JzUJP7mPjS3fwcm3i1Lh2vJpM6qn5OXd9q
	 GQkqIXy0Cnj1Zhpg+T4D/widXCB81gA/PrZ+/eLiPFES7VSteD9cLLnZ+Ijhn5t/9B
	 OnK71GEVrk+Dw7lrY48B+BwR92AilDmCjJZhT7aVJOfKK+q2a0tuPLc6rdHSgVkOlQ
	 0mVfMRw2QHz9smL9twoyIwG7V4n/c3Yp/PoEWNKNWNPdX7R6Kd6VFqhy2txWA8r7aL
	 eAWFPa+43qXcQ==
Date: Thu, 23 Oct 2025 19:52:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	Frank.li@nxp.com, guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Message-ID: <20251023-feline-fanciness-c4d0a91a010e@spud>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ETu37CKt9FSwtQo"
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-3-elder@riscstar.com>


--/ETu37CKt9FSwtQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:59:14PM -0500, Alex Elder wrote:
> Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - The "reset" property now only applies to spacemit,k1-qspi compatible

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--/ETu37CKt9FSwtQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPp5YQAKCRB4tDGHoIJi
0otQAQCK3NvE/Tm38AIhpEtP6S7mkv0RqwsNSoSYOHCFHH4WfwEAiuXWhjAfdkH1
sM3n+P4Y+mZbEkMAfgQGPWp2lHTSSwk=
=eqg5
-----END PGP SIGNATURE-----

--/ETu37CKt9FSwtQo--

