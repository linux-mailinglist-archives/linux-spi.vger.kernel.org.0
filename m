Return-Path: <linux-spi+bounces-11097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9ECC3CF6F
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411CE428153
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A234FF79;
	Thu,  6 Nov 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbP8H4uc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09207280033;
	Thu,  6 Nov 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451430; cv=none; b=DStcsTzKx52M1W7/3iofbAMmBpJuPAuoG4+vBus+5pL+MBwbYOhRwkaC12gOaAQLv5MUtzl+lxg8IJo+62P9wgMK0cHP8CyMypLwFYIknAnEXVUtX7lI3E9PhUITngYH4XkGX7rsofNSqwCiiBPRxhq9hGuJ8BeOTmeEbpIES0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451430; c=relaxed/simple;
	bh=WjWTvbzua2LgYAaRJe9lhFBkACy3GRXIKF3t5etpTx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3pqnwx4/flSHk7TN3XApnMcrYPv2TKk0A9RCBUlNjHuLlJ3Sjx12j40zWwYOsB6KF/hT8DvifMnEqWg4SjbYSIJ5kSMj4xegZs52vCy4st0ju5ORdLj2xahJyALMozaHnWGZB+JlgBHU34UOzgOkOwtOj0LDUB0D4SRxn9u8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbP8H4uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE47C4CEF7;
	Thu,  6 Nov 2025 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451429;
	bh=WjWTvbzua2LgYAaRJe9lhFBkACy3GRXIKF3t5etpTx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbP8H4uc4//Q3JD9skD/NmChmp1R2f45h81QKbBzJv8eP5/t8LI5jfVTixIJFk9A1
	 E9D9IKlGLveME0Myu4Sroc2KKth/rYvfaceRD165Zgm3N+MNJotluAJXyJNUgTwnMB
	 3vek/s3C/u0rg3xd7NuwmAA2MMzirKLcV3RccjBahJMzmJQuMZ+cyS2SKpLPvMEHcE
	 v5KGjPPOFAMOiiPuNVwNiO62+Jqq+leGtR69ZvVjtAR4DzdqNPLsfdQxBzakDCXW5k
	 OneQzIti6WpF69yRelVNW+PJ0t/XbOwaJBFCYWNUrbIyUbKALQZMgI83GsYe9F2gIT
	 ZVDuDx8UDODWQ==
Date: Thu, 6 Nov 2025 17:50:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v2 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <20251106-cable-generic-819b798c7068@spud>
References: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
 <20251105152823.730422-4-prajna.rajendrakumar@microchip.com>
 <aQt41uGfmbs7Qa7x@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wJgqZzsyNZ2n1zkq"
Content-Disposition: inline
In-Reply-To: <aQt41uGfmbs7Qa7x@finisterre.sirena.org.uk>


--wJgqZzsyNZ2n1zkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 04:18:30PM +0000, Mark Brown wrote:
> On Wed, Nov 05, 2025 at 03:28:23PM +0000, Prajna Rajendra Kumar wrote:
>=20
> >  drivers/spi/Kconfig              |   9 +
> >  drivers/spi/Makefile             |   1 +
> >  drivers/spi/spi-microchip-core.c | 442 +++++++++++++++++++++++++++++++
> >  3 files changed, 452 insertions(+)
>=20
> > +config SPI_MICROCHIP_CORE
> > +	tristate "Microchip FPGA SPI controllers"
> > +	depends on SPI_MASTER
>=20
> Reusing the same filename and config symbol is almost certainly going to
> create issues and confusion for people upgrading their kernel or doing
> backports.  Perhaps CoreSPI instead?

The qspi driver (which is shared between SoC and FPGA IP) uses
SPI_MICROCHIP_CORE_QSPI, so probably SPI_MICROCHIP_CORE_SPI should be
used here. Prajna?

--wJgqZzsyNZ2n1zkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzf4QAKCRB4tDGHoIJi
0qy2AP0U27WzBNDqaqh1XmP2VC+xajyfZyfQNxJNz2WHKaXRgwEA1kY/wCnEvIlC
SYkV1jsJNg638yrXcon3wRQFmAch1Q0=
=FvLK
-----END PGP SIGNATURE-----

--wJgqZzsyNZ2n1zkq--

