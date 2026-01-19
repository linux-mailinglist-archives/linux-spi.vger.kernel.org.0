Return-Path: <linux-spi+bounces-12491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 414BDD3B2F3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1917C31E09E3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C631079B;
	Mon, 19 Jan 2026 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unRG7bW+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482E2E9748;
	Mon, 19 Jan 2026 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840381; cv=none; b=eNL1/covOBawHTrPUrfVVngjWm7NLH/Rd2lrRucdhMAjiVB6R5V/Z8zfEx7icoZcgohs5E1qaF7nMjlzsOTgRR2b8C7gS6p09YsftTC/WNJLqsb48rKFZtbzJZoLysoWGrYZSG9HqKdL3qlhym8mKa0Z/YA0kNikYl3NWsww1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840381; c=relaxed/simple;
	bh=FSK2p39fnYyOReSbFHAT7uDwUgHyiuXc91JnF4Ih5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN3Xv3zD8syDHlXaTXefyfZa6oniixYPKlBBvJT7GOi+YHX9Dcb9AZcbpBBFmvuWHldBF5yvaRuud+pLYgty5rhUpgKAGiRFcHUg9nvzNL2YYGmf0BScx6O/pvWxJqVh7qyS7tbzqVayQvONbHC+FVdqbh9HRA9sNXRgUfmSPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unRG7bW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78464C116C6;
	Mon, 19 Jan 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840381;
	bh=FSK2p39fnYyOReSbFHAT7uDwUgHyiuXc91JnF4Ih5Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unRG7bW+ig0RCov1HYV8fF2IJlzjJbL2Oo+6mAoopXSU27xHFSj0U2YrQo/3uhwWX
	 jBvycIPINdznhVcTADN9y1N0vgfc8zZm77dYlQO7wC8n2/nZ2wS48vS7UxWKeQPcNu
	 jPBr3B+b7B+eOLADnoogEcDOhy5xKNovblb82JXyN6+oOQqLhrx1kStLKFJMLqVjEG
	 DCyednN+Oh0d9s0mE6jd7bBi6bPG7V68w3IG4UyJ7MmOI9jiZ1ws12XhGOmhOm+BbF
	 yuJ0OuOUjiyV/jNoNZE3EzUa44dW8tJxD+xlLvs9HheU30Mto4TXVX8Qq4o5PJpXIZ
	 F45poegiDnyeQ==
Date: Mon, 19 Jan 2026 16:32:56 +0000
From: Mark Brown <broonie@kernel.org>
To: abdurrahman@nexthop.ai
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V4YoqTaJILUWHTXZ"
Content-Disposition: inline
In-Reply-To: <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
X-Cookie: Does not include installation.


--V4YoqTaJILUWHTXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2026 at 07:06:24AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> -		ret = of_property_read_u32(pdev->dev.of_node,
> -					   "xlnx,num-transfer-bits",
> -					   &bits_per_word);
> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> +					 &num_cs);
> +		ret = device_property_read_u32(&pdev->dev,
> +					       "xlnx,num-transfer-bits",
> +					       &bits_per_word);

Are these bindings appropraite for ACPI systems?

--V4YoqTaJILUWHTXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluXLgACgkQJNaLcl1U
h9C9gQf+J10ea4w8nkbPfpv4jU70xx2BhYkVgoUYn+riFNO3SKUIFiPLzobc+5KS
PpceBDoj4/KQa3S82dLz9lrNrhPB0cGBtMn1AixquTSRBg+pf+LVH0JfQwuWyk/3
WfYqEOI/SaPBdYWDZtt9t7U4rlbmb7g9tFrDyjzL53nbzihr+MfOMNbNbnNp7VQk
IKpaZRa1I2AnMMYz4yGDBptPVvlbyG3Hh/k64Ntl5Pecfjvx5LP21O30Wp7xmbHW
+Vz5hN/RhjTN3VB+cIq94D6MOoo2yuDIbyCMzzABg9hw6g9yOZdfG5UOPPSJ9Cmq
mBJwXwYcsjl78RNhoI6cCWO5yKwhkA==
=E8uq
-----END PGP SIGNATURE-----

--V4YoqTaJILUWHTXZ--

