Return-Path: <linux-spi+bounces-4467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A99663D5
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A801B282676
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A581B013F;
	Fri, 30 Aug 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDEJO/qQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88C1AF4F8;
	Fri, 30 Aug 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027065; cv=none; b=rdJgQzGMLmg6sXPL7m7+Aoz6gTbfXpEtOUM9ZlPRnrxno7edX5BM40FZXaknUS/qxwUryPRPyDROZ4jq/Ej+pTPjx2kg7FogUSjLXizuSZRAYhBfwOlyuuas9Gabzbox3v3EvcnOrGlQSvrw0v39N43Aix18Ns5f6/ZCvoCQaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027065; c=relaxed/simple;
	bh=VixJdVFdm8BFxXamRIKnJaWEE3dVUHj2+gBnP1juWtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ2vT+gvf1XbeWqM7+Qv0wU6d1eq3zVUXe223cvQzXn3avZPcYuJ8d7vz6NHdx42CODf7fUd6Go40DY1dhBatwryVeNgEfK7wpEemjs6fnxggCO1ZMRRcAtPvNhKAcTmKxkgJcWqpmeYp2szD7FbWOkOuoZhflQ50bb5kXyO/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDEJO/qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E508DC4CEDC;
	Fri, 30 Aug 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725027065;
	bh=VixJdVFdm8BFxXamRIKnJaWEE3dVUHj2+gBnP1juWtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDEJO/qQcV8f300DNrO0MCVyJcpl+69dR01YEfgqML1ke9JjltoAtGj3Bpkcy6A3u
	 eWF7lQUfF7MTKtvVTiN8c2F2a4Z+Buq8FWOtFAi7sZokPxrMEzeK2cxzhi/wlCQ51H
	 RAo4a51f1AW0R4VxSXFhKwUzNqAvZbkE+PZqLK4rvcj7vESwas9hmai9jGO+PH4H39
	 ee8vvP50sRn/RP2vXDuf42ZorG2rsZeF6cjKUToTAZ+rsXM4yKxH31uCtkmrI3T+2I
	 Dn/6PgwLSQJjHPT0VDACPqjEm/UzhSTchBopU05Cz97R/0C/rtfemxSoNDgq/kRYQg
	 Yl10ref4g8yPw==
Date: Fri, 30 Aug 2024 15:11:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-peripheral-props: Document
 spi-cpha and spi-cpol
Message-ID: <20240830-factsheet-winking-ddae24977938@spud>
References: <20240829201315.3412759-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fRWsun4WanjycqP/"
Content-Disposition: inline
In-Reply-To: <20240829201315.3412759-1-festevam@gmail.com>


--fRWsun4WanjycqP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 05:13:14PM -0300, Fabio Estevam wrote:
> The 'spi-cpha' and 'spi-cpol' are commonly used SPI peripheral
> properties that indicate the device clock phase and polarity.
>=20
> Document these properties.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.y=
aml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 0bb443b8decd..b2e2717f3619 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -29,6 +29,16 @@ properties:
>      description:
>        Chip select used by the device.
> =20
> +  spi-cpha:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device data is sampled on trailing (last) edge of the SPI cloc=
k.
> +
> +  spi-cpol:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device clock has a falling lead (first) edge.

These two should just be usable with "spi-cpha: true", they're applied
by the controller schema to it's child nodes, so you don't need to
redefine their type here.

> +
>    spi-cs-high:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> --=20
> 2.34.1
>=20

--fRWsun4WanjycqP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHS9AAKCRB4tDGHoIJi
0hOkAP9McrdjlG8xVA5W3kzseaEjzrtrxyh0RKvvBwW7AHv3cAD+JtnpA2mOB5t5
PnatZiI6DfPio3cSXD7LZJhi5HYpggw=
=uXhL
-----END PGP SIGNATURE-----

--fRWsun4WanjycqP/--

