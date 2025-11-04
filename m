Return-Path: <linux-spi+bounces-10992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234EC30130
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111693A4E2B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB52264C7;
	Tue,  4 Nov 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CRfjG70T"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31B19D8AC;
	Tue,  4 Nov 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246115; cv=none; b=k476AkwnXK8guNIAh55vz5zGMkg6isHFg+DwJpV8HZ6RgZJwtbYoVosS7KnORnhm1ylpROqmuiqiJg67Jr4x8Xd7Mcb1MfkjgwhuUTNrTmg8xHSgYRgh+DXC0YjJPf33DBfk3AsZTaPO+gzyuWcdlgTsOuxXmSQ3ynsScd6EOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246115; c=relaxed/simple;
	bh=TTQr+0R+W0AqrqEoPVc7J5rpzXqWM5mmludeeFcg23Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOY9o9mLz4JOzz7ZZjDUMdYqyrPDbX6hBDctpPS2RbEGpW5Rn0xzuFFM7GMRzYy/bsJH13O30Vq6AGRySAzozfc94bpoT341cLAiNq7PTUuGefYX34v9JNY/pDZKibqEf/b02CqVPBdY4KLOD6HZ6KTx22pbcOU3mIVlDcuexc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CRfjG70T; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246113; x=1793782113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TTQr+0R+W0AqrqEoPVc7J5rpzXqWM5mmludeeFcg23Q=;
  b=CRfjG70T87nhOWhBnujwtl4Tr8CIn6mB1JaPRIHtRV6gRhDYVrIKB0BW
   W6Snxzd44blysaWuC5TyZX6V9lQy3opqoI+6YmPNTqyv3bwlcL6XYNJZd
   TleipxmD/OJ92FvfCbItyWkwoWJkxqx+seIHiUI5jeOQdFzw7HsTByHGZ
   VO7c6KHpBPsqAOWruC57CZ4CbJPll4hkB7rB5JSy83SjbhT8wTq7X4WcF
   TvYBeWmbeq0xXrPTdRkWzWqmUgEeEBDR1j5kBvm9oumt23Iv+0Mo3//rv
   dIBVB+dbl+9s445olZx0mnKhXvbWYjZtBaL+LifHFlU2gP9Brl0nEA3E4
   w==;
X-CSE-ConnectionGUID: cuBV7z19QNieLgsXxlf1Vg==
X-CSE-MsgGUID: AMkxw+pPTB+e2XdkMflsTQ==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="asc'?scan'208";a="215994660"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:48:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:48:08 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:48:06 -0700
Date: Tue, 4 Nov 2025 08:46:23 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>
Subject: Re: [PATCH v1 1/3] spi: microchip: rename driver file and internal
 identifiers
Message-ID: <20251104-paralyze-creature-d2ab0ce2566a@wendy>
References: <20251103160515.412706-1-prajna.rajendrakumar@microchip.com>
 <20251103160515.412706-2-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dbyOFFU7ujEIU9/Y"
Content-Disposition: inline
In-Reply-To: <20251103160515.412706-2-prajna.rajendrakumar@microchip.com>

--dbyOFFU7ujEIU9/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 04:05:13PM +0000, Prajna Rajendra Kumar wrote:
> The spi-microchip-core.c driver provides support for the Microchip
> PolarFire SoC (MPFS) "hard" SPI controller. It was originally named
> "core" with the expectation that it might also cover Microchip's
> CoreSPI "soft" IP, but that never materialized.
>=20
> The CoreSPI IP cannot be supported by this driver because its register
> layout differs substantially from the MPFS SPI controller. In practice
> most of the code would need to be replaced to handle those differences
> so keeping the drivers separate is the simpler approach.
>=20
> The file and internal symbols are renamed to reflect MPFS support and
> to free up "spi-microchip-core.c" for CoreSPI driver.
>=20
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers=
")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Renaming the driver from spi-mpfs to spi-microchip-core was my mistake,
based on the knowledge that the coreSPI IP is what had been hardened and
use in the mpfs device. I didn't expect that the register layout had
been changed so dramatically between the two, when all other "hardened" IP
just added extra bits in registers or whole new registers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dbyOFFU7ujEIU9/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQm9XwAKCRB4tDGHoIJi
0mN6AP9OaCb3FGGYqtgk+5W1t+1MWt58dVr1qbwzn5K6+yOO9gD8Cf6jDATNSvyc
0SnFN+sA0OZ52EDvffH7yuSTGCJV3gs=
=cXn0
-----END PGP SIGNATURE-----

--dbyOFFU7ujEIU9/Y--

