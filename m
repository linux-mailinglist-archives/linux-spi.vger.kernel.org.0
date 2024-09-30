Return-Path: <linux-spi+bounces-5046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366798A5B2
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C636FB208C6
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EF18E046;
	Mon, 30 Sep 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF5vOw9L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6482488;
	Mon, 30 Sep 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703912; cv=none; b=R3hMljeYdHlqKD2Ly13vq0+GGKPqX/ZlI86fUxwx9tgX0GAWr2JxrR4aVX35/36Fqxmi1esW4rhBDrXPj/C/OcyG7BseAh6XIAxX+gYWw4686+IUdJ7vvvM0gMXbfVPTiTamvWCpNw5FdgW3PzVQO7biuUz2A+aRrDmgReKf+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703912; c=relaxed/simple;
	bh=XDMOUbaodttEOjqygaG+KV2OBgc5SWE0zH8P44Ue7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOXWF3nsHaBKr2V2McGOep2zShyR2/VrJ289xZ9IxXqf8PI3tLDIf2wOw4U5MMbAaNS2ipAOXE1UxR+n/njvYXgeF7aBTXvBKEwb9dMUOwtNVAqoot421c7XqjbfqkFlaWTmYy1dDI0wvkhc3qn2JZhrOJiPfg2tnwZqwARAPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF5vOw9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE4C4CEC7;
	Mon, 30 Sep 2024 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727703912;
	bh=XDMOUbaodttEOjqygaG+KV2OBgc5SWE0zH8P44Ue7g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GF5vOw9L52CDYPz5WyX7bk1+QI2ylyPu8T3dig7bJZJEH1CZSWfNgXWbzM8Q2GNMf
	 pV9OIAoE4u1nT6kvC4MOHtr30a1gcxQtetq3od9cyTBbd/4A6bwUU477OZFPdh3/Li
	 Egk0t4TCatnywg9lhpl9txh8ZXEigHqHUe4v6Zzs/xM+OAMeIm37mNPSrAB27QzX+Q
	 LLiJyelYZfQqvnT3sOWHsr/PzKgQjLXcCTiPEBi7kOOrG6yV8hgGQAL6Z9vXy/WUxJ
	 rxDxmcO9PNvJ2TMxhGu6/FmRlCaG7l4g0upXYgLiv2CcgvOKpRg1Wksg6zcKI7KUqb
	 7pQ2wVYYxI4KA==
Date: Mon, 30 Sep 2024 14:45:07 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 04/20] dt-bindings: spi: add PIC64GX SPI/QSPI
 compatibility to MPFS SPI/QSPI bindings
Message-ID: <20240930-undrafted-mammal-0308550b621b@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lTgx9h43bP85ngCk"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>


--lTgx9h43bP85ngCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:33AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI, just use
> fallback mechanism
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--lTgx9h43bP85ngCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqrYwAKCRB4tDGHoIJi
0pXoAQCxk5D3pG/9f7uU5cG2212GvwpqtVgQJNyOQWAw/SSquwEAr54S7syoA2xX
mnlENWuNQscB87oEV1z8bQZgsLRdCAw=
=gOvb
-----END PGP SIGNATURE-----

--lTgx9h43bP85ngCk--

