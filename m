Return-Path: <linux-spi+bounces-3696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D857991D1E4
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C27C281A72
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBE13D625;
	Sun, 30 Jun 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrJ8WKON"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616426AD0;
	Sun, 30 Jun 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719755524; cv=none; b=ZZg4KHtLVb3o0R8tYE8Wtt1fnArO+h4U9esYZHXnGbJeafx9HXUdB18peoFMvo/2Is753RWMn91o2raw+Jqwluckwbyssl60LG36nU2kQZEoQEc2Bl1BxW59ni4g/kraGPt9opBd5+jiIA2EIP8+GxPc6ExboDzb5pA478yFjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719755524; c=relaxed/simple;
	bh=cKx0d4ITrHDtw1Yenlz2VXJhqqK9XmmncyP3oHvZX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaD92gVq8awIIMzBi0szI1bawRDykYRWgDlwl8IdgBaGfYDW+8h/nBsvErE+YqH3evXb4NhNUpTRVS+guxsPHBKdyVw/gof/3385oHQecUraT+TqaQN5HPQemYyZeSbrH61ur+ztnlmoc/UQL2gYAMUBTHskHe67wpps16kVB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrJ8WKON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B0DC2BD10;
	Sun, 30 Jun 2024 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719755523;
	bh=cKx0d4ITrHDtw1Yenlz2VXJhqqK9XmmncyP3oHvZX0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrJ8WKONt6dG+tVGeuXMgTh7uWywa69PQJ9QrRSQYUZcwgL4wN8lrB8wXR1JrWFFN
	 rDaO7LQ82EJlNzzAYWbJlXD+//Q9wFIbbkXpmpFFEfQTXfl6R9ZGhq92zoqENmXOJ5
	 TUvPj5U+lhqRfX5AYIY80ZtZYzlCf80lpHEesGzptfpLDM1LCrqyXTZk62cpjYOBek
	 3Xm/RmluDGf1jpwOM5HM+P896GAvfIEhsw93VHNXIuJnARMD9vvcmMjy0u7ER4VJWG
	 QUoG7OcOpipGktFoGSoE4sPAv+o5lSvrgQ7QpT6xkbbOW/EZNfedbDDstSjJiqZyV6
	 lCIJfO7N08l3Q==
Date: Sun, 30 Jun 2024 14:51:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: kanakshilledar111@protonmail.com, Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] arch: riscv: thead: implement basic spi
Message-ID: <20240630-generous-carnation-c534f5d84a8a@spud>
References: <20240630063845.116307-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eVSbUZ+H5PdYupqW"
Content-Disposition: inline
In-Reply-To: <20240630063845.116307-1-kanakshilledar@gmail.com>


--eVSbUZ+H5PdYupqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 12:08:20PM +0530, Kanak Shilledar wrote:
> implemented basic spi support for TH1520 SoC.
> created a fixed clock and a simple spi0 node.
> updated the matching binding to include thead,th1520-spi as compatible.
> added a spidev device in devicetree which will utilise the spi0 node.
> this is usually reserved for a SPI NOR flash which is left unpopulated
> underneath the carrier board. I performed a SPI self loop test using
> tools/spi/spidev_test.c and tried sending `\xDE\xAD\xBE\xEF` and verified
> it is being received correctly. i updated the of_device_id struct in
> drivers/spi/spi-dw-mmio.c to include "thead,th1520-spi" as the compatible.
> this patch also adds basic spi support on beaglev ahead which shares the
> same TH1520 SoC. i have only tested on LicheePi 4A.
>=20
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
>  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
>  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 10 ++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
>  drivers/spi/spi-dw-mmio.c                        |  1 +

This needs to be 3 different patches - one for the binding, one for the
driver and a final one for the dts files.

> +
> +&spi0 {
> +	status =3D "okay";
> +	spidev@0 {

"spidev" is not a type of device, the nodename should match the type.

> +		compatible =3D "rohm,dh2228fv";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <500000>;
> +	};
> +};

I'll put money on you not having a dh2228fv on this board. Document what
you actually have on it please, not what allows you to probe the spidev
driver in linux.

Thanks,
Conor.

--eVSbUZ+H5PdYupqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoFi+QAKCRB4tDGHoIJi
0p/gAQCLljnYLl8vueT7x7bP7BbxcvpOjPRbZHWtZI7hHpiClwD+IXxTFRklvK2o
7ydwy5gESot6/RpSP9MJ3N+FhDBfTAI=
=Clsg
-----END PGP SIGNATURE-----

--eVSbUZ+H5PdYupqW--

