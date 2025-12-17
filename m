Return-Path: <linux-spi+bounces-11984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF289CC7348
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6DD3007FF9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F100369990;
	Wed, 17 Dec 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9u5uSuw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4187369962;
	Wed, 17 Dec 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968897; cv=none; b=OZogz+bILVJg6cYhb+0TH6ES43C4DYsE1WHgwGyEIVhy1jqzzPIR91q+07LChQuzVlMMfHKkSTtejDIJjHmukYNenJmrn/YK0gMFgq63J4WWOyX+z6wrJi0eMseVR5u0jSm1mC2t8tSlTdYQTHEZOfDm9KUXA7AE5W7T9bCcc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968897; c=relaxed/simple;
	bh=Uznq9mEUv6T74S4Xmp6qiieh29EWHGRHrevT8ui/oog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9opQq1I79NuE7KFc9Lu9dTtCE/eZCP+fagpj6lBs1c1PoWIgnow+zetcOCbVrDLcSXvJCb+X2FRCf6UBWZETzeXrQRAZen2nKkt/sC8IYkar6yer4RQLFBis91FYMuLdLtVhLmta7fhxlcm4joQdZxyGI5aSxsZ9hW5ghdmJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9u5uSuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6DC4CEF5;
	Wed, 17 Dec 2025 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765968896;
	bh=Uznq9mEUv6T74S4Xmp6qiieh29EWHGRHrevT8ui/oog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9u5uSuwqz+y3cLwWfDjS+4Y4YSkibpmT5AkKpgF00lluHELcKpNZWGO1lLF8o0kG
	 0ewnPPyz6ddfxCerpLINVNUSSLF6bo/EHnbisKgyClK8ssNoAZtjjVfblg5Ii0mhZ0
	 XTOfwEcsrfywAGAujq472RYHc79eEvCh0229xqA8kAr3Tgc2+2mggNvw1ZDYB606Ue
	 qiTl7D7Nu5WnBhl/UREyT4cKlo0x5LpDpew1SDb9CwNMFeR/J2txH94BxQhrH+cgc6
	 WtByU3rfD8HtsWlv+UJyYwRkQSrkZPxv05/tMwMFlzGH/HBF/IovTYvOz3U+zhPMe0
	 KPfF7b7ky1XCg==
Date: Wed, 17 Dec 2025 10:54:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, linux-spi@vger.kernel.org,
	perex@perex.cz, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	flove@realtek.com, shumingf@realtek.com, jack.yu@realtek.com,
	derek.fang@realtek.com, lgirdwood@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v10 3/3] ASoC: rt5575: Add the codec driver for the
 ALC5575
Message-ID: <921509e8-618f-46ed-9757-650bb37ff0ff@sirena.org.uk>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
 <20251216071853.3929135-4-oder_chiou@realtek.com>
 <81510775-c277-4dfc-bbe1-d3b75debc140@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KhJPFKIKSji/h6Ex"
Content-Disposition: inline
In-Reply-To: <81510775-c277-4dfc-bbe1-d3b75debc140@intel.com>
X-Cookie: To err is human, to moo bovine.


--KhJPFKIKSji/h6Ex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 11:45:54AM +0100, Cezary Rojewski wrote:
> On 2025-12-16 8:18 AM, Oder Chiou wrote:

> > The ALC5575 integrates an audio DSP that typically loads its firmware
> > from an external flash via its own SPI host interface. In certain
> > hardware configurations, the firmware can alternatively be loaded
> > through the SPI client interface. The driver provides basic mute and
> > volume control functions. When the SPI client interface is enabled,
> > firmware loading is handled by the SPI driver.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > +struct spi_device *rt5575_spi_get_device(struct device *dev)
> > +{
> > +	struct device_node *spi_np;
> > +	struct spi_controller *ctlr;

> Reorder to achieve reverse-christmas-tree notation. Waterfall to a number of
> functions found in this patch.

This is not a general requirement for ASoC, it's something specific to
the x86 and SOF stuff.

--KhJPFKIKSji/h6Ex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCi/oACgkQJNaLcl1U
h9DifQf/Yz/49L9umyOcGn179d8e0YjBXmMCpoFzBUOdjWM+HhnuHGoPa6XGye6W
toeg2mJ5rJSmtdTWtrevVkbWK8LXUOufRXqHGIwVjMIZVgtVu/DBMj6gpALJS6tA
nxUKDmXnV2Qr3OYMUzgm2rHsPPLpleGy3VfXG21rzMOR2ZvECiF2LZ8NFVjJiHJ7
QUzEo0Dq5tN/3BgKIi8JDhUbWrb5CubEe06+/J4QlUtgZytsPuT9rH6tMuRvKefk
LNpDeZ8zSBHNSRuymuaBpQucvBhAiNWBrA+2uNf1bJf57t1eD1gM/SS1STj021+o
xaZ/agcfyfi5PdkYYC72CXqmVQqrZg==
=9MGi
-----END PGP SIGNATURE-----

--KhJPFKIKSji/h6Ex--

