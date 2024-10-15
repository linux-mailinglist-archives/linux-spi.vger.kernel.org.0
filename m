Return-Path: <linux-spi+bounces-5238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B627B99F810
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB33287302
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789241F8184;
	Tue, 15 Oct 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1TE9Wr0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C11F585D;
	Tue, 15 Oct 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023942; cv=none; b=HH8Aor5MpPizrPrgjw2c3OXGFX4InbYn0vtPhMgnLef8NUu0Ov47zQUzSAmXY7EHBtmluUTDyi58L3JGHtg08BYt9qRb1O7+UBedwFb0dts2wR82753BaAh+KM4l0wBzk3kPzJ9PDF5zWCilZVnK5/IdlaonjhRZqVhU8U3Y1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023942; c=relaxed/simple;
	bh=nsd/upD+9R74nEL0M6h/FKKkDQ+u0zpHjyKAGpKw3LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naf3AlM9pgAsbNzmh4YiurNB2RBMynrWfRlfbdVtnC+P+DTpv+nhZQAQ1p0lRYUwb6778HXO1NhiVjjC3p3GN9G3UH7aWHnw4naT3LnYFtHZQAjMgmirPPfAGpMsnqXG9m8RAPVWz9SVV64tJIVOBmjMN/pmsfVKD+I7FmSjhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1TE9Wr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE55C4CEC6;
	Tue, 15 Oct 2024 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023940;
	bh=nsd/upD+9R74nEL0M6h/FKKkDQ+u0zpHjyKAGpKw3LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1TE9Wr0Ag+ZkEAhO8vxdlz9AwjITwCqdk7Lr2r12iD59JBz10Q8UlxCxuqdnBV01
	 wSY/gsP/5OalZwTSBvnY6UrgBcTSOUxOZIxjXXAOzWImTzRcVRtU1IBFxqAxfJmDaC
	 2M3BMuKtjPfIBTtk+JCALdiIWrBs3LGjgv3tVBk+VQZYxoRhvnpL+xRGva5VbFK4PT
	 +j0yWkLErF3vAK0HzmM1HC8cCyYkRqAv4lHW7l+YFBxJEW2cvLiC5Zk/cQ7twIwizX
	 JeSXhtqL6XDENfm0pyMvkfz4SJDlAbqtvyMsG/CP8dm9sUE2962FGuuwqji+leHywk
	 5jvQppQg5XmGA==
Date: Tue, 15 Oct 2024 21:25:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: krzysztof.kozlowski@linaro.org, bcm-kernel-feedback-list@broadcom.com,
	broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	rjui@broadcom.com, robh+dt@kernel.org, sbranden@broadcom.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] dt-bindings: spi: Convert bcm2835-aux-spi.txt to
Message-ID: <20241015-proactive-backlog-b77c42eef79c@spud>
References: <09826ffb-b7d1-4244-af0d-854f1f0339a1@linaro.org>
 <20241015180906.8464-2-karansanghvi98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FBBz714teq+aCQWZ"
Content-Disposition: inline
In-Reply-To: <20241015180906.8464-2-karansanghvi98@gmail.com>


--FBBz714teq+aCQWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 06:09:07PM +0000, Karan Sanghavi wrote:
> Converted the brcm,bcm2835-aux-spi.txt file to
> its respective yaml file format.
>=20
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> v1->v2 : Made the necessary changes in  the yaml file=20
> suggested by Krzysztof Kozlowski
>=20
> v1:
> - https://lore.kernel.org/all/Zw1Oj1utiBJ9Sosg@Emma/

I don't understand this patch. How is it converting a text file to
json schema when all you're doing here is deleting stuff from an
existing yaml file?

>=20
>  .../bindings/spi/brcm,bcm2835-aux-spi.yaml     | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.y=
aml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> index 4c24cf2fe214..f83f71ba78dc 100644
> --- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> @@ -9,8 +9,7 @@ title: Broadcom BCM2835 Auxiliary SPI1/2 Controller
>  maintainers:
>    - Karan Sanghavi <karansanghvi98@gmail.com>
> =20
> -description: |
> -  The BCM2835 contains two forms of SPI master controller. One is known =
simply as
> +description: The BCM2835 contains two forms of SPI master controller. On=
e is known simply as
>    SPI0, and the other as the "Universal SPI Master," part of the auxilia=
ry block.
>    This binding applies to the SPI1 and SPI2 auxiliary controllers.
> =20
> @@ -21,7 +20,6 @@ properties:
>    compatible:
>      enum:
>        - brcm,bcm2835-aux-spi
> -    description: Broadcom BCM2835 Auxiliary SPI controller for SPI1 and =
SPI2.
> =20
>    reg:
>      maxItems: 1
> @@ -30,8 +28,7 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    items:
> -      - description: Reference to the auxiliary clock driver for the BCM=
2835.
> +    maxItems: 1
> =20
>  required:
>    - compatible
> @@ -53,14 +50,3 @@ examples:
>          #size-cells =3D <0>;
>      };
> =20
> -  - |
> -    #include <dt-bindings/clock/bcm2835-aux.h>
> -    spi@7e2150c0 {
> -        compatible =3D "brcm,bcm2835-aux-spi";
> -        reg =3D <0x7e2150c0 0x40>;
> -        interrupts =3D <1 29>;
> -        clocks =3D <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
> -        #address-cells =3D <1>;
> -        #size-cells =3D <0>;
> -    };
> -
> --=20
> 2.43.0
>=20

--FBBz714teq+aCQWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw7PvwAKCRB4tDGHoIJi
0vaoAP9i8RiGMTdEG5XMDG3fcn0dODkCjLTFsR/WYBTGhLAT2QEAhnXEtD3vMery
tLiiBJIWDvIldsUnJW7klOI1Ubde0g0=
=db74
-----END PGP SIGNATURE-----

--FBBz714teq+aCQWZ--

