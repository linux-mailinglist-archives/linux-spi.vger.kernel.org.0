Return-Path: <linux-spi+bounces-7320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E305A71944
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A195417A1DE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09371F3BB2;
	Wed, 26 Mar 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxhotcz2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861B1F3BAC;
	Wed, 26 Mar 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000133; cv=none; b=h163KISYrxx5g3ZwPYf+DbVBIAw3UtgJSBtYqF4yIFoyKCkEs0MW3+emi3yDrgeAvU6Qjj885I49qqb/18gDrAlW7E7kV6TA1kyanVnWoVbOVehuFHV3tiR/9ZZq3hZDWI3+ezvRi59FC0viCGlRpgwONnqMIUMsGIrrFLcgy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000133; c=relaxed/simple;
	bh=Dyk+tSg/FQJ1Tiv4p0b3SWvDWFAEEatlceeuJ25kl1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeyDuYb6sFE+DulOJJKh42ERZYkYo5H26q23t5Q+ZCeuaptJaFtJK1jlu1oSwhS/WWnBJbfN0bxQoIE7VsmF8b//vSHSNpFpgG9v0EUJ64OF6EuiFM57xtEF/jYj9cTQLl5zsDUB0r4K0jFbQwsaAKPlT07tQ4bVryCLx32PyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxhotcz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93605C4CEE2;
	Wed, 26 Mar 2025 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743000133;
	bh=Dyk+tSg/FQJ1Tiv4p0b3SWvDWFAEEatlceeuJ25kl1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxhotcz2sMGqI/csayQvUfmEivYpMnZmOmKqCy+G/WF5w9VwF8PwrR0RWrIxJBygF
	 vbe1KlReyaHuIIvfvlm1RzBo4bjJiLDfeM/33MaXmMVEg9CijnkkjiFP9kohFiKB2B
	 4jVnc08A7ioHkVeLUUpjNrv3nfgxEXQ7tawLRJtj4OjhttYF/nG4TqMPaBX3PcIrwE
	 FEsDryj9/Hj07cV2dDszVxcvjRLexPvEyWhDeYfsOrAedEZFOFeAw4uJK6+vz0dU7P
	 Z4SkpHkhgcZCTRQ/gKmhKNHAz3wBvPncNsIYyQkBl+G0OM7CUO002/MxRUlKlGZ8eT
	 P2IMZRxW/v2CQ==
Date: Wed, 26 Mar 2025 14:42:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
Message-ID: <3aa2c190-ce4d-4805-943b-f65e98ce762c@sirena.org.uk>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YMz6PHeRr6110ohj"
Content-Disposition: inline
In-Reply-To: <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
X-Cookie: To err is humor.


--YMz6PHeRr6110ohj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 07:55:05PM +0530, Mukesh Kumar Savaliya wrote:
> On 3/26/2025 6:34 PM, Mark Brown wrote:

> > We should have a flag in the controller indicating if it supports this,
> > and code in the core which returns an error if a driver attempts to use
> > it when the controller doesn't support it.

> Have added below in spi.h which can be set by client and controller driver
> should be using it to decide mode.

> + bool        dtr_mode;

> since default it's false, should continue with SDR.
> I believe for QSPI, it supports SDR or DDR, but it's not applicable to
> standard SPI right ? So not sure in which case we should return an error ?

Standard SPI is the main thing I'm thinking of here, or possibly some
limited QSPI controller that doesn't support DTR.  It's not something
that should actually come up really, it's more error handling if things
aren't set up properly.

--YMz6PHeRr6110ohj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkEj8ACgkQJNaLcl1U
h9DczQf+IuYimvwoNmv2OV/WxcZYF+eVWn8NIpbmTbXJOkVIbQktDkbeSr+9WLoo
y/53GWXVRJ23P55zDZmKHmfWBPQy10Ni+5V5LoVc0CxbMTQWcORU7lY/Po7IPsoK
zGdkebpI+AwHywHtnA8whq2ysWKuuCbvdSm6tk7fZV7iJJMK9hUwCYJ6ygc7RScT
SCpFzPyYm2DavsSc5SKpboamYdo06HSGyxfojQ0bJuq7+p58bFSoGjyGD9RRuEBM
rqkOzT1y7nabKM9xtPkGGOVozrPe+36rRXIumckQEo43ivMxeOmzUVoVG9D7PU5m
nr0XDtJ8r9bEb77Cl2CL7huAM32RqA==
=Y40e
-----END PGP SIGNATURE-----

--YMz6PHeRr6110ohj--

