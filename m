Return-Path: <linux-spi+bounces-11524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7FC8653D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 18:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2766342A81
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4C32AAA9;
	Tue, 25 Nov 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9MljQDD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0D219E8D;
	Tue, 25 Nov 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093079; cv=none; b=Rlhns5RWNJ8enbHQ5KDSDjI7ePvE4hYIxjFqYOvG2GRumVYH2yummgEF+6LK+75NNUTHi2T3wqB+kkJs1p8vlnW5jtoKaK2oDps5PGKuiXlVavhrLS+PU7uwSg8k1tzuqB3iXJ4rC58DhqFvVsdwBW05LBrNkv3AMmMO5w2GHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093079; c=relaxed/simple;
	bh=hZ0nCEHlVTA1nsg5CMprLuL2BGcLkzepCg2uCqMklmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey6XflGpIAy9ij4v3EXP6j1NYd20PjTY5GWutp+CmdM75f8S0DvUzVU1bUJHm80+9Ga6DGzTGxcwbx7uVbptM1RKfzIymZYKN4IvAayumKWfficb7FCbQTr8gtR9wVZ4+gNr15zVA1xk0icuzjT2gm0gpW2GpswMNVnJPpCi4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9MljQDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768FDC4CEF1;
	Tue, 25 Nov 2025 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764093078;
	bh=hZ0nCEHlVTA1nsg5CMprLuL2BGcLkzepCg2uCqMklmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9MljQDDRBfARVdY/tjLEq9bwY//3TDVrIdDDigSlOfmGuZAkhiyV56M+OlVe8mNI
	 Md7NU9yswT934agZKZJt2d8ZHbOs4oYb6/8WJ1jbXWCANdCkYoz8f9m88ggDYfmEgp
	 9aFW7/21ZK2ajdRHsECBgTJmQhs17VkhgsbpzodH8Z/HLzoYigbeogY7q5nJzI3dFM
	 XNnZ7BrBZMnR1hHrKa+QnP2AWznPuiddgFzd0dGiOZItQtC1Go4iBJj5iM4bFsluWi
	 GrOZi4AChXs/yNqlTeEJ07Rx43nnh8+2Gn9Wqxu1VfAL6PEMXNyrwDG6rDcdb5nePg
	 6zgvAVi6IVJxw==
Date: Tue, 25 Nov 2025 17:51:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	frank.li@nxp.com
Subject: Re: [PATCH v6 2/2] spi: add driver for NXP XSPI controller
Message-ID: <519e20a0-8568-485e-a66d-04309ba0d43a@sirena.org.uk>
References: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
 <20251125-xspi-v6-2-22b22de50cda@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0fBe0dDGaWuEA0re"
Content-Disposition: inline
In-Reply-To: <20251125-xspi-v6-2-22b22de50cda@nxp.com>
X-Cookie: Too ripped.  Gotta go.


--0fBe0dDGaWuEA0re
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 03:42:19PM +0800, Haibo Chen wrote:
> Add driver support for NXP XSPI controller.
>=20
> XSPI is a flexible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.

This breaks the build:

/build/stage/linux/drivers/spi/spi-nxp-xspi.c: In function =E2=80=98nxp_xsp=
i_exec_op=E2=80=99:
/build/stage/linux/drivers/spi/spi-nxp-xspi.c:997:9: error: implicit declar=
ation
 of function =E2=80=98PM_RUNTIME_ACQUIRE_AUTOSUSPEND=E2=80=99 [-Wimplicit-f=
unction-declaration]
  997 |         PM_RUNTIME_ACQUIRE_AUTOSUSPEND(xspi->dev, pm);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-nxp-xspi.c:997:51: error: =E2=80=98pm=E2=
=80=99 undeclared (fi
rst use in this function); did you mean =E2=80=98tm=E2=80=99?
  997 |         PM_RUNTIME_ACQUIRE_AUTOSUSPEND(xspi->dev, pm);
      |                                                   ^~
      |                                                   tm
/build/stage/linux/drivers/spi/spi-nxp-xspi.c:997:51: note: each undeclared=
 iden
tifier is reported only once for each function it appears in
/build/stage/linux/drivers/spi/spi-nxp-xspi.c:998:15: error: implicit decla=
ration of function =E2=80=98PM_RUNTIME_ACQUIRE_ERR=E2=80=99 [-Wimplicit-fun=
ction-declaration]
  998 |         err =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
      |               ^~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-nxp-xspi.c: In function =E2=80=98nxp_xsp=
i_probe=E2=80=99:
/build/stage/linux/drivers/spi/spi-nxp-xspi.c:1265:45: error: =E2=80=98pm=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98tm=
=E2=80=99?
 1265 |         PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
      |                                             ^~
      |                                             tm

Please resubmit after the merge window unless there's already a
convenient tag for the new macro.

--0fBe0dDGaWuEA0re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkl7I8ACgkQJNaLcl1U
h9C0tgf/YcrzNPwbMN1QjAnLXeUAf89jb5nkePTTivrSOOZF56vX6iKAOTLJNT0g
qgDJth6HXcsaP0ZBpRvixYQyGzQ3fTmQCAa3gef+0l4/hI6AtHj+5eOju2RyDZxS
mtp1DLuy7gCMoYwBrB+bokNcVKkeHsv5/5pby7D4E4KVIYJSSR17h9KsL0jcvfVC
fMW0/twVKvMSQS58xaWtTmGsMJH3qy6mU0Me1o3C3ms+BrGxVh4j8NpFtvBOBEH+
Q5TiKi50jbKahVyrzK6B4+UklPOFEILY9hWsgKEg5BsPSUFAYb83v5/h4/ZTe5oE
MUuv0w5Y9V9yv/7Qnd0Upo0tdrDtug==
=LBmg
-----END PGP SIGNATURE-----

--0fBe0dDGaWuEA0re--

