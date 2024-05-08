Return-Path: <linux-spi+bounces-2784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4468BFC93
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5633B21F0C
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C3824BB;
	Wed,  8 May 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtgqzpIj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED3823C3;
	Wed,  8 May 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168796; cv=none; b=aD7fDByacJMlKtnj3CR58amHyOv7PaJbqZfz3gBlbp8rvVz3EXeuzOurqzYfr4UnoihMe2BJBTwPTCJ8XUbMuQaGxrBH4RG8Dim/I+XYAgPqitmrKbxYfSGzIOrxs6WXcuhzpjV01UL2wNK/FFMWKtL7FhlZsggOno8QaMY9EvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168796; c=relaxed/simple;
	bh=TyI9PDUN23refC5Yl9B3tTTd61cXkwqe/5CzWO9+Ja8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvjyzxfVGo480qKx7zxBI7fJD7KNTao8JsHR1xXemxf2AtrL0UD9et8yXZadGJXb9aZAPOcDzqp8ubU6jrQYa3bHW0Mo6dyGr6m559q6wfWsS4lWR2B7cp3qDPooKqsiHE2hbPOwlW7rQ+Mma1JAp2dUlySoaL23Rr5NqfeqwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtgqzpIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64463C3277B;
	Wed,  8 May 2024 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715168795;
	bh=TyI9PDUN23refC5Yl9B3tTTd61cXkwqe/5CzWO9+Ja8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtgqzpIjFXC+l1oBCLqKEUaaY805cb13bUVRM7Ctsqpjm3TMb1UNdY1TBkjsfR0fh
	 8Sg+YFrv8dGcEMBjR9G0ppEpNlzuNXo55nT+adqsIiszTlwtXM94ySZoXvUgATbqYq
	 jZRooDptxFG1hYbeLLhPmfAKvNCl+jqM50ru88bDpoeUjiGWmH8jCPYusyzps68p/T
	 jgLlLTaQPgmV2voo4qDSDGkyiUKbez/y2vyW0NC6/2T17MGx6YmbK3Ay4xICI+SuVg
	 1bLFXIV1DiBOcRrnBi7WuvjBrqvMKe9//JQCCJ30Yz7B0+UDlfC7eSUjOQ4Wn9259g
	 FgfAPa75Co8zg==
Date: Wed, 8 May 2024 20:46:33 +0900
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>,
	Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Message-ID: <ZjtmGTRce1605Cc0@finisterre.sirena.org.uk>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
 <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
 <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
 <2dc18bdd-0c82-47a2-b87d-b69028f3b251@linaro.org>
 <CO6PR18MB40988BB723DB7576F5C25155B0E52@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or8cy3D/AkHUwjHd"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB40988BB723DB7576F5C25155B0E52@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: Accuracy, n.:


--or8cy3D/AkHUwjHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 08:04:49AM +0000, Witold Sadowski wrote:

>=20
> I have come up with solution, as I wasn't able to find similar function t=
hat
> will work with ACPI and dtb on the same time:

The usual thing would just be to try both an ACPI match and an OF match.

--or8cy3D/AkHUwjHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY7ZhgACgkQJNaLcl1U
h9CDcwf/YEDOkFv7u+d6NHQPNN4I08X1iuI+znmRZ2CrWTp46NeDTqkU3Xa2z4Hz
gMwJQ5NlIZCiK5hYKQyuNqQUcZgMp/5RSygz4WeRhCeNOTu+Zv6WUDygJzIf3sfe
doGB2Va1FWvYGa8rPmaZsh4nhv+8NgcbVATzt4v0pYGfO473Mkvj0qDGSmF1o7Yn
Wx4TQxk9//8Vj5H3XWCW+vcx7+9Z1sq6ZTphvhwRDIWEBc37G3Tufu+5Z9CS9a81
/w0XnpZa1dTt4S+w95f0k9XN8YioDxVdOAVZ4UjgOnSFcrT63JWY19mRxPYk5jHU
fndYdIC8y//lvoMfx2xxjge3S/Hu0A==
=MFOi
-----END PGP SIGNATURE-----

--or8cy3D/AkHUwjHd--

