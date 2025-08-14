Return-Path: <linux-spi+bounces-9449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F5B2716D
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 00:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E11C1CC4B3A
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609BC277C8A;
	Thu, 14 Aug 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpNbrbiC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452278F4B;
	Thu, 14 Aug 2025 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209343; cv=none; b=DpSqMMLDnnghV6/eRYqEkbauLzEi7vxyhJiC4kWAyW3nKITFOi7Linm+556sA49/2ztSGSnKRgddNy5mSA9zXXvZ9A78LALe2B9wA1//T67ZCK8i0itlwikSQTLRoiCGeg9PCwCah+jeLKfQ27WeCKcvLtmmnYCvdB2Sv1FN/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209343; c=relaxed/simple;
	bh=jsoSuIhXeCFtpii2sOPCdKeocOyhPAH8/h4Y7CKNez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmGO+1vE/DD0XWQ+MZ+WgqJgOMuYwgQDOBpGeVbG+/cxGKep4qt7ldyPAGQKVvYWZ425g+2xMF91xjYIa5oHh9PHBJhJlCz47j87RylvDq6rvOPbtHy1QJtHB17YcdfG7UZ6dUl7D+F0Q96w35/tKaNG5v50R1BL829AMfVUDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpNbrbiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37FEC4CEF1;
	Thu, 14 Aug 2025 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755209342;
	bh=jsoSuIhXeCFtpii2sOPCdKeocOyhPAH8/h4Y7CKNez4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpNbrbiCeF2fpdDqz161W+bfJNH3zCKX9S7gPf7EB9xikNdnGXRl/CUw/B6Ac+Cv+
	 Kse/F+WumyjJWysvC4ORlsOpKf2DiJUufXGoviPMS5gtZmEAV370Mxqg4iaoAPTdRc
	 INBavLz+97xKcw54XUePJhBkmkTGIMq3xPIyJr52mKlR5svF1q3DgY2KW6QvB6fw22
	 XN3FSIwXyBq7jeSKX9E66APOLSxsA4/bUT0pj3Qt8sKaAcYqvI0PlhLpPufXRk73Zl
	 Gf87K8i1KwRAyNZv1fcog/xtsJZkAjwTa9bKaUt1SNKvJQ2kt0bep83v5Td0qlKNne
	 y95XCRMcXVJnw==
Date: Thu, 14 Aug 2025 23:08:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: David Lechner <dlechner@baylibre.com>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
Message-ID: <abe73ebd-56ff-49bc-9442-b7a1f75159ff@sirena.org.uk>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
 <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a/cfWV91tOSeYEDb"
Content-Disposition: inline
In-Reply-To: <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
X-Cookie: This sentence no verb.


--a/cfWV91tOSeYEDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 05:15:14PM -0400, Sean Anderson wrote:
> On 8/14/25 16:55, David Lechner wrote:

> > FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
> > the subject line to `spi: dt-bindings:` on the next revision.

> Sounds like he should fix his filter then.

This is me triaging my inbox by eye, given the amount of irrelevant junk
people send to me.

--a/cfWV91tOSeYEDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmieXngACgkQJNaLcl1U
h9Ce6wf/Qu2YathFr1tHReSCROT8x/3eQhjB1wlLlAwnwTTnitm79RarH1yJFVEc
O/Kzlp3QLG6Vtga9heYyMZVZh1UUdXiumEJjSyl7d/fr84lsZ0rJRkpMvcg0v1Ox
giMjHXX2UHGgji5lRfE76zFJIXkeRClunHmIwDFE6tAEV//8fFIDIgTnvUqLvO+2
fn1+lCmyekl0sTT76u0JGPWWc4uFAR3xwMJElb17aeidPOJ36AhuWSr2IEYpsZZ+
9iQS2iQIvpiyyftEqoQdgZTTXtUWbeO4VNDnt2KbRxHu9wcjoQzFAPTPLISUdCZZ
Cz2IUzzHBGyPPFk7zTwN6NG2E3tbng==
=+AkR
-----END PGP SIGNATURE-----

--a/cfWV91tOSeYEDb--

