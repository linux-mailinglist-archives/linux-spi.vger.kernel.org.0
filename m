Return-Path: <linux-spi+bounces-11792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E7CA8405
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9D23385A20
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80589341055;
	Fri,  5 Dec 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyjA9Vzu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62A31A04E;
	Fri,  5 Dec 2025 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947051; cv=none; b=EWUPINsdtG2YRABUNXzqqwzcqZzrb10PkZ7o5S6oUPA5IlWts4g3sj+MQXiywTcSqYSHDryTJ7IyWqJY/uoRFSGOhUOaiOa1iUXo9TTN2fmLaWn9nLrNH+rl75XTAj1qk0ocSKh+shgYh89AzQ2SA1YQkXmn0xNuhjmiOE5EPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947051; c=relaxed/simple;
	bh=fWc8yd+0bDzCw3qQ5ygXRxbKCfMlTU1HktkdP0IaG3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNypahWniV4rOaqzfrrD6lO9jn2EoLkDsNgWNZlDvRqd5NyEDyZsUeh03jrSp4CT2LsJGsVP4Iu2ZKLbyfTrkdHPfOsAEDNNq4c4R61eX5bGhiyQLd/7NlH5xV5UL4gnqNSheh1c3deX32dy2YWoNKjSWcrpTjJMVfjml2Un2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyjA9Vzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2394EC16AAE;
	Fri,  5 Dec 2025 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764947049;
	bh=fWc8yd+0bDzCw3qQ5ygXRxbKCfMlTU1HktkdP0IaG3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyjA9VzuPNg3rClJ43uxFcvXJh26Dujge/ihCyQA1zwNphKcpff7bqSLelH1EEjUv
	 3zlq3QrL1y7Wn/obZsDzR6S50GJ54N+BqFL82ruzjq7Iv/XkQNQMUGS1iISzK6FSLv
	 qxarYcrhx+snd8r101zVrXWYohoANbdxOBBgLdiruzTFOpDXp23WpNLa32Uunt95mc
	 SAWwrauV1m0jvZZ80kHKmH2VmLVDNmKhH+T6JMBKTJFKHRHI6eSbyV0hiZQQ8pQaQi
	 N7wXrzfAG5E6VwdsnkCNThKL6aT0rqEhPoC3WvcZJLlCoHU/XbQd62c9uBQMHHzixe
	 CguBMWGrY42Tw==
Date: Fri, 5 Dec 2025 15:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or
 u32
Message-ID: <3c621482-ba56-4136-aabb-f7614568ecab@sirena.org.uk>
References: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
 <20251205-upstream_qspi_ospi_updates-v1-2-7e6c8b9f5141@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7csFwg/9ZLrMWD7v"
Content-Disposition: inline
In-Reply-To: <20251205-upstream_qspi_ospi_updates-v1-2-7e6c8b9f5141@foss.st.com>
X-Cookie: My EARS are GONE!!


--7csFwg/9ZLrMWD7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 05, 2025 at 10:04:52AM +0100, Patrice Chotard wrote:

>            before        after   gain
> Read :  5693 KiB/s  21139 KiB/s   371%
> Write:   765 KiB/s    910 KiB/s    19%

Nice!

--7csFwg/9ZLrMWD7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmky9GQACgkQJNaLcl1U
h9CS8Af/T+OIuHNNRgwiBToaS3fETPsSl9l1OaArD+o69QCQXSl2pkKOjHkQH4dx
bjtZv6/8//pr0OA0iy6ByRrQFs0x2wFernGEbHHTlrvaexOdYDXeurN+SEcC+wvj
WVYVhSireSHS0yOxmBzpkAQhAH8dSKnVc7/uXwXXNJoYtlT/7PM1vn6P+qaW4AXJ
jTsIwRNU6qXFfV7kePUnZ2bybXN9DnfvcOJRTIqsH+cOEGC049z+7aqEtfb4lOW/
W5yOFBv66JXdnsydbCNAJoGDeTCaEPCtnhf7P5yzYWJN5vBYqehzfWuqVZ57p9j1
lVgq/I2sNCFqD1CyzIsyXNZ4SiOLAw==
=HYqh
-----END PGP SIGNATURE-----

--7csFwg/9ZLrMWD7v--

