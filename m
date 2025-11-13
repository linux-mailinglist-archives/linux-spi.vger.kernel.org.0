Return-Path: <linux-spi+bounces-11189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752AC59CA1
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 20:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A804E4A66
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522E31D751;
	Thu, 13 Nov 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVo5395u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDC31B10B;
	Thu, 13 Nov 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062585; cv=none; b=uxl5lA3hN53bAz5YpVkg2yxNhnI00/5oNw2mKAqsY9Rgr4RC4S5v5TStTFmGHZt4R5LWogQz4Ie7FLoLV/LhoG8Rhj4iHaM0HOR6W4+SQeHiCObfg86Q/cKQ8UAHowRWExPienJZtxUv8P0q5XliHJUN884ciJiyVM9VCT4BVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062585; c=relaxed/simple;
	bh=OUQ+Qmgs7ku22AW5gxYYNj5W9qbgTRyidFX1ThPc08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZjH3/5lYvv3DJQgGwnPSTxjV2LhEJ3CiTsHqHhaiGgUQppcpq64VPWiG46EeBK7aDezXmRiawfho3RV0tMx92ylEmp+dx6LnmiKeRI8hy6Z1fiQ8wAirLxC29xXLEATtAVjuau5uO+vDV2EAFAjWokCcdeC3tlo6ITI+jUh4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVo5395u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EAC4CEF5;
	Thu, 13 Nov 2025 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062584;
	bh=OUQ+Qmgs7ku22AW5gxYYNj5W9qbgTRyidFX1ThPc08Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVo5395uuWVkGDkpQEn4MEn43J6l9a+VMxco++53CmD15eZPSt9Ip6/9SLG9XruF5
	 GVFH3+fUSYwGzKI5/V8g1PLnc2vK4qkCt2F5Y8zjVavMmASmJ69d6YuBSOl8IsNFlZ
	 VGfQgRXxVAOpPadLloiVmKEierKsdndDvxomHfGzjI5vE5ZXR8bYt6XemLEMnVf8+T
	 heiYU2s4fwklhs5rVDpO0e9zowxf9NgZvx2CwS7YbL9ziWtOBDlngJCKhR/7cndQoZ
	 e2Gjn1ELU9XgKPgBzh3lcOdRhzOeiLHvjYg13zTvW1Wdu+uZja9/eLxK1qeMxuBV6C
	 4Z+xEHCc26R7A==
Date: Thu, 13 Nov 2025 19:36:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org,
	clg@redhat.com, broonie@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700
 SoC support
Message-ID: <20251113-reroute-backlit-b2e1d1b6dc04@spud>
References: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
 <20251113085332.89688-2-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LS0ZL1mlvV8tsXyl"
Content-Disposition: inline
In-Reply-To: <20251113085332.89688-2-chin-ting_kuo@aspeedtech.com>


--LS0ZL1mlvV8tsXyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 04:53:29PM +0800, Chin-Ting Kuo wrote:
> Add AST2700 to the list of supported SoCs in the ASPEED FMC/SPI bindings.

Please add information here as to why these devices are not compatible
with the ast2600 ones. With that info,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>=20
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yam=
l b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> index 57d932af4506..80e542624cc6 100644
> --- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -12,7 +12,7 @@ maintainers:
> =20
>  description: |
>    This binding describes the Aspeed Static Memory Controllers (FMC and
> -  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> +  SPI) of the AST2400, AST2500, AST2600 and AST2700 SOCs.
> =20
>  allOf:
>    - $ref: spi-controller.yaml#
> @@ -20,6 +20,8 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - aspeed,ast2700-fmc
> +      - aspeed,ast2700-spi
>        - aspeed,ast2600-fmc
>        - aspeed,ast2600-spi
>        - aspeed,ast2500-fmc
> --=20
> 2.34.1
>=20

--LS0ZL1mlvV8tsXyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRYzMwAKCRB4tDGHoIJi
0hcsAP9GQ4eMq05L+q3QOeYKmFSX9l0RK7CzAFAaEFVK2vQKoAD/cOZK1QxP2nV7
sUnhA4Tv0TcCZ4ixDmGcDKByRdBFwgo=
=8VOg
-----END PGP SIGNATURE-----

--LS0ZL1mlvV8tsXyl--

