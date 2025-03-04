Return-Path: <linux-spi+bounces-7018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9823A4DDBC
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5F17766E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F121202C4F;
	Tue,  4 Mar 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBZa+w2L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32831FFC7E;
	Tue,  4 Mar 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090860; cv=none; b=iLTPjKuOWoplvnMdS3saHfRMSRy+PUXHNwsf3LcZF+QGwZTE/yyLaaIwCdCBebnP7XXMnbE+KPI/AsB5g65hCBFVdtUqn3PRNyY9g8F9rEjGFkFvMG0OYlU9cPXL6/JKU10FLm7atdX9HQUXXzOf4bifq0N2heQ8dqFK1X9MJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090860; c=relaxed/simple;
	bh=taClQ70iXUCxoBxQy+spoV3xp0cK5c2B/aMQ1g+Bskc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6Vue/xownHuV7xJAOzV7Mm8MeQcVPcnqGVjLCqfHaDrTJfIzhAYt373bIeogZJurdg9fo13WhMzc/IILU6VHNEYXsV1jcaVlSXGjDIu/ZJsA+pQ3qXREYu9XM2PQFP+eU76E8kOwAcRWh8t8Ir4WfVk98oBj3VChijDk0A/Xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBZa+w2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEAEC4CEE5;
	Tue,  4 Mar 2025 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741090859;
	bh=taClQ70iXUCxoBxQy+spoV3xp0cK5c2B/aMQ1g+Bskc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBZa+w2LbNsESgBAPZX6UEPhovRhFX5Tc+R52ZiLfaEi5DmjRmhvH+GRRx9IB/rv6
	 4YXeu3MiDZblvKq44oil0/bluQXnpATS37rslyPOfYiJHN+tdeOR1EScqyNH/A94G8
	 H/qkSacFKTTpNKScquLNMilB6iDr0gbjVkSUOlP1unsyleeIebeR35+9tCK2JVMCNM
	 Ld0FyKkcTIPSEXmDXYvMF+IY9GqsEVk07wg9QYS7jrGWNzuu+pmB833CgFA0irDmo0
	 DzGSH0aySFcWtQ54uMjHf4iUAOzeTdcncPi8Bog/zcOSHwDdftIvJ3XlLeMhQRT7ef
	 q54c0BN9Nxdhg==
Date: Tue, 4 Mar 2025 12:20:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
Subject: Re: [PATCH v2 2/2] spi: sophgo: add SG2044 SPI NOR controller driver
Message-ID: <74a0cbdf-d303-459e-977a-2be1a6c9d274@sirena.org.uk>
References: <20250304083548.10101-1-looong.bin@gmail.com>
 <20250304083548.10101-3-looong.bin@gmail.com>
 <AM7P189MB100970D57C974DD7CC5DB156E3C82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54Oj86wu4iRnfpKp"
Content-Disposition: inline
In-Reply-To: <AM7P189MB100970D57C974DD7CC5DB156E3C82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
X-Cookie: Do not disturb.


--54Oj86wu4iRnfpKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 10:14:14AM +0100, Maud Spierings wrote:
> On 3/4/25 9:35 AM, Longbin Li wrote:
> > Add support for SG2044 SPI NOR controller in Sophgo SoC.
> >=20
> > Signed-off-by: Longbin Li<looong.bin@gmail.com>
> > ---
> >   drivers/spi/Kconfig          |   9 +
> >   drivers/spi/Makefile         |   1 +

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--54Oj86wu4iRnfpKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfG8CUACgkQJNaLcl1U
h9DOQgf+OsNrZsX/GHTkpQKuxufWPNRty1/mIYWBycNxDjbSbZiY+WW5d6Fk02kn
hnr0S0ij9L2cHr5tPo1PuDuGHZlzaYgIpW9cUcN8jzH9dmMpUFN9i+idwW1Fs5Rh
OM1AwzX4tTG8AwxRxXf4VvkMnErnIuNSbfmXX0zJJHFodbOPH8E8z6JaI6uCwdpG
miC89wz3PNXKOs5Z9X1lVFP9sTuqgsVyFFOXxVjciqJmXkrPhB6d4p9lqC+k49UV
ak64KOr+wKGgj8qaVCifbcZJFYp5naHizOSCa8pYgNzoNB9oqYsOqX9kODPgesC2
a0NLs2CyfcbMKLXco2+SWo2461KDnA==
=/APl
-----END PGP SIGNATURE-----

--54Oj86wu4iRnfpKp--

