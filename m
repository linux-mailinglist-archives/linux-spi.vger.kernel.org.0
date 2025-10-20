Return-Path: <linux-spi+bounces-10735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E9BF2C9E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53BE24E6E31
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C23321BB;
	Mon, 20 Oct 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKRbJojv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B5278779;
	Mon, 20 Oct 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982249; cv=none; b=rzgnsrF914xlqeoF/whCzmIaKo6QYF6xBOphztmIII3qb9jW6W9kvp9tTFY6BR2kS8JMvY8w+EiHXib/HE3g0A/3LkjhjEFRbi7LfgCxz2aNozkc/uGwI4edmDuHZSEAKk49mPHazjOPcO4rOsO/fOOGkHEpjGIXcs07SRkBymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982249; c=relaxed/simple;
	bh=UGG12C0YM5gqVQtZMlTCg/cATtlJaDQQ0Fiijdez2oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQKFo0aWnwMyyePjauhvjY6KNu4EnlL/jVypO7aod3pmuXS4p+ngDNguSQNS6asMWh4vn16WAZ06pLbENJxIjHoq2Fmi1kLd5sDc8oa5Kfni5Lq5RH4cKu81S8qXbUq49jImFa/hLxvXM2eYxxwNyFLF8w+3c3u06PNZywdK36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKRbJojv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A86C4CEF9;
	Mon, 20 Oct 2025 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982248;
	bh=UGG12C0YM5gqVQtZMlTCg/cATtlJaDQQ0Fiijdez2oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKRbJojvIKHCqkefW/DpMAV1M99m0j6YO0Tj1OD2zHTj+bDqqx7TobNR5L0KtHDCW
	 dBNEVA6/rs08/Hyexa8t+YPNOO7QqVjqd6TsMc/F90aC9RQLEV+eT2ANXNJT16Q+A+
	 yhxcI+1wCPK5fYXygRLV8YEpWRZ++mJ++LzlyKz3oKfWuFNhaJIYQqcsCimCd6J8vi
	 cJNfdX4YsK4LIYPa9pO7bCBJ1cQwmLl+V/pDJCoKjDnJn7t9LtSmZuGZ+cQyn9+6gI
	 0N9BhFNhWtEkRGpvQMNhUdU+6lHGZATGMnfJTGy+Up3DoIhidC1yWjIMtiHHbP4JBZ
	 yN+H12d67oRNQ==
Date: Mon, 20 Oct 2025 18:44:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: spi: fsl-qspi: add optional resets
Message-ID: <20251020-henna-headache-fae4440ec7a8@spud>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17adE0b1pBWXLXwb"
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-2-elder@riscstar.com>


--17adE0b1pBWXLXwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:51:44AM -0500, Alex Elder wrote:
> Allow two resets to be optionally included for the Freescale QSPI driver.

This is a binding, please don't mention the driver here.

> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml =
b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index f2dd20370dbb3..0315a13fe319a 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -54,6 +54,11 @@ properties:
>        - const: qspi_en
>        - const: qspi
> =20
> +  resets:
> +    items:
> +      - description: SoC QSPI reset
> +      - description: SoC QSPI bus reset

If none of the fsl devices have resets, this should be added alongside
the new spacemit compatible and not permitted for the other compatibles.


> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.48.1
>=20

--17adE0b1pBWXLXwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZ04wAKCRB4tDGHoIJi
0lEKAP4tn2+XRwM5eBj2d46u1mM+jjxVgwNB08I2twSsMQSpRQEAupOGQFen6YpA
+RHiekfk56oRh7/fLzUhP5reWtEMSQc=
=KgvV
-----END PGP SIGNATURE-----

--17adE0b1pBWXLXwb--

