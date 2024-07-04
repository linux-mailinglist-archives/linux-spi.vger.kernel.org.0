Return-Path: <linux-spi+bounces-3740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE19276F0
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3B028671A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662C1AE869;
	Thu,  4 Jul 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc7fEjmM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3121B11ED;
	Thu,  4 Jul 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098699; cv=none; b=CX0UilF04VVmlCOodUkADki5xsk6zE3JJGnPLGBBLxAJwlq4OLC1xksMJvCciGIDJavAWxW47aFwatQlThfLFiD65dizciuBt2DFml2NgjIFN2UP0maF1FTcMIU2qhSEtjaEfKyenCw01cdHx08X8FuqgQNrR9bY+aNMEeWoWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098699; c=relaxed/simple;
	bh=7BAoLiaLL/CP5UsR3hVkgKAVWRJF7/BLbBMinxUKWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcRr584LJUo6Hgq53DNhhAr3YrhVdmfThTaDyREybbvTgtSY4mqWhaLp8iZ41EIaWSi+uX9IqcjUreiVO1Z0QM9MkxmgvKOderDYiAbvvYSfs0U/NUgc61GLvvSpWspmVsX6rNl4qEwCT3Hm8TplEVm5757icRKcYjG2neA6K10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc7fEjmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C91C3277B;
	Thu,  4 Jul 2024 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098698;
	bh=7BAoLiaLL/CP5UsR3hVkgKAVWRJF7/BLbBMinxUKWN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc7fEjmMJRYjby0rMTbsZtzl/s8iwM09Kwt98NqJHlLRbhgZvhQjMB2lU1fcoIWIP
	 dH8XYMGCFLNUDON1ibeO6fge+n9iMi7k/wseK2deag/fFHpG9tR1ekRpeVvqpBK/FK
	 sW9dmPnnWGm6ZDgcilH0C6t6KoQurgDDdmyzfdbROzbRi+64HZuD1v2dQLjCTlcir7
	 WNSUYh7s0jb9R/nl5IwHAYw1H+jhSWQYr3TQiJ1g5tVwsYW1Cmd72qpkPCnaBvDZfU
	 AVl9W6L+Ei3c1RvywpKFu24C4qFeFd/NgUboivV0WkmfAa2Zxv0WcMELBorX2CzszP
	 DVnRtdImeuP4A==
Date: Thu, 4 Jul 2024 14:11:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/7] mikrobus: Add mikroBUS driver
Message-ID: <f4d6f5e2-46ad-4df0-a364-a43566acef3e@sirena.org.uk>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-6-9e6c148bf5f0@beagleboard.org>
 <2024070400-grievance-unmolded-fa66@gregkh>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IInTQ2wNw1WV37i9"
Content-Disposition: inline
In-Reply-To: <2024070400-grievance-unmolded-fa66@gregkh>
X-Cookie: Today is what happened to yesterday.


--IInTQ2wNw1WV37i9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 03:06:26PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 27, 2024 at 09:56:16PM +0530, Ayush Singh wrote:

> > +struct mikrobus_spi_cs_item {
> > +	const char *cs_name;
> > +	u32 cs;

> Documentation?  What is "cs"?  More vowels please...

cs is absolutely the standard term for the SPI chip select signal, this
will be immediately comprehensible to anyone familiar with SPI and using
another term might be confusing.

--IInTQ2wNw1WV37i9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaGn4MACgkQJNaLcl1U
h9DAjwf/b2qzLV52mvbvH2US1HUCh7Priozuey+uqrxDBSxOlvBhMgliCc39kbmq
6yUq7U5DvsMoJsWfnSYKgcf45JajRF6Wn+VUBeqJHbo5nIEQ7qIkhZa3i26+R7EF
GNzuTESV+5oNGVKpPhjMZQa+46o1NRqfrcInsDMLXWAs0KD59Vz/AKo1KXCrR290
VsNgka/nhp9s2SvY012fTdh/hhVulHeZQ6uYMGyThFe0E8qM6X1/y3z0fIZslcbd
ZuSDbYB9QEl2yvO8DQCtb0cUWOM96yZSJVOQqGflzlhhoEAcn+Tud7F7A8M5Lv7e
b9JI0MJmNT5vtAX876aaUH6GVZKc3Q==
=iqWL
-----END PGP SIGNATURE-----

--IInTQ2wNw1WV37i9--

