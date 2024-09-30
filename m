Return-Path: <linux-spi+bounces-5049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2398A66A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1C1F2484F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF90194AE2;
	Mon, 30 Sep 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E12aNqjc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C71946AA;
	Mon, 30 Sep 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704540; cv=none; b=h7sL1NWtdrGnbucwKj/aYcQEgW7j5tHWGGQ/zg3mySzzWtK0j803OrepPvZlGN6lGY4Ji9c+h+WWpVU6aXWtYLGFwh6i99UZks5+3mJXYzWLrMWBi41YDUknnHh/s3ail8Egrp6474JlCWVKVicy4MwWenIf1R5SxoLGIFEr500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704540; c=relaxed/simple;
	bh=ptvZUoo0MgvQ1nTdeXK5Y63HZLuZe59ZXon7TP2l7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwtBRPzUfzDplApKAcjEm6Obt7j84tojH0elT5KmVo+Or10krAiiWcvxUklpso6KEdHeyvT3PquZBlJg1ryGhpJBFy+wxVlj4C6GHNvIb2+pstS1kuYhBru8Ks1ySbwElQStQ4uxWnFYEu3mJV1lupEbS5GR9PaEo5Q8P44rY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E12aNqjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B61C4CECE;
	Mon, 30 Sep 2024 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704540;
	bh=ptvZUoo0MgvQ1nTdeXK5Y63HZLuZe59ZXon7TP2l7Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E12aNqjcGXGEqGtu70phFW23PXMtikHIp/VbHVu6wHFiiEbXVgs9SyWa2getrm9km
	 uFbsr2lHuatpMybul5LblXdlPW+eN1NYvAt+Ab3jHKByzaRa2SjChPJ/Ux+e1+CgI0
	 1Rm4TVZIX1Uc721vnfNs/UqI3PVavTgLrtTd9GVO7E/62jvAjng0MJK7TAh8kxhmLV
	 pxplUZgozK7A4J3KBXQZEccM6iu1ULZfrTOEzmWHNH1ED8FiO3puc2ZllIlutiD+ga
	 e4upgx13tvcPFTOEED8fBdeK4t73UBSzh08o5gowuusDm73irlPFu55VP3hlwwNTPy
	 c5aJaNcdtKYVQ==
Date: Mon, 30 Sep 2024 14:55:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: pierre-henry.moussay@microchip.com, Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 04/20] dt-bindings: spi: add PIC64GX SPI/QSPI
 compatibility to MPFS SPI/QSPI bindings
Message-ID: <20240930-safeguard-shiftless-c10dc8fbd99b@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
 <1f54805f-f06d-4732-a124-270a36dbff4f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6OmhXQ4y09svNlZJ"
Content-Disposition: inline
In-Reply-To: <1f54805f-f06d-4732-a124-270a36dbff4f@sirena.org.uk>


--6OmhXQ4y09svNlZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 02:52:42PM +0100, Mark Brown wrote:
> On Mon, Sep 30, 2024 at 10:54:33AM +0100, pierre-henry.moussay@microchip.=
com wrote:
> > From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> >=20
> > PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI, just use
> > fallback mechanism
>=20
> You've not copied me on the rest of the series so I don't know what's
> going on with dependencies.  When sending a patch series it is important
> to ensure that all the various maintainers understand what the
> relationship between the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or at least
> copy them on the cover letter and explain what's going on.  If there are
> no strong interdependencies then it's generally simplest to just send
> the patches separately to avoid any possible confusion.

FWIW, you should be okay to take this, there's nothing that depends on
this patch other than dts files and nothing that this patch depends on
in turn.

--6OmhXQ4y09svNlZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqt1wAKCRB4tDGHoIJi
0kscAQCZswxskpBaL15Yd5hzVUiS9tA3udzdql+Afls0sLewlwEApcpfrwV2F7tu
PyJvxazlLMCl2+a+nJ1o1mnanRGHmgA=
=/i8D
-----END PGP SIGNATURE-----

--6OmhXQ4y09svNlZJ--

