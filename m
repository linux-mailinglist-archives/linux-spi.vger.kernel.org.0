Return-Path: <linux-spi+bounces-8107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62AAB5359
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E38189D1FE
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878128C2D0;
	Tue, 13 May 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1SPvY58l"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDC253F1B;
	Tue, 13 May 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134046; cv=none; b=C3ziGa45nvFwSeljw1+ydaS+IYmHJ5BlmtS3Qf6Qfhk9FMY/ahbflSMRq+lSRFPjy3HaTR66zzDu/EJCo4W74yh30759OjXcyZE6R+dvjcBKqZBQ8Di57iG+ypuJPwN9Jc+Y24VVVglgsDHVdzgVoICjWZuBVrQpF5oaugiPq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134046; c=relaxed/simple;
	bh=lvcch2mjqXy76M4SgxMLancG3LIVTkAgw1v67xAKb60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc4Riumk9Inw7yNENIp82p0uGGrXhpHR45aNqG/nAq4rQtjdGdU1d6wfl9PtrQkqnIQVNsQKsYlTv9jTILrwdwrIlqLH2ZoZWVDsiHjsbwjRXfT1wrvcdbiviq+zEi48uvNzY+2Z5iPXsDCnHW7Xpd2Qq8vTR6suyjgMWAtOOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1SPvY58l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747134044; x=1778670044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvcch2mjqXy76M4SgxMLancG3LIVTkAgw1v67xAKb60=;
  b=1SPvY58lg6QaGq3tg5MKMEH0UOBJBAnn1tbJaQ7qZNh7lbO5vyfRQbMP
   3uBOsM/rKg2W4Dq9QkvGwOlQTxnzPeRUARNUfVSYUWUBHPuKSjqI13WDK
   GsnYroktT62HhIFX88+TzpRxw6LfEZGyiyqgbaseW6TMs/ZNxFBr/9K+a
   uWCsA4sdKDNWMxXgX/JsV7w385tSFtDEY10w0NzW/s7J4p+rNlY9O9WcV
   QzFMZnX5qnoYBP71FQJCnauBRKlCqqO0GIMyKL+TKfVlOuxmlbnlIPtW1
   z/tL99GNL9MwzcotFCPBYHXhPYCzOo8oSCxKADrogQA4KeyVhcgQC0OB1
   A==;
X-CSE-ConnectionGUID: m/qCGXO7RluFvhk37YiHlQ==
X-CSE-MsgGUID: Ef1fQOjqRNOhE8dLMRoNgA==
X-IronPort-AV: E=Sophos;i="6.15,285,1739862000"; 
   d="asc'?scan'208";a="42045275"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2025 04:00:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 13 May 2025 04:00:41 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44 via Frontend
 Transport; Tue, 13 May 2025 04:00:38 -0700
Date: Tue, 13 May 2025 11:59:38 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: Conor Dooley <conor@kernel.org>, Vishwaroop A <va@nvidia.com>,
	<krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>, <bgriffis@nvidia.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 RESEND 1/2] dt-bindings: spi: tegra: Document IOMMU
 property for Tegra234 QSPI
Message-ID: <20250513-implode-half-0c3ffcf6d3f5@wendy>
References: <20250509165409.311912-1-va@nvidia.com>
 <20250512-observant-rental-21927c85c709@spud>
 <904d3e89-a540-4edd-b748-15e13c431c17@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SQ4dyVdvUUBL1DBR"
Content-Disposition: inline
In-Reply-To: <904d3e89-a540-4edd-b748-15e13c431c17@nvidia.com>

--SQ4dyVdvUUBL1DBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:19:05AM +0100, Jon Hunter wrote:

> > > +  - $ref: spi-controller.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          const: nvidia,tegra234-qspi
> >=20
> > > +    then:
> > > +      properties:
> > > +        iommus: true
> >=20
> > This is a NOP, no?
> > Just invert the case above and drop a clause.
>=20
>=20
> Yes that's true. So just to confirm, your preference is this ...
>=20
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.y=
aml
> b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 04d3b1a47392..c45511e9a9ed 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -74,11 +74,13 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          const: nvidia,tegra234-qspi
> +          contains:
> +            enum:
> +              - nvidia,tegra210-qspi
> +              - nvidia,tegra186-qspi
> +              - nvidia,tegra194-qspi
> +              - nvidia,tegra241-qspi
>      then:
> -      properties:
> -        iommus: true
> -    else:
>        properties:
>          iommus: false

You can just invert the condition directly with a not:,
so "if: properties: compatible: not: contains:" should do the trick.

--SQ4dyVdvUUBL1DBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCMmGgAKCRB4tDGHoIJi
0mpYAP9DLyt4yjrQ7chZQTnXz8nDNpruXL9jHhFsNskUDttvUgEAuMvvEbdUg9tK
EZQ2UODgjqyj9QFYSS7svBf4/g1GjAM=
=vXPi
-----END PGP SIGNATURE-----

--SQ4dyVdvUUBL1DBR--

