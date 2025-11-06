Return-Path: <linux-spi+bounces-11098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3707C3CF99
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 18:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A40CC4E2349
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C934D4CD;
	Thu,  6 Nov 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnU3R1en"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC462D543A;
	Thu,  6 Nov 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451879; cv=none; b=ic1q6Sac2kXymx3B3h5yHsCROgva64vBAGqPMzpN5urXsSv71y6Bvjxj43ZDwUm3xFfb9vkU4RtMc4wUYmUjUqNJQdAYjILz7zGKWTKvVxAKXZA0cFlLq3YK44wKNr1H7yPX7gZGfK6YSpZV5XpYOcZH5kQUyxRByALXyZgsL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451879; c=relaxed/simple;
	bh=dgZf1qyvoDaMoG7iJ8Qm7F4Oh8Wn8GPRRg2kIxB8ldM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4CyRnCREgbgPIPy1gYFktn8iVzeb++BfWHs3unomYsZusdCNU+hD+lgAZVCo/Rsy0eHGwB5Mtsg8CnN8RjrJIKdkmGVWZp8vEpD10sMz6Tr6QYPXDyDBNfPsok3Fqlc7IFcvE/oq1C59oKCoza6Zsh0mL9E4TfKCJvpf4nX/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnU3R1en; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FD0C4CEF7;
	Thu,  6 Nov 2025 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451878;
	bh=dgZf1qyvoDaMoG7iJ8Qm7F4Oh8Wn8GPRRg2kIxB8ldM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnU3R1en/HyBGfLmuppTglKLH/cWqmzMcbfgsmAp/SUfy/KZHSGXmIjTIxFkzfWVL
	 IMSv+UffaT4W5ZHKjanEUvZUwvSqi3mFRhI3hL5OVS+XPjwtOdy4086hpZT7DF4beQ
	 J3iJ3cRzWBL5dh5Sjo2N0xyZNAh/ghkPiKmITDS+nUUe//lVKy5wzb7EYdq1HZdL6a
	 lzSKp76KMwweuOMDHuIIwoCyUTSmwunY6+OJEO2lXdjorXFK8w4MnBgSRPmd7u2/4/
	 BZ3riHyv25h9kuPJY38VO4vKYeW4o/gmxzfTLyx5T0FS7zs6mEMgT1z+Z7F9qO9pRY
	 Ew4y3ZOe3C3ew==
Date: Thu, 6 Nov 2025 17:57:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
Message-ID: <20251106-anchovy-font-33e9a3b4efe8@spud>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251105091401.1462985-12-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrcvO9Ywt0+arYEE"
Content-Disposition: inline
In-Reply-To: <20251105091401.1462985-12-cosmin-gabriel.tanislav.xa@renesas.com>


--wrcvO9Ywt0+arYEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:13:55AM +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals.
>=20
> Compared to the previously supported RZ/V2H, these SoCs have a smaller
> FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> being the clock from which the SPI transfer clock is generated, is the
> equivalent of the TCLK from V2H.
>=20
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> entirely compatible.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Why is this a v1 with my ack?

--wrcvO9Ywt0+arYEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzhoQAKCRB4tDGHoIJi
0mt5AQD9G5prS0czdqLHg/6K1PG/+n7veLCUlVbc7vXuw6+mTAD+K1w//c1ck+UZ
Cto80xfLN36atIeuo9HHIB/eGI9xhAs=
=lsWu
-----END PGP SIGNATURE-----

--wrcvO9Ywt0+arYEE--

