Return-Path: <linux-spi+bounces-11585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D903C897BD
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BB53B187C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8568F301460;
	Wed, 26 Nov 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4tfa19X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144F2E1F01;
	Wed, 26 Nov 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156103; cv=none; b=GqbzDNMiC41M8tqf5+Q24Tz18JB7cwwiFAm1sVjlQtU2b880V2oAMKUUmXCwX6yT8z2GowuVO6SnHn45iCbrs7ZzvT9ubJOxfdi5815vPtiA8dASficouOmlKsvEuUWfCOWGGHQkxIWqX2OAO2onHtKambL9Macxfy2+/l+h3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156103; c=relaxed/simple;
	bh=+M1dNYDPJDucmTy9XgibG4O3ZcsHHharUUjsVMGS+nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQkulGCRYM/4xcqZbpJwAzawrxkqYnX4697j9Rnl4OwmesNqNjcy1R1GlZihLxV7BefmOvHfi/OwcSFWbi7S/SFupcIF/h9NowT+s3FslPFjQH+Med+dBMCl5CdLOdNCYrcs1oaGoGR+V33MpmEp23Hs0YaCCwii/hK9uFytUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4tfa19X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9B2C113D0;
	Wed, 26 Nov 2025 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764156102;
	bh=+M1dNYDPJDucmTy9XgibG4O3ZcsHHharUUjsVMGS+nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4tfa19XKP/x/FcIklEc01X3EQ2mi5Z77lcnl1oTTD5GN19QNt7/cnlCR+YYceTIR
	 fr1KasndG+dNmakai/vmMKtQp1tBEk9875rxJjDRNske+IbaxEgK6TCz1No/IDA96U
	 YGLrccfS/Da1/Gf7agbu7GcDBaN9TyvloFVyuzrituWVBQVnIcbX66FJ5PPKcrQPCz
	 0m1aluQ+hHFaGFhCix8oxczRrewLXDA4hiEKXg6csFn1cMxZAtM4cE66NdJsSTVrT8
	 xoanTaZ6tjv8TVV+PUtXmNTGPc/BDr+4hVFm3zb19gUhUU2jte88LMaeF1p08+7wiD
	 EhqvulIEzbrBA==
Date: Wed, 26 Nov 2025 11:21:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N
 SoC support
Message-ID: <a406ed6a-fe64-408e-92fa-e8acd5b5a4b7@sirena.org.uk>
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hj3JWs8w5xU5M5GX"
Content-Disposition: inline
In-Reply-To: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: Murphy was an optimist.


--Hj3JWs8w5xU5M5GX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 09:45:29PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Hj3JWs8w5xU5M5GX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkm4r0ACgkQJNaLcl1U
h9Awqgf8DN0TTmYFzmmCxYiPHzeg7c6VPSH2SKS9WSI0mf8nFuUhRjGy6LC4VMNu
DJMBO/O1V+BAgV6Trfa5lxP57jSUszP4QSo8RI3CTggxqOMj5gwRZwVA5BtRy6ZT
+oRWZP684KFM5tvKakQFR2Hw9byus9x+o09RdVfapmQ079eEWi7+EjAr5Tc6nmq4
sWDXPSorRy1sS/v82GbvO77a+UXwNfhcoOtRnw2KpzywJsJl6J1W60qGKQTuIr9/
bKthw7qdk172gr0eSmpMxSyG7+t0G9wZ3caikN+nmdB0mj+yB7wtLNISuvGeY2oL
LFkAZq01oenUwShx0VKZWC3S4X/DXw==
=NAeb
-----END PGP SIGNATURE-----

--Hj3JWs8w5xU5M5GX--

