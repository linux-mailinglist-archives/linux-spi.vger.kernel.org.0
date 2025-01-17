Return-Path: <linux-spi+bounces-6409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98697A15766
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0A3A0468
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C51AA1DA;
	Fri, 17 Jan 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyIT96/4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63561A8413;
	Fri, 17 Jan 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139291; cv=none; b=LDIMiyQPyRiUg6/JVNji1GxSKaVUCK/PR8B0bTL1P12s6h7QMazlSHEZ+madRpNQ93ZK4vlR+/RS/q2SfvWQL6y+sP9smqQnteVC+JxxH2XMqlisl8p7eqgoSHUXmcCrSagkBFv1yI0qvAfZPNQRxWci4uHEvRV/Akfg9fcFVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139291; c=relaxed/simple;
	bh=bF0napYb4DivbmjViKTQNB4sqEIi/PUxHKatOjuEfZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCw1WFMJq6tohr8JQU55/34Vm1UrYzPslYMahWmojbLHl2BRTSy1k1TNCvyc+bcTbBAc7Kc+R0In1FzwBuKcgVF3nDbVdNoB+SkWak3SlFLndRTwUlZB9VF95Jgd0AJXxFVkdKqv/yv96kjbMpa4LJcMahju+px9DXiZnGZwOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyIT96/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0120EC4CEDD;
	Fri, 17 Jan 2025 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139291;
	bh=bF0napYb4DivbmjViKTQNB4sqEIi/PUxHKatOjuEfZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyIT96/4aRD3kZQVB4E0JCBTG4VLBF8ncKl7HVw7DHYnAM1WKFNoer7qCVkTSHDWo
	 0eRqcvOoSUbx8gU7pSKYZ7ZBw9wia3M3l+f5lweQZ1dDe0nRecHt1yJtvWrlAh1ZXL
	 WY9eSfBnKQmSeIGex25hRoDxCKEP8IdlvivT+csYhTDm7kJC15yMOSM9nzSG4bZpR8
	 pRiecZsvmTvs95SKk179p63mW17kF+HYPugnDTJWU5pB1xDDsO87LHlTo50h1Fij/9
	 C990XomxLlLeJbZw6INM7Ese5xgarrTNYGYaeB811c+c2Cw7g/DXqGcRshd73gy/jJ
	 8gWbisaeFcrXA==
Date: Fri, 17 Jan 2025 18:41:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
Message-ID: <1026d44b-0907-4835-bc95-32f9bbcf4831@sirena.org.uk>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
 <87h65xi977.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dNX5crdLfDnIcD4u"
Content-Disposition: inline
In-Reply-To: <87h65xi977.fsf@bootlin.com>
X-Cookie: Q:	Are we not men?


--dNX5crdLfDnIcD4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2025 at 07:31:08PM +0100, Miquel Raynal wrote:
> On 17/01/2025 at 13:21:58 GMT, Mark Brown <broonie@kernel.org> wrote:

> > If you're hitting a timeout that tends to indicate there's already a
> > serious stability problem...

> Yes, unless the timeout is reached for "good reasons", ie. you request
> substantial amounts of data (typically from a memory device) and the
> timeout is too short compared to the theoretical time spent in the
> transfer. A loaded machine can also increase the number of false
> positives I guess.

I'd argue that all of those are bad reasons, I'd only expect us to time
out when there's a bug - choosing too low a timeout or doing things in a
way that generates timeouts under load is a problem.

--dNX5crdLfDnIcD4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeKpFUACgkQJNaLcl1U
h9C9vgf8DscIliyg/nYFd0hYE1WWjcgHGEdvQCSG/q/T7ey5VwCDhMmjOG8JRXwo
4Dhpx6vDb0Rq40PmJht80xKwFKiody8zmYnGTeWMZPysgMj6NqmVGjn+rYiA9WtM
YROHfXQKyJoxZuquA5+D+QqS0IaWaq2jhUnsSsPsE36c+1RDReXKpW5sDUajYM3B
Xe6aDxwFwjCfdYtzsVypS7yRHCCOE2zaXbw6g6R6BiSr8LCLhBBJIAW3VPLh6CGe
vH8LvM6YEpuSmF9Peoi1P8If0089lKXq3iS8WMlB37w7N9WvlUwZoffgDc0vRUqO
htiRMtbWC4OQyZuWC53L7m9w2EMALg==
=uGn5
-----END PGP SIGNATURE-----

--dNX5crdLfDnIcD4u--

