Return-Path: <linux-spi+bounces-3363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3D90265A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771C9B28CE3
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD81422B8;
	Mon, 10 Jun 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHb8hHAG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B71DFF7;
	Mon, 10 Jun 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035728; cv=none; b=HKvAXNhqMsdQvZOduljk76+ytdluODBdKNceA+totR2WEyK9JNxPtalVGEYZpBNA358AAeu7gqGOGtC/d8GDOSYGF++rDgYY5TODznhfelomXG8CpsfhlccI3x39UiJbIYdemyO1dOUiEEg8z/07YFR0nm0PnEd642tRWRNanQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035728; c=relaxed/simple;
	bh=mqGdprG9KPDdPu0ShjpJar1F9Q1B1UNKhjxL/wL717c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwhJkubjPikSZNcojIfTjxYSnHNuzi/SM8O847PJtFeZDOON9uX+CDZD2nJ92098OW7Menc7bd1205MBWMg3X22gm03MLAfYhYCTq9MDAqgkRFGNSWQ1qSYaj7r9pAaBx/tj4exbGUfMJmML4R2PqBeL+SoBcfp1HvX5kY3Pmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHb8hHAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3F3C2BBFC;
	Mon, 10 Jun 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718035728;
	bh=mqGdprG9KPDdPu0ShjpJar1F9Q1B1UNKhjxL/wL717c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHb8hHAGLa4OsvrB3sQOMqvRmBEdfZENU4pgKNlo+bLtgWTNcI7jwBGdXGH4Ukmvo
	 d73wi1WlCZIkv6wVA+jAAHEILRg2BUghPTcnUWVyedOSYaFUzaSERaAB8PFg2ctolK
	 3sbRehMYuinAfDb3eEItKrAJiRo+tnAZD8RU/EecaeW26WSOtykutwMEdFb6+2EMq4
	 KvIkyoCi+1CSMnReFS49Xd8DwV3/Yxl/dWlOEuq3OzIJXtV/2XhW0OY5d6hXcNRrh2
	 xfovHgZY/o0WysZg/8qmNZeuRwPES3lfI5rVvdfSwSfj89t/RzEUTNQnjI81w+EbSj
	 YixNhVaxvff1g==
Date: Mon, 10 Jun 2024 17:08:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [PATCH v8 3/4] spi: cadence: Allow to read basic xSPI
 configuration from ACPI
Message-ID: <ZmclB2CMhhkasiBw@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-4-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tFL2/mw4Qy+8zVf8"
Content-Disposition: inline
In-Reply-To: <20240607151831.3858304-4-wsadowski@marvell.com>
X-Cookie: Your love life will be... interesting.


--tFL2/mw4Qy+8zVf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 08:18:30AM -0700, Witold Sadowski wrote:

> These changes enable reading the configurations from ACPI tables as
> required for successful probing in an ACPI UEFI environment. In the
> case of an ACPI-disabled or DTS-based environment, it will continue
> to read configurations from DTS as before.

This doesn't describe what the ACPI tables are supposed to look like or
anything, it's hard to review this...

> +#ifdef CONFIG_ACPI
> +static bool cdns_xspi_supports_op(struct spi_mem *mem,
> +				  const struct spi_mem_op *op)
> +{

> +	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
> +				   &obj)) {

> +	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
> +				   &obj)) {

Why is this Cadence specific?

>  static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
>  {
> -	struct device_node *node_prop =3D pdev->dev.of_node;
> +	struct fwnode_handle *fwnode_child;
>  	unsigned int cs;
> =20
> -	for_each_available_child_of_node_scoped(node_prop, node_child) {
> -		if (of_property_read_u32(node_child, "reg", &cs)) {
> +	device_for_each_child_node(&pdev->dev, fwnode_child) {
> +		if (!fwnode_device_is_available(fwnode_child))
> +			continue;
> +
> +		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
>  			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
> +			fwnode_handle_put(fwnode_child);
>  			return -ENXIO;
>  		} else if (cs >=3D CDNS_XSPI_MAX_BANKS) {
>  			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
> +			fwnode_handle_put(fwnode_child);
>  			return -ENXIO;
>  		}
>  	}

This is just a general refactoring to fwnode and could be split out.

> @@ -814,19 +890,19 @@ static int cdns_xspi_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return -ENODEV;
> =20
> -	cdns_xspi->iobase =3D devm_platform_ioremap_resource_byname(pdev, "io");
> +	cdns_xspi->iobase =3D devm_platform_ioremap_resource(pdev, 0);

> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);

> -	cdns_xspi->auxbase =3D devm_platform_ioremap_resource_byname(pdev, "aux=
");
> +	cdns_xspi->auxbase =3D devm_platform_ioremap_resource(pdev, 2);

This causes us to ignore naming on resources, that's an ABI break for
other systems.

--tFL2/mw4Qy+8zVf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnJQcACgkQJNaLcl1U
h9DONwf+IthK+A65Y0/uzrZy5nJ94Lemxxb+gLFAc5sm2+gPX9IXqpbTvHkEfomj
ebbt3h2pLrKbQrl7fpIGuCTftEkfprhJ+Y50YRlrGmCH9Z2lT2vlBukGS9aopyJY
EvOJZoX1XTqKstDW0Al5zaHSHFOAg25iGn+EIaBP/HQdDMAsZ8laV9sLGwazjNML
fYmixa+7n64ePtb8GvJfPxB+ROqQifAnZWNuHw7FO/HeFOu3029Q06rHPE7ujL4e
1ylGqMFQ7Fcbc2idtGsdh4aEKsri0rLu3ulSuZ5Tbv9E/SkUIccre0OnEXUGpnYW
K4hLScVjGgCOlvsS8yG3TLD7InoEeA==
=6p+r
-----END PGP SIGNATURE-----

--tFL2/mw4Qy+8zVf8--

