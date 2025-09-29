Return-Path: <linux-spi+bounces-10357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64FBAA65E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3523C659B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30C223DCF;
	Mon, 29 Sep 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDVFG/IN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5CDF6C;
	Mon, 29 Sep 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172547; cv=none; b=OJIEUROWEXZCWp4XoVHrOQL2uCih1cdhhWlG/jlPrTjWRT/w48hchYWEb9jyNHbxNxe3+4PC+wrPRSRm+6X9V04x81zhIyVP3BmkGwq1DB+zT/Al0DIcyfot+d+HU/QmEoG4vRYNzjn8ZElHnv7yU9oHY7M1qaFL2jjcVZ+chx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172547; c=relaxed/simple;
	bh=TaNbswUN7kemg0rLelKfMXHHEoipTDTxzGX1f8BKGBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdMy2CXYlBpmdSDuPbF2YnUWIJBoXATorF/0ZonVYfpG8bSN2IGk5aGN8+pDtf2AAYZ9S1ezXu/VseOLDuGczv2ejPxvyc2blnNISOlePTaiJsNmKu6T3B1u1Ps+bszFsQ4nrtxB/TcXR8yGJNla7qsRjaS4CjgU+yJ79D+mKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDVFG/IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7A3C4CEF4;
	Mon, 29 Sep 2025 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172546;
	bh=TaNbswUN7kemg0rLelKfMXHHEoipTDTxzGX1f8BKGBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDVFG/IN27SAeZxCnijPFCEGUtTAWPtheZIEt10N+N2M7hxTLeAnWjPEvtgoi7fgk
	 /ouCWwoxD0OZm5rrVDBvjVFPE3V6+GWmk+SMqjtOzRHPShZ1rVaChBArHMfgrR/S6I
	 Bx9jueC8VXj2KIaRSlACWFWgXPiiyFaivhNS5R4Ia6dD185jVKnR6UfJz+4W2XwDqT
	 yvxPYF353/64Mlsb9nSt10xzd1oToMGW1TfvTle6KKa09zRPXfwTJLSB/fs0OLSGx6
	 GPasGuBwkb4Ma2ZGu1KY4lFFFQj8LemSNATnjU9RwQ69iNf1trEhtSKICG/wkUV9Sh
	 I25CHfr2P1p0A==
Date: Mon, 29 Sep 2025 20:02:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entries for the Axiado SPI DB
 controller
Message-ID: <20250929-cosponsor-flyable-86e17f33dc46@spud>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
 <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-3-b0c089c3ba81@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPARSlYnkJJMkqR7"
Content-Disposition: inline
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-3-b0c089c3ba81@axiado.com>


--LPARSlYnkJJMkqR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 01:58:03AM -0700, Vladimir Moravcevic wrote:
> Add the MAINTAINERS entries for the Axiado SPI DB controller.
>=20
> Acked-by: Tzu-Hao Wei <twei@axiado.com>
> Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef87927041f5cf58d70633dbb4b18d..4fa4b99661b37b161e4326526=
e0c5049cf24691a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4130,6 +4130,16 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>  F:	drivers/pwm/pwm-axi-pwmgen.c
> =20
> +AXIADO SPI DB DRIVER
> +M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
> +M:	Tzu-Hao Wei <twei@axiado.com>

> +R:	Axiado Reviewers <linux-maintainer@axiado.com>

This email address is not fit for purpose. I got a mail from your
postmaster saying:
The group linux-maintainer only accepts messages from people in its organiz=
ation or on its allowed senders list, and your email address isn't on the l=
ist.

I think that's not what you want for a generic public facing handle.

> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
> +F:	drivers/spi/spi-axiado.c
> +F:	drivers/spi/spi-axiado.h
> +
>  AZ6007 DVB DRIVER
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-media@vger.kernel.org
>=20
> --=20
> 2.25.1
>=20

--LPARSlYnkJJMkqR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrXvgAKCRB4tDGHoIJi
0tSXAP9l9mzgZ6gDtDK9Y5Z4rOXGlZ7igzbY8Dl74s+oqSJt2wD/Y9M5IYmY6DL4
xAPJg06NeH44KujwVSGcfRkL/0SF4wU=
=Q97q
-----END PGP SIGNATURE-----

--LPARSlYnkJJMkqR7--

