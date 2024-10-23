Return-Path: <linux-spi+bounces-5323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133759AD397
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 20:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B2E282C7A
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC11C6F6C;
	Wed, 23 Oct 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiouI9v9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C8145FEB;
	Wed, 23 Oct 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706822; cv=none; b=YwnqpPbg5aDuWSPv06UBbaODFhL4m+CPTPSCH95IWuHv4t6HSAdNAgC0nx8YTZO9CmfiAgwOTd2jB626J3b9xR/TRed9EtBYIYFo4SuixHft+5XGtPcxMGklLbhIJSuj5SVyh6nmB14oqTQAGhzlIbX2w+iMyrgZxYatIZXp3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706822; c=relaxed/simple;
	bh=t0OsmiICNt3PxXJRiW8VMEDf2/PnwsW9vsZr+jws/Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx66CzR01Y1HbJrhLtH9qPuUZRln/7XmPhmXblBc/W1W3LMaqqUOz/zrYZd9+kN7I4YntUrRYhMqjxEr0NtZ6nrIRfNSf254oj4iHs/cu5Ax7EoC4SL8iSzdNhsCXG/dwoQVf70CrD+y9Ms0nSPhpHchWieHdAcvRzUSK/rm4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiouI9v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A779EC4CEC7;
	Wed, 23 Oct 2024 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706821;
	bh=t0OsmiICNt3PxXJRiW8VMEDf2/PnwsW9vsZr+jws/Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiouI9v9Pvi7W3bkD7Tqo9cyQz2D/bzL+ktiWg5kPpIOSpwmlHT7eStKkc4XNgAnS
	 LGrygm57mfWwm8wIVO4Qh192OagWGxpd3+kPh6BGTpwZhTs87KddblZ21BGpz/boS5
	 nmpUZ+6vnnNRTWFeMbRgqO3UZRikChuFGb6oo6LHIi2ZBMmlgDTObd5SRarUlYYVuN
	 PAelEwrHQnOcKEX2YL191HJDSgtvqYm+8r6KkMXG0p1sk953CUIPGJSMvr1vBzjCNp
	 g4x+EwlQa7QKOCM3XaYYpg6sTrN3a8XieKCBVaxhuzx9TKn1XTYVQTBEi6JFYpg1Jw
	 wEac8LYvCTfqQ==
Date: Wed, 23 Oct 2024 19:06:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org, lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Message-ID: <20241023-dares-december-d15da85e5799@spud>
References: <20241023120015.1049008-1-festevam@gmail.com>
 <20241023-irritate-veal-0423be9e4c45@spud>
 <94889e08-07b3-473c-9f52-bdeb5d1fd822@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j7TgCwvpalwdyGNy"
Content-Disposition: inline
In-Reply-To: <94889e08-07b3-473c-9f52-bdeb5d1fd822@sirena.org.uk>


--j7TgCwvpalwdyGNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 06:33:07PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2024 at 05:37:29PM +0100, Conor Dooley wrote:
> > On Wed, Oct 23, 2024 at 09:00:13AM -0300, Fabio Estevam wrote:
>=20
> > > +  fsl,spi-cs-sck-delay: true
>=20
> > > +  fsl,spi-sck-cs-delay: true
>=20
> > Why does this have fsl properties? I figure they're taken from the dts,
> > but spidev doesn't use them, right?
>=20
> These are controlling signal timing and implemented by the SPI
> controller rather than the device - they're the timing the device
> requires.

I see, thanks.

--j7TgCwvpalwdyGNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxk7QQAKCRB4tDGHoIJi
0h0EAQD1+zRw8ot+iuFqLVv2zcnuAUM8wlHyYJ6GMSQncEgR0gD9HByTJCTh64tQ
YBm+SGM4Hx7Rpsv9M4RsHAlsAgT8VQg=
=iPz7
-----END PGP SIGNATURE-----

--j7TgCwvpalwdyGNy--

