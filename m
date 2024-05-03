Return-Path: <linux-spi+bounces-2730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D78BAC1F
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AA8283E97
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6E152E0D;
	Fri,  3 May 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXDI0SDx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879D152E05;
	Fri,  3 May 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738541; cv=none; b=FXYEEGHkSTP2DA1DgtM32vL1VDxb+YlM17GSnprvqBjNZtCwx7Dcl+SXbuE4PTPsC1dzvDTR6ekwNWhtDMdO6+tNouvltY0twkoQG327TGGdQdTY3rJR4wkONtjIBF++zxkaxdiDA6Sm5a5hMwMdMjFjwi7d5l52CZVKqQsGSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738541; c=relaxed/simple;
	bh=G5zgtgMCl51VCu0Y5VSmR5D4wDellEBRaZoJfqhlaWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6sq4ycoVDBNwOmWiPihb1ak4yt5ibteLHJ9T1y3hRLlmdcw4fRltq9VBDEfBnnoqRtNd1Y8VSHQG59DUie3++nBHE3IlUXXoTiWpGp3W3+TCh4gFcNXd7JyE7WJnaYnQPZ5Dm5W+KTAWPxj72NZIo7jwmfqBAx1ML1k4AS5TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXDI0SDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BAEC116B1;
	Fri,  3 May 2024 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714738540;
	bh=G5zgtgMCl51VCu0Y5VSmR5D4wDellEBRaZoJfqhlaWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXDI0SDxd8J0LzD9RCAVH4VB+kqKcX7HbqwWkIu+40R0A3PY5QEglP2ibNAtVrvam
	 A6hPSAmBC7VMrKyxWmYXOSVl+gSSiSMbyfE2PQxeVq05cvxhzYunYnDwLU1QA/aWrS
	 ReyiEo7KePxaUJcDTR0vPFlYxFA2xx0YGVUGuYz/UzZHT/18Hb8wC7gJByPikjasDX
	 n6IPHy/827W3LKmCqr7PHXthonKt9WD2sqZjZZxD3Ez+aGsjWfoA1YSvAx92e6MN5U
	 u7xsHABVpihgYZpEDEphz7nEGDUs7XXmKiNx/O4qVg3ZnktBZ7sxLa+HlTEZ0vtyeO
	 XzPA64cMG5GfA==
Date: Fri, 3 May 2024 14:15:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 3/3] spi: airoha: Add spi-nand flash controller driver
Message-ID: <ZjTVaenC3xm-4-Ik@lore-desk>
References: <cover.1714571980.git.lorenzo@kernel.org>
 <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
 <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FO3IFz7ibssA+0tv"
Content-Disposition: inline
In-Reply-To: <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk>


--FO3IFz7ibssA+0tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, May 01, 2024 at 04:06:43PM +0200, Lorenzo Bianconi wrote:
> > Introduce support for spi-nand driver of the Airoha NAND Flash Interface
> > found on Airoha ARM SoCs.
>=20
> This doesn't apply against current code, please check and resend.

Hi Mark,

patch v6 3/3 has just a couple of cosmetic changes requested by Andy with
respect to v5 3/3.

@Andy: do you think we can drop these changes or do you prefer to add them?=
 (in
the latter case I can post an incremental patch).

Regards,
Lorenzo

--FO3IFz7ibssA+0tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZjTVaQAKCRA6cBh0uS2t
rDdVAQD/uZ/C0ZxwEb4JvX3aRbA2j0bm3a2Q6KeIlz4fIbgfGwD/QiPHKdIpPTdb
gIJB3C4PHnjyrS4ZOKZwCGdp5b0qBQM=
=O+Xe
-----END PGP SIGNATURE-----

--FO3IFz7ibssA+0tv--

