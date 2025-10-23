Return-Path: <linux-spi+bounces-10794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91900C03160
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 20:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429474F1F6D
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC529827E;
	Thu, 23 Oct 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA3b2DEt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB673295516;
	Thu, 23 Oct 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245521; cv=none; b=mBTlHp76uVozFrcp3hGK3vS4AP8maIiUXik4ItHU64uxKRJcMglwVmqE4EWSlxJpQFMa3Ry6SwXpeIwP3JER/frMKiDMdXt8V662O7cGPhd9N1BBrlIuuiOWiiUf91kjzGKcM1SGjX5WImSBYXQzIB83tgPBMyc4Uv6ZjTP3Zr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245521; c=relaxed/simple;
	bh=eESPCSSOXsamdSuHXgJXCQrhot0/CQd3pgItLPG55rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGEBNlXcIC8ycB7brX+edIaYePweofS2zdlfPl3gSIRC/z5A56sPh9N1OoCMLMhepOVNJo5orhr/eV6wyNEX8jr8tzQzCbU+15OnlME4/r51CW4af+nGN+nP8/VMJhuaNOlygmyeiZ5xh+V1wOU4YmFy3ic3rDpYEos4xCtxf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA3b2DEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A0DC4CEE7;
	Thu, 23 Oct 2025 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761245519;
	bh=eESPCSSOXsamdSuHXgJXCQrhot0/CQd3pgItLPG55rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA3b2DEt1Qj9qdsRfH8GCJ5h0s/H+acgjn84ZW3oj9j5P3DZqMYlP4KXOQELIoOyJ
	 pntbvPcNso9/wMaH8FA1GkPYMHXL+kUQjiS0Wh/HQXLlAllv0Fq7/AANwXg0r7j3LV
	 oKy0N+6zDNkN74OEltqsVPXqKNFR8P93zL3FxGyWYC1CLXkpaCtofUJaprqS6Mi7RV
	 zCRs0AYDKzez8eVjNxDKiVOLwiDQxtVa54yw640Q3XXkNn6DTTOMyrl7b4JCCSeN5R
	 4MiJzsVSsvvNw5ulxutifgawh2Uve19vLrs398gq9xKBGaKkz8Tl7vAAn8fra+y3pZ
	 4IIozRWIUa6gA==
Date: Thu, 23 Oct 2025 19:51:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	Frank.li@nxp.com, guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Message-ID: <20251023-finlike-outline-86e62afa4bd7@spud>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TUrEZvgml7CQLLIf"
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-2-elder@riscstar.com>


--TUrEZvgml7CQLLIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:59:13PM -0500, Alex Elder wrote:
> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
> is the first non-Freescale device represented here.  It has a nearly
> identidal register set, and this binding correctly describes the hardware.
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Point out that this is the first non-Freescale device used here

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--TUrEZvgml7CQLLIf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPp5SgAKCRB4tDGHoIJi
0hS8AQDYMRazoABNlKH/b+Mygp/zkDAWNQf1cbEZnLpyMl7Y4wD/Re8aUdx97KFQ
e82V6/zj8gHJG/3k0oy3joGkFupZOg0=
=OZe3
-----END PGP SIGNATURE-----

--TUrEZvgml7CQLLIf--

