Return-Path: <linux-spi+bounces-3007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB88CC454
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27F21C21949
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591D13E03E;
	Wed, 22 May 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETSzzFqI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB013DDA5;
	Wed, 22 May 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392744; cv=none; b=auslO3q23Ef0jzHr782478xypICzp1iTUgE4H0md052FIE43dgBqE8QyIZN9/aNlYIePZblek7a/rDMktQ/QHlBq7kUp0xdaURSHlOvGI+sNyk7pBr5c5HcWFz7iaxULttyZIU9dBtYowjSViEY79PK8nQXe0otlPOVDXy3sCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392744; c=relaxed/simple;
	bh=ufoYxK1fyxQsCJ6E3XPZLUf38wiUDYwMD5+3HGtWjKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/Kg8BIwplxVIcBIDSJTySXQ+49mSxunw8iNqexXAKxRYUOcUPt+Ps839TQBf0SDTMtWY32nugvlp7PkfmJk0ZCS42TJ0r/m9GZx+cg6cpDLEzd7RWJFt2rnolziLvCC0T7FaFvNnFNwrKH2nZfVexmHUElgwsIyqCPos5xS57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETSzzFqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78512C2BBFC;
	Wed, 22 May 2024 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716392743;
	bh=ufoYxK1fyxQsCJ6E3XPZLUf38wiUDYwMD5+3HGtWjKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETSzzFqIS62XDL7IDh2iXP33WXQNjQ/0pq6ZDo4hEQUYqoS+cVKifkukR3BqfAvI6
	 dzzvy5xd9UvgNnVdetD372bCD8w4XzAD/L0F/DJCQVEZ2+kePdrBzspEQlwe4EnsSm
	 +3go6vrV0uwusgJ28UcXQ0/sBt2WuuuchnLb46Wpc4KmoqHHIS5Hom3ulv+QgMWaIY
	 vrtcDhLhGp6RX5DB7GsGBSEFF/dSAbNAuVxLRP4ijEyCjI6Ci3NUWEUF+ekh8Y0xGT
	 0aYL630Ki75pr+EUkaZ4j+7DVF3CyBjwWqem1mkIKWAHm08Uk8iz881y196RblqauO
	 ybF9z84xv31yQ==
Date: Wed, 22 May 2024 16:45:39 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into
 schema
Message-ID: <20240522-festivity-remark-8d6393fada17@spud>
References: <20240522132859.3146335-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mX0BiKdZerE2Ta4F"
Content-Disposition: inline
In-Reply-To: <20240522132859.3146335-1-robh@kernel.org>


--mX0BiKdZerE2Ta4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 08:28:58AM -0500, Rob Herring (Arm) wrote:
> The Marvell PXA SSP block is the same or similiar to the MMP2 variant.
> The only difference in the binding is the PXA version supports DMA (and
> that's probably a binding difference rather than an actual h/w
> difference).
>=20
> The old binding didn't belong under 'serial' as it is not a UART. The
> SSP block also supports audio devices, so 'spi' is not a perfect fit
> either. As the existing schema for MMP2 is there, just leave things
> as-is.
>=20
> The examples in the old text binding were pretty out of sync with
> reality. 'clock-names' and 'ssp-id' aren't documented nor used.
>=20
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--mX0BiKdZerE2Ta4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk4TIwAKCRB4tDGHoIJi
0hz4AQDqkrfj5lvbaIp9JRsRma3PhrCTRXlGlgrOV3oWp2RnywEAzo2us+p8Tf9D
pamFjR4bwBoafa83jLVuHKG1XTNyawQ=
=DLer
-----END PGP SIGNATURE-----

--mX0BiKdZerE2Ta4F--

