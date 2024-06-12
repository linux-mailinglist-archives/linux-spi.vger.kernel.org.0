Return-Path: <linux-spi+bounces-3381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEC90507A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 12:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B03B225AB
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515B16DEB3;
	Wed, 12 Jun 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbM0EJXI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4D763E6;
	Wed, 12 Jun 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188548; cv=none; b=j1mvIGO1fZXqiefr+bR1Kuo6zFgPAXoNQjpZIeRgFBOdG2drV0Xvg7jqZlnryJqIrPEEW/ROxX4b5gCtuzqDqkTNy8X5+LN20gRWRQuSqixwyxIdzXerjTWfsKc56pSJ6+2kL1rhIBOA6SNFyM3xNC6GVleckCcZgDztPc4iNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188548; c=relaxed/simple;
	bh=X0Zk+SveV+gEb4psqpLSCPha/o7toshYco8L5g3SX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp0I7NYd1e4GEJCjnrMMN3Yw54ScNFKKYdxYxUTH0wZrLpn5tp8//ACufk+L6UJ7Z6C67bgxiIZMjslI2GRGN3/FfnnLktJ6afSTtHCwgaNQbOIHMuP/UpT189Yoo9jojCDVAcjAIKsc3CxAsR8LPG8aaPSxR87bR1b/1OU8jsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbM0EJXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C992FC3277B;
	Wed, 12 Jun 2024 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718188548;
	bh=X0Zk+SveV+gEb4psqpLSCPha/o7toshYco8L5g3SX8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbM0EJXIp8oIL6cno3WwmEwiq1kultN4QLcaOQ9OXrUT2f6sk1ZW0HghpbfJ8xFoF
	 hsaMCMYWOgf2zDzlEiUK2QFfdsBYHS+mLP9J/+HrQLroBaVq2dGf07b65tlk69B2dO
	 EHcwSW/dIEmR6rdgIXDUhxnKPymcWhI8PEhQS0S3ePiBdZgV6kd2qMso4QovTgPHzu
	 P05JA3NGReqXIjkYSazArVNLmhVJ/MNxS2ljy9b2AgPXiAaxW69keu1E3MWSMvVFnj
	 Pke1427BstaY1P3vcdsJiKeGJysiOpEwuCaXoUC1z1MoohwJXS7S87XaXJzuUkWLJ0
	 d5c7+z48ddCZQ==
Date: Wed, 12 Jun 2024 11:35:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>,
	Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v8 3/4] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Message-ID: <Zml6ARdI3ek6sVF1@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-4-wsadowski@marvell.com>
 <ZmclB2CMhhkasiBw@finisterre.sirena.org.uk>
 <CO6PR18MB4098CD7676AA96B680FBC068B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Llmhg3KkfjprADEB"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB4098CD7676AA96B680FBC068B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: Your love life will be... interesting.


--Llmhg3KkfjprADEB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 09:57:09PM +0000, Witold Sadowski wrote:
> > > These changes enable reading the configurations from ACPI tables as
> > > required for successful probing in an ACPI UEFI environment. In the
> > > case of an ACPI-disabled or DTS-based environment, it will continue to
> > > read configurations from DTS as before.

> > This doesn't describe what the ACPI tables are supposed to look like or
> > anything, it's hard to review this...

> There should be an example of ACPI table in commit message?

No sign of one in the patch that got sent, nor in the cover letter.

> > > +#ifdef CONFIG_ACPI
> > > +static bool cdns_xspi_supports_op(struct spi_mem *mem,
> > > +				  const struct spi_mem_op *op)
> > > +{

> > > +	if (!acpi_dev_get_property(adev, "spi-tx-bus-width",
> > ACPI_TYPE_INTEGER,
> > > +				   &obj)) {

> > > +	if (!acpi_dev_get_property(adev, "spi-rx-bus-width",
> > ACPI_TYPE_INTEGER,
> > > +				   &obj)) {

> > Why is this Cadence specific?

> So that part should do to generic spi? I think right now it is not
> Supported to read tx/rx bus width from acpi.

I think I meant to say Marvell there rather than Cadence.

> > > -	cdns_xspi->iobase =3D devm_platform_ioremap_resource_byname(pdev,
> > "io");
> > > +	cdns_xspi->iobase =3D devm_platform_ioremap_resource(pdev, 0);
> >=20
> > > -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >=20
> > > -	cdns_xspi->auxbase =3D devm_platform_ioremap_resource_byname(pdev,
> > "aux");
> > > +	cdns_xspi->auxbase =3D devm_platform_ioremap_resource(pdev, 2);

> > This causes us to ignore naming on resources, that's an ABI break for
> > other systems.

> In that case acpi tables are not able to find resource by name. Or at
> least I wasn't able to find a way to handle that in different way.
> Is there better solution for that part?

Try by name and then fall back on numbers?

--Llmhg3KkfjprADEB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpegAACgkQJNaLcl1U
h9Dhsgf+JGMmyMkLPPtsh9gB5SjSbo5EYx+U4yVYqbC/tIANoDeej74YxpaOYQvv
zmzu9dPxmcKMKlg4cqmonr0YGSt5HK1EnraoQlPTxKdW9ASi0MOweH3hhJZAv0HE
Jy8kPOTbN2FRtKicXyJVU3iaFIRNukZdgBSnqprHd+Ccm+BjMbCJHaewEAPGbr+l
jP+GqH81ZUu4oV2Fl/vWsSjJC4Pcc8YPyeYTKr2UZUf8KxiguTnmZJ2JxB24JDpe
IeedhN7NsbE+kwnCKMYdZc2NGY4SuDBpw2XbcBmSMrgma9rxqZ1nYVr9tktvPzIi
cNdxhE//NCF2xH2gON2twMd5jRQPXw==
=Z3zK
-----END PGP SIGNATURE-----

--Llmhg3KkfjprADEB--

