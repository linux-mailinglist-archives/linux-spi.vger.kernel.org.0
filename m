Return-Path: <linux-spi+bounces-3667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83691C247
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8921C217A9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71091CCCB0;
	Fri, 28 Jun 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2ovfQ4V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291B1CB339;
	Fri, 28 Jun 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587652; cv=none; b=czuF63FBpJ7IZFfteZ8OS4e6+1MV60j+JLy+fDIA5bsSdNEim8K2BvornvI617EnVfOgLvjgWWeXcfSHq+/Xz8MbmdcmeQ2Gq8lIC2bjwBMiMRaGZy+XC8MO9uajUUUjuNPHB5VE8I5hfUIDvswB4ThbB8kwxwuIEBh5DN4LblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587652; c=relaxed/simple;
	bh=Z/xKV0gokLH02ulrhh1+xpFeKQ/Epkq96/caHVTjHtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVj56NFmv7KY7xgrXsJPHbXKkxGZ54s2bMoFGdGvrmAOSifNZXPeYOCeZ6NM0H519iS/AqWJu0z7j2ruxYctzeseMCSOKaHi6pAn93O7CdZwvMNycgPqqVKVkDyLA7B1Z/9zS0B/ffEGQh9hmh/sayq0f8pA+VpBNRrCW0KEJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2ovfQ4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AA1C2BBFC;
	Fri, 28 Jun 2024 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587651;
	bh=Z/xKV0gokLH02ulrhh1+xpFeKQ/Epkq96/caHVTjHtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2ovfQ4VUXpaaXImj+1jkWcq7f441lxQ507rCX8ZPe2+d1qTIjAC7npBrHifjMz7Z
	 TB25Jo4M9yyb+GaNBSv1LXbXjk/qUxELtbtTfgbnv8CgK7CTA94iE6Zg+5gBvx+54H
	 AUpGZEP8FTEue5rqm4+S5aX48B29NwiEUMWSztIiu36VGNmSL9uMDXe0S5goeN/M/S
	 nrSfdreS/2eABV5oi1qKXQj4o30NqpxNzIX8LDLVTnzeRk0B0m7DFTQFPieLz3x3cz
	 3We5I0sHVdmY5T/SCPTKY4lbmjpyB3vbrpij3qyVoandQrpjGXJeDGHvwhI/Ogor2P
	 dTOdjTfSZzYxg==
Date: Fri, 28 Jun 2024 16:14:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Message-ID: <20240628-concave-panic-5c6325ed1717@spud>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eXAW2dF2IHLV4Gt6"
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>


--eXAW2dF2IHLV4Gt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2024 at 09:56:17PM +0530, Ayush Singh wrote:

> +	mikrobus_boards {
> +		thermo_click: thermo-click {
> +			compatible = "maxim,max31855k", "mikrobus-spi";
> +			spi-max-frequency = <1000000>;
> +			pinctrl-apply = "spi_default";
> +		};
> +
> +		lsm6dsl_click: lsm6dsl-click {
> +			compatible = "st,lsm6ds3", "mikrobus-spi";
> +			spi-max-frequency = <1000000>;
> +			pinctrl-apply = "spi_default";

So every single device that could possibly go on a mikrobus board will
need a new binding (or significant binding modifications)?

tbh, I was expecting something where the mikrobus connector looks like
what "spi-mux" does. Ditto "i2c-mux" for the i2c component.

--eXAW2dF2IHLV4Gt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7TPAAKCRB4tDGHoIJi
0rYzAQC3R+qAbWpMxL4XofN+KeOkErzRmYynuYa5v3/nLN6FtQEAwMZM614iZlFC
drgjXVFZJxqzjRlpVreQRuZ/s+d0UwA=
=Gw11
-----END PGP SIGNATURE-----

--eXAW2dF2IHLV4Gt6--

