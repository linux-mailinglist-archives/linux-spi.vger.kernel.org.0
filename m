Return-Path: <linux-spi+bounces-12495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC6D3B45C
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 768183002B98
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAE22F77B;
	Mon, 19 Jan 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1vWA/Th"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB0246782;
	Mon, 19 Jan 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843939; cv=none; b=d5yr+yRqHsRy6OgpY8R8IeLHnuBn3K2bI/1LSPLCWN59gaO152DiL260KM0x1D9BMkLzxbC76Z81CqpcksgyKMNIrFwzNRdo220BqihrYn5sybTl3SmmtHvQkiZqamVm4Y5f3Yu2X9yf208a+v3NFYD+1H41C2imDOkAgvz+ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843939; c=relaxed/simple;
	bh=A/iKdKMRrQFaSFIv/yti57gG3uCmwDCA4fPwEwIAd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+XZIOA54Yx3qIG5PUQI6QGPDGAGsPWVcZLBrVNHcQfYVJwZAIH0EuUkJq3IJd2wyvO162QT2HzslBuH6/OMVf7+lQY+tM13IPH9h+kyL2ZT8oYdrDhSENxoeSZbBLfqHnDAAvaCplhfQti0Yu89SgL3YFTa4ot4l34ixmNW8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1vWA/Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A54C116C6;
	Mon, 19 Jan 2026 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843938;
	bh=A/iKdKMRrQFaSFIv/yti57gG3uCmwDCA4fPwEwIAd2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1vWA/ThbDmFYpj53E77IY+FYA+F0yn5aBqz5KyYfgnJelVf181ZB4hOccmOIFuUS
	 0N/LfNhrBCyEeN49ROHXJ0Cxq/HFTVkk/UQE2sAC+DvHh79frOoyqnklHQnaZsWodZ
	 kf8GGoyccKhVGXxpMbn3AadPkYd61ra5NXXMvRMxG3bLP/Ghn1FKClRuQrUisqK//6
	 OuYcHNz2ZKoQXFTFZI6HIa6w+7dDZF0mljbLzVtaEQly+gXbBNIsF/1H+N31mk7u6y
	 nuSKbm9K4xWHHGACuiqGCWpWNAgz/K0f734F6RkynRZVZz2DVhxROlC7LXAKLeW5Zf
	 1aTcUGxCkpMLg==
Date: Mon, 19 Jan 2026 17:32:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FuAS2eueGrIYKRNf"
Content-Disposition: inline
In-Reply-To: <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
X-Cookie: Does not include installation.


--FuAS2eueGrIYKRNf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 09:15:40AM -0800, Abdurrahman Hussain wrote:
> > On Jan 19, 2026, at 8:50=E2=80=AFAM, Mark Brown <broonie@kernel.org> wr=
ote:
> > On Mon, Jan 19, 2026 at 08:47:17AM -0800, Abdurrahman Hussain wrote:

> >>> Are these bindings appropraite for ACPI systems?

> >> Yes, the Xilinx IP blocks are memory mapped and work exactly the same =
on ACPI as they do on DT.

> > That does not answer the question at all.  Is it appropriate to
> > configure an ACPI system in this way?

> I am not sure I understood your question. What do you mean by =E2=80=9Cap=
propriate=E2=80=9D?
> This is following the same guidelines as outlined in=20
> https://www.kernel.org/doc/html/v6.7/firmware-guide/acpi/enumeration.html

You are just bindly making the DT properties available as _DSD
properties on ACPI systems, ACPI is a completely different firmware
interface with it's own idioms.  Does this interface make any sense on
ACPI?

--FuAS2eueGrIYKRNf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluapwACgkQJNaLcl1U
h9CZjQf/Ur8a5p0+EIw+7xw/rnSoaY0p0ub/FutvHYMSJWOUbUQQAOMQWR9gjK4A
dXzC6bUPBn8sJ7rv1lPArhLiRIV3LJTZc8zZqnkA3ilaU+6YHbFWTaZKRiJYhAXc
5GhvbBr8CSVm4eUIzAHvleXcvTYo5jV99EF6z0rlq59yCz3WsB6FaEPOlsVkE3jB
PnrCpdS44my7aEAJ+Z0LFefUsrSP/LSeWEYmT/rMs/QP3rifhX3tTPuggRKI8ym+
oGqMAq4OqN7hikNnxiUEA5KU8S2s/ejBjE9qJzmgc1ZsFhctwadnLv0w5rIShhfv
JPTUWw49fOmWds3OJkAfdnuqAyHx8Q==
=hAAM
-----END PGP SIGNATURE-----

--FuAS2eueGrIYKRNf--

