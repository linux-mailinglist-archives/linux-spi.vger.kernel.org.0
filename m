Return-Path: <linux-spi+bounces-12493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9589D3B30D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673C731396A3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4EA2D0C99;
	Mon, 19 Jan 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYGzGmcT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB860217F2E;
	Mon, 19 Jan 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841419; cv=none; b=gJDS0fGYuZFPjSD9khPpighU+YCvdMKGVq2eYVlkzN762I98xJmbvJYfFvyMXoylM2BYIgrenyv4iyPh8L2zXuvkUNyBsbwKafcdK6X78oF8CkhzcYxrPe14Fd41Ii0uuOMRhJonznx6SC4ovV4Aris8OfeB5E16AxpABM0kUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841419; c=relaxed/simple;
	bh=rPWmfChoR053x8YbR76MXS2rElz2473/KngimqQn/+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8rYKZXEqj/ILFFs7aFJn79EqFC9GaLQzB5HijwSeypAi/tQHhJTFBxYvM/6063iCxjcBWzn6MQo1qOn7Eo9tqXIwq18Yljp0140H67oufjQKbZuJh42DBcGFjT5czU9upyCAO87dtg5Jq1ZSkTDtH9jshIcKcKjHsitMHHa9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYGzGmcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C13C16AAE;
	Mon, 19 Jan 2026 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841418;
	bh=rPWmfChoR053x8YbR76MXS2rElz2473/KngimqQn/+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYGzGmcTHl/9m3KQrOWQB0stmXVeQ1bEmfqlV7uuRs6dl9dVw9iu+oLJibSWQ7h6S
	 QewF3isn5jbP84x1ii2sRPH2Ljmx/Zxbtz4n1cUFcTGwjWFvGwD8PIpcYbepzTEO2l
	 54oMd2e2SIRFjH1sriHCFhOjyS6/MAPl/+pk1XQAsDto/y99qJgHjGMA6iE6ffw56C
	 m/BhJB9qcYlLKhOWzx8jYKPGVJRBWqH6QO3NrLC8+Uy8a5n5Tww1onuVT5Mt1PiOu0
	 oGLRg9YLgdldGrucTUEmLxjUaFZAtFITUbIKgxtpoZOdJ2pmmehGp/kdssJrQusTkt
	 i+3MU49l2cp5g==
Date: Mon, 19 Jan 2026 16:50:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HLyi8ks42a9EJ3mR"
Content-Disposition: inline
In-Reply-To: <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
X-Cookie: Does not include installation.


--HLyi8ks42a9EJ3mR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 08:47:17AM -0800, Abdurrahman Hussain wrote:
> > On Jan 19, 2026, at 8:32=E2=80=AFAM, Mark Brown <broonie@kernel.org> wr=
ote:
> > On Mon, Jan 19, 2026 at 07:06:24AM +0000, Abdurrahman Hussain via B4 Re=
lay wrote:

> >> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> >> -					  &num_cs);
> >> -		ret =3D of_property_read_u32(pdev->dev.of_node,
> >> -					   "xlnx,num-transfer-bits",
> >> -					   &bits_per_word);
> >> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> >> +					 &num_cs);
> >> +		ret =3D device_property_read_u32(&pdev->dev,
> >> +					       "xlnx,num-transfer-bits",
> >> +					       &bits_per_word);

> > Are these bindings appropraite for ACPI systems?

> Yes, the Xilinx IP blocks are memory mapped and work exactly the same on =
ACPI as they do on DT.

That does not answer the question at all.  Is it appropriate to
configure an ACPI system in this way?

--HLyi8ks42a9EJ3mR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluYMUACgkQJNaLcl1U
h9ABagf/aoghp1Y6Y854M8RhICiNGe+by6Pr/V/BxZb241odrfLyn/7nAHxdjKtS
TqqQAB4HaML+bxNyrPCuJOgu67pCdCvkT4BZB5BS83c1dbZZJE/Exd9+Z8NJzXIT
YBc6VLlXIf941weUZIN3FRZpd6PFEDp/cXr5R6iHpf+TDFJgiXW0MD/ENHiT7px2
WAsjyICgxGzc7BYKwlVzhl1MPQvFSbQIDJ62DVxNb7tTR85SgX5nsoyupZHXbIWI
lXziReTXcXd7zNdaTbBN2kglpHzFSzS73ye/d01/OYCfqnFeEg+KOSb5kV/8rsVK
vU0Ep4TkNfhK+8Cra/h1Ep5Q+xs1IQ==
=JOTa
-----END PGP SIGNATURE-----

--HLyi8ks42a9EJ3mR--

