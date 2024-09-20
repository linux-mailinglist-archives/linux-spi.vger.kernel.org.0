Return-Path: <linux-spi+bounces-4892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204797D298
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CBC286C8E
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D513AA27;
	Fri, 20 Sep 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koicdA8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211280604;
	Fri, 20 Sep 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820542; cv=none; b=RPI1iCLKt5v3WASct9ru75Lbfq6AMxBrAc+Tk79uMUGR/dks9dM8MWR6iAYNjk9h4Pz1jBeDho2AS9MoGDR+7yiBdYfdjVbRMzpUX99oc0aTdL17CJPnsjHNiklyJn9hDn7V/3vzTmv9DcgGmC25OyRoU/4K1PjaFMY3ejPv8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820542; c=relaxed/simple;
	bh=CGYWgsYvHo7ITiau4tlbFsj0X9C4MzBSsji/WzgrVlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpgNJij1zA50Elb/s3KJ4U02dw74wbZB3cmUXGSgS5rKQWC4E5lNOwUjTDtQIN4cx39jZ/VZhR9Ibh9OvDEEvNFuKLPADRUQnfU7/yi2L9LdfZl5s1HoQ+pcfUK85m5w3UqBN0N2eczszpVauTs/LwyJq+/NbfbbczFk+aw1kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koicdA8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7BDC4CEC5;
	Fri, 20 Sep 2024 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820542;
	bh=CGYWgsYvHo7ITiau4tlbFsj0X9C4MzBSsji/WzgrVlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koicdA8QX3TN+2n9mTSiPZRVEzS1VkA0WsFoioMSZVLIDXMgMeDWbz+srMW/HHyCx
	 FxqTLflcSz+047AMBH4bEeUZfhMzO834n3atF/2iZbFXoWSLwVDxmwlyEsmvXOsKeF
	 mJTRl9wRiK73LP+Uzgsfk9kFLq6XvsXkXloNNoo70aYcPFz+a+mKlr3jEZ/g4cTGLG
	 Pqtzx9dt1TH/mOyyuvYZLEsHDp2wOgzvCMQ/WQK8AmqBwXh+qrxCVYtNrQ3XCjcG2L
	 SL7qNYRKmO84AtSyZL17SFrvdFvIN+iqLtJMB0A+VvebS6cpq2dR3EMQeX6oHNrevM
	 +NJ/pjO3s4sNQ==
Date: Fri, 20 Sep 2024 10:22:19 +0200
From: Mark Brown <broonie@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: atmel-quadspi: Avoid overwriting delay register
 settings
Message-ID: <Zu0wu99Hxb-b5Xo1@finisterre.sirena.org.uk>
References: <20240918082744.379610-1-ada@thorsis.com>
 <20240918082744.379610-2-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AbZ+Ny3EXg+uflXy"
Content-Disposition: inline
In-Reply-To: <20240918082744.379610-2-ada@thorsis.com>
X-Cookie: Editing is a rewording activity.


--AbZ+Ny3EXg+uflXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 10:27:43AM +0200, Alexander Dahl wrote:
> Previously the MR and SCR registers were just set with the supposedly
> required values, from cached register values (cached reg content
> initialized to zero).
>=20
> All parts fixed here did not consider the current register (cache)
> content, which would make future support of cs_setup, cs_hold, and
> cs_inactive impossible.
>=20
> Setting SCBR in atmel_qspi_setup() erases a possible DLYBS setting from
> atmel_qspi_set_cs_timing().  The DLYBS setting is applied by ORing over
> the current setting, without resetting the bits first.  All writes to MR
> did not consider possible settings of DLYCS and DLYBCT.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Fixes: f732646d0ccd ("spi: atmel-quadspi: Add support for configuring CS =
timing")

This isn't actually a fix AFAICT since nothing yet sets any of these
fields?

--AbZ+Ny3EXg+uflXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbtMLoACgkQJNaLcl1U
h9CuKAf9EnlkCetJ+PrdusHNMj28alBBuDa0vQ3WuM76Gveg3QBRqSBH6pdLONE6
EUlgrri8xy58LbSmLVHNXREIsDs+zUjgmL3R7D7FWsHe5o+A/nIEARALKbYXwtY7
t4wH6Aajryk18S1Qfy2lusizODgey9GuI46FzCLLA0OFmU4O5S03VMJu69vJF3fv
ZgaLWbERJ2QVxoe8OjdxCJmGukee6kq1iWSat9oAnDOF5T4lesa4MyIuKGJRvpn6
lPPt/aHdOgcMltduSOpQZ2oY3ADJiN/i8QNle6yZHQOIDQegiT5+yUZUrkUW0Q5V
FMz1IUQXC/l8DBMpUjhYID1Axeok7g==
=iwlT
-----END PGP SIGNATURE-----

--AbZ+Ny3EXg+uflXy--

