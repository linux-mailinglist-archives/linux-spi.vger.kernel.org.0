Return-Path: <linux-spi+bounces-10993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FDC3019C
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 09:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7709B4F94F2
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A22BD031;
	Tue,  4 Nov 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lDIjHd+r"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF424886A;
	Tue,  4 Nov 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246256; cv=none; b=dmtpERo2SJxZaPnVtGCZwYtNkR38zbuJsekGL/bBcfeFZjsqyr/JQG7wimvQryDIQlrG7ImlNVBxHEMd0Zorf7r0RrRQPPbdhjMbUKvrWBazOHmINY6D6raJE/eKeM8/h0z2vXkZG0FgbTjxgWLTzek4lvh2nMKSFUkc7n0uZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246256; c=relaxed/simple;
	bh=UQDCjwioHc+CBKu9bQI9yHzGAmAxgJEyxRIyI6V9LfM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3v46DNXhLoh1xWBWeq3eFCnBEldVjomBWBHtBixkJP2cJkXLLrO6zQnBZTNk8v8mxK3xWa8fIXwwadL5+zjGGPxLwwOyf89NAVWqnlzx9gxilwOSF3yrS6At5R2dsFlsc7lXKsFKBDPsiun9U9PFJke1citJCm1N93ib4EsRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lDIjHd+r; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246254; x=1793782254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQDCjwioHc+CBKu9bQI9yHzGAmAxgJEyxRIyI6V9LfM=;
  b=lDIjHd+r6bKcuWh0gwCzb5BvyjqkhsUSLgXHGmOmdmdI1A1VdlemgWuS
   AhsToQSs5WmKbQGvM2T982Nwka5RfBDqbXL+ilDOCSYj/bOSHz75pCqZZ
   IBBn8ojeN6vXZgkjNIAhRmd+/hEW3yBVF4XgNbXxUg3NLv7I64OMkEyib
   8Lzm0K48wFHq9mXvcZKeb5DpmjQH2eSl6HJG3KKP1WEnxzG9/ReM6Q/EG
   XDCjkp4spfK48XzWnYfDbSne4UxfjCt4B8F7I16gvHNV0nlIMVZMa5bW8
   I97By2HBtbnWQnDj9ki6YLI2lRUxzosO21RgHXCnV5Gb3CAONEOU8yXEU
   Q==;
X-CSE-ConnectionGUID: 5k+cQZ2HQAygUastOXmusg==
X-CSE-MsgGUID: HlMcvepoQAyxwiqc7ny3WQ==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="asc'?scan'208";a="49160518"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:50:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:50:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:50:38 -0700
Date: Tue, 4 Nov 2025 08:48:55 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>
Subject: Re: [PATCH v1 2/3] spi: dt-binding: document Microchip CoreSPI
Message-ID: <20251104-ground-cosponsor-83409ccea3f0@wendy>
References: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
 <20251103160515.412706-3-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/B7q90WIyt1Y5JN"
Content-Disposition: inline
In-Reply-To: <20251103160515.412706-3-prajna.rajendrakumar@microchip.com>

--2/B7q90WIyt1Y5JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 04:05:14PM +0000, Prajna Rajendra Kumar wrote:
> Add device tree bindings for Microchip's CoreSPI controller.
>=20
> CoreSPI is a "soft" IP core intended for FPGA implementations. Its
> configurations are set in Libero. These properties represent
> non-discoverable configurations determined by Verilog parameters to the
> IP.
>=20
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--2/B7q90WIyt1Y5JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQm99wAKCRB4tDGHoIJi
0tBHAP9rYYtl2NuaGODKf5vCQUDwJqqxQ7MM9ujFyrKJn11ZqwD8DhBMykUFFOS3
ywi/TIV7uDWo4vi1SO5ItGH2opA16gk=
=inU1
-----END PGP SIGNATURE-----

--2/B7q90WIyt1Y5JN--

