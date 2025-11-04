Return-Path: <linux-spi+bounces-10994-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C508AC30290
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4168B3BE46E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78228D84F;
	Tue,  4 Nov 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o8prtfvb"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7F24290D;
	Tue,  4 Nov 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246863; cv=none; b=bNsuBWqVGLEqHcRwNg4nRRGMi44YayBwWtCgN3YXmaVLS5YfvASReWz4f3CKzPHHu8VzPzxB5HTnejeQaWstYi91auimhIDMEzcwsFxDn3ls8RV1eoSaa11gsjXZOpxodIpRbG+gxkivffV7BUQ7E1KO4JL3Gfu85XP15zn2O8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246863; c=relaxed/simple;
	bh=yZJWb+YgufW+fRvWZAF/rjt/FGY/o/OacsBv0wBUUSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7PQkRXg2uvxFbMnX7oezm04ui0TbtYVXZnYz5PZce1Z1/1Cp2lwTWKJJWddY4/49vCkdI8ffS8Pbo2gPFCVitYSsuDmAYLe6tzHOff16DJUmpyA3JkjbOaybiksTRg4PhIHQGc63GLTAUKC58wOFJlks0eW4syqgf/JsMDixjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o8prtfvb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246861; x=1793782861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZJWb+YgufW+fRvWZAF/rjt/FGY/o/OacsBv0wBUUSk=;
  b=o8prtfvbFmnCsnNyC7Wmr9lADT0CxGHMmadpe5OXkbrYrMPW+o4eAHdW
   S8YB70HWtQySnxdC6TOuAdhHgsWuuz/npcj/zrHM2Kuim+wIlsNfNIPiQ
   kkM24JkAqnO9PJ2CyUG8ukPKYJM0Mf83XvTsfbPzeVHAS9KEihsE3e50O
   iy68zXlGmc+TIG40xFuk62R4yaEhgtjexZuoKKR5p/fYMtElP12Fkbcor
   CWngS+v3gvBMEJvXfFYebsR1a4fiATYMsnJ5IlzxZKpaPQGYurE2xpQ2W
   ouUzxxKJu5dT9D2e0c8fBqM/VBuvBza9y/3Gm07SfBdqPCDGRoIsI2sdy
   w==;
X-CSE-ConnectionGUID: 3f10AFXvRw+JlCeZvJ9giA==
X-CSE-MsgGUID: k4v3zqedR7W8FTcqXLNMJA==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="asc'?scan'208";a="215994965"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 02:01:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 02:00:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 02:00:46 -0700
Date: Tue, 4 Nov 2025 08:59:03 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>
Subject: Re: [PATCH v1 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <20251104-unified-velcro-01219faf6dbd@wendy>
References: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
 <20251103160515.412706-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Rlr8YUOA4YGx4c9"
Content-Disposition: inline
In-Reply-To: <20251103160515.412706-4-prajna.rajendrakumar@microchip.com>

--/Rlr8YUOA4YGx4c9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 04:05:15PM +0000, Prajna Rajendra Kumar wrote:
> Introduce driver support for the Microchip FPGA CoreSPI IP.
>=20
> This driver supports only the Motorola SPI mode. TI and NSC modes are
> not currently supported.

When you send v2, it's probably worth mentioning all of the other
restrictions the driver current has, that are being enforced in probe.

> +static struct platform_driver mchp_corespi_driver =3D {
> +	.probe =3D mchp_corespi_probe,
> +	.driver =3D {
> +		.name =3D "microchip-corespi",
> +		.pm =3D MICROCHIP_SPI_PM_OPS,
> +		.of_match_table =3D of_match_ptr(mchp_corespi_dt_ids),
> +	},
> +	.remove_new =3D mchp_corespi_remove,

As the lkp bot pointed out, this doesn't exist in the tree any more,
probably since 6.13 or so. Please test patches you're sending upstream
against upstream.


--/Rlr8YUOA4YGx4c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQnAVgAKCRB4tDGHoIJi
0k86AQDXM6tmcjnx2ozhOM4QBmW1zMpZLYWioLdizJRYRREg5wEAw/rZTtk2chVb
yJHHDkfyi2rr2Dmc4COWmmyHklTPnQ0=
=yb85
-----END PGP SIGNATURE-----

--/Rlr8YUOA4YGx4c9--

