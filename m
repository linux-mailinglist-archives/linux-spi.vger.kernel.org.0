Return-Path: <linux-spi+bounces-12004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE233CCB09A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080B330141DD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C62E7BA3;
	Thu, 18 Dec 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbpAqrez"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD312DFF1D;
	Thu, 18 Dec 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048261; cv=none; b=PQUgVNdTXNs6Y2dWfD/QmvTE8GEdk/6WjFVQNWXqGjz6NvaVbnfX9FU0P+0dk/ssLdEcNMVZtTMy72kZzEVnM/g7HQqFqc+lPWwD16H7rKMEUDGYaNSJZX/jlGwjb8HWV5g/Mzx0mtq0Eu7Xu8Iyy2o43A/EVL73Rbfu+r3rsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048261; c=relaxed/simple;
	bh=ksxqoIpdRbVVOvr7sIw8thdMYg/F82UJczT1uvG5tPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovHUYDdumyHL17X41vc9ptSHMYF7Dqn4aLF1DIYZyJobSy8ZfqVNvueAtZIMUt374KaSRpzl49GRjmnkpjCS2Wfq2XA+ox11QV2xY8lv6JReQAj/+MGOzWWllHersF0+TD60MkBivbsI8TWydYyZrc/TY2+R96aklhvaOuCCytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbpAqrez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C19C4CEFB;
	Thu, 18 Dec 2025 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766048261;
	bh=ksxqoIpdRbVVOvr7sIw8thdMYg/F82UJczT1uvG5tPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbpAqrezzp8uuA2ZOZDduDt+vMbOJUBBZbkTqRAjEFQALTpWw+lt5pwId+qr1w2p5
	 JmlAxpLrWHymWA+CC9rrgxPsHXV+BdkE+kkkJ+xSj01np0plzIOjeNYvOFex1jkoTL
	 NIkM8vRJJHMchwQ1usAci5W+FALJgxX1JshGGBOJzf31ZAkLw1RswHsa19dwYIJynm
	 PnADjA5oeizDVvhses5PaZ7llu9wZe1YY2pAZLtGySr9aDOT+UXzK8ACdiuZFlLQvG
	 21HjjbUrGy/6svePzpAkMDjSNohf3ioqVzKny9zwTftZ1M6DAUJRCYmcwVPevfgCQl
	 iHL1P/MmCW8nw==
Date: Thu, 18 Dec 2025 08:57:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] spi: stm32: properly fail on dma_request_chan error
Message-ID: <6c153ddd-a586-4138-b3c4-793278d93305@sirena.org.uk>
References: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
 <20251217-stm32-spi-enhancements-v1-3-943348b8ff66@foss.st.com>
 <129a4deb-ec9c-41f0-910c-57cd43d17fcd@sirena.org.uk>
 <20251218083840.GA1530150@gnbcxd0016.gnb.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dFnOC0IiRVMkfwqs"
Content-Disposition: inline
In-Reply-To: <20251218083840.GA1530150@gnbcxd0016.gnb.st.com>
X-Cookie: Close cover before striking.


--dFnOC0IiRVMkfwqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2025 at 09:38:40AM +0100, Alain Volmat wrote:
> On Thu, Dec 18, 2025 at 08:00:57AM +0000, Mark Brown wrote:

> > Bug fixes should go at the start of serieses to avoid spurious
> > dependencies on new or cleanup changes.

> Actually I wasn't thinking about requiring this commit to go into
> stable branches. Without commit, the driver will still work even if
> there is an issue to request a dma channel since it will fallback to
> interrupt based transfers.
> This commit makes the error visible now, ensuring that if the
> device-tree indicates that a DMA should be used, it will either be used
> or probe will fail.

I'd not send it to stable either (admittedly I generally stopped tagging
stuff for stable entirely) but I will apply it for v6.19.

--dFnOC0IiRVMkfwqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlDwf8ACgkQJNaLcl1U
h9BLLQf/WR5nHoveAuyhE2UOKgmFpx1YKda7i+ruawoOM0V7DPsliCaVggh/eF5m
/uZhfiWjK8bhx5ag6iz650iYXBTmfL7J6joyuVeazhRgkVSdS6c4ht08aUTR/OUv
rNcwH8Zg4/yXYy7i/PheBof1pLD3O1RFIiMy4cl4TRswYGf+u98VZI+2EbQ+TcoE
WWqspzdkwoluh3pf918qQL8q4A6OOiM3fRDx6ca+R9xAjWhHAtSGyq25Oj8H8gcO
gNQ1zBaIfrKbFg8TUHzPS2uvORvxBD5pDrkvVeti4HTjv2QiqHgwmNL3fuwqBx0g
EJfAbZsL8053B8Pig7u3A24gWYwFiQ==
=JC2D
-----END PGP SIGNATURE-----

--dFnOC0IiRVMkfwqs--

