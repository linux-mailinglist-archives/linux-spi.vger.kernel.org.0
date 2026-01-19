Return-Path: <linux-spi+bounces-12497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBE7D3B5F2
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 19:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ADC63049093
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D04389462;
	Mon, 19 Jan 2026 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIoG2b55"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4024320CCD;
	Mon, 19 Jan 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847933; cv=none; b=sEb4zPhwr227/7mrviT1LtNy9K0i8SO06VI06t8YhPkSMnjN40HMuMnn2r+mnQmgkaqvmSbQDif4gLMAx4l/5/vO4DMyHhRFqwDrcm4jGzfbKvGAuKbbH+BHWw0gdjOuGiRjTBXp97NVwYjFH1dXDVlBeQF6ZFVWI/8IqFB+MPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847933; c=relaxed/simple;
	bh=TJG3FfXkTRkE2CcE9n4ac0NG1if2XpQ6DPf2Wc7Uvr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbI/YY1vklRwCr2HwGacQulQNCRPwGbtdBH2lbdNGROs0hSSlGRFTSdonkm2rEj9jK84V+Jx9CzP6A9YyWNnSD/z251YzMyYv6EeaYE+aEPxBcGv+8D/tzsQf6xFIZ8P76G0C7CdhBMyn17nC+jkLgiGuJzgJZLYAJrEbB2UrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIoG2b55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A820EC116C6;
	Mon, 19 Jan 2026 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847932;
	bh=TJG3FfXkTRkE2CcE9n4ac0NG1if2XpQ6DPf2Wc7Uvr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIoG2b55slYzmKtI+uPZ2lT+jERhCK32XMEJgtiinrAmgw6BlUSFeb7c+7YIdQjJt
	 EcNuYC4i0e0zi9SlcdEtvMI0/deLdMmoso1ECjFoiYz9BCoebA8DiCccITzEDcxmZd
	 D/y6fGcDPoOlktHzYud6yqmcsONYGCwNLQ6KRP5DNIxUketUslPPul/D3y0TrnoJ3H
	 29qeG9TZslgAVMzV2MDNUMBLKTaOPVovAeKVGIVoafN2d9zaCt4lwONQCyapsOetz7
	 A7bOQY2nsSO593ZPk+moHk0M+YM1I5Uvowrln+PE3pgp/sEJ7LzMd6JS945OJ245Ni
	 FHdC7SI4r5Xlg==
Date: Mon, 19 Jan 2026 18:38:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yr3Zwye/gBaAHNhT"
Content-Disposition: inline
In-Reply-To: <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
X-Cookie: Does not include installation.


--yr3Zwye/gBaAHNhT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 09:47:11AM -0800, Abdurrahman Hussain wrote:
> > On Jan 19, 2026, at 9:32=E2=80=AFAM, Mark Brown <broonie@kernel.org> wr=
ote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > You are just bindly making the DT properties available as _DSD
> > properties on ACPI systems, ACPI is a completely different firmware
> > interface with it's own idioms.  Does this interface make any sense on
> > ACPI?

> From the above link:

> "The special DT namespace link device ID, PRP0001, provides a means to
> use the existing DT-compatible device identification in ACPI=E2=80=A6"

=2E..

> Is this not appropriate?

This was specifically targetted at some embedded x86 systems where there
was a goal to reuse device tree bindings for things that just can't be
expressed well in ACPI.  _DSD is generally considered tasteless for more
server style systems, AIUI the general approach preferred by ACPI
forward OSs is to use some combination of DMI quirking and registering
with a per-device ID (like the per generation fake PCI IDs that Intel
uses for all IPs on their SoCs).  Just blindly accepting _DSD can end up
with something that's not used because it's not what the ecosystem
wants.

--yr3Zwye/gBaAHNhT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluejcACgkQJNaLcl1U
h9D9WQf/ejnLfZnKfjoUOCRr/OyYxlYQYG5/C3z0oW96iVMkZ+jfUoRQQU/a71PA
2gjGAH06p0iahNbsNf7b8Fn8YUbs0MJQyW5mUbW/IvEUupw0PCTCaAn6+9tOoxxr
iU6/mcgBeIiBLLnoxtEswwp2oV4pWyB8MDmgcKMCH9XOuaY+nlRNubw1vbl/Jp3F
ZNFvouH7n0jPA6bGGCTzNdIYPbT8+sBO9SOouZ/Nc/i98SaMpn4PWN1Y0YHWQxeD
ti4uBjNPykGDfxV2g1Hm+e4cSuxnoxgmPrBidLkPpPJGbhGpHdybpHmi+tI/cTDI
9b6E6xiSjFbyTNzrn9LFxgTZObk8hw==
=8AUl
-----END PGP SIGNATURE-----

--yr3Zwye/gBaAHNhT--

