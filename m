Return-Path: <linux-spi+bounces-4883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15F97C92E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00B71C213CB
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1619DF65;
	Thu, 19 Sep 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifzF/bi2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218B19DF67
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748963; cv=none; b=sv0n2jUKaPpzoKbPnxD8R13xp3HOhiuOhFUai6MrxzGO1wFL16+a5Pci8kbitEnTc4U65G7w3btB57HBZJyBltA2u7ORz1nHMu5huveMkhxCcol5FbSn0VZ/HzJ1+g3yHR8E4qp5ZiCfFvChNOtozEBN1IcdN/zzYUXxbiJqZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748963; c=relaxed/simple;
	bh=+QfIBqtupXArhr6g9yHm2/OrjYPVUhIxcGX8XaQDpMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmsgacbSDC9cg8AJ+GnHeKmSBX8w4GjPQlqmhzySbNFKBvrWu74RVjjqFNqF5YkcWneGE/2uoXMjm7zmt72emaE4mi3eDR4z96hToYaTPGLO4bYF3FEqUFJ9cBzuFMgfiL/oXJh6tlKb8kaEajscNl/tz3t+XjNbhD540n0nhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifzF/bi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058B9C4CEC4;
	Thu, 19 Sep 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726748963;
	bh=+QfIBqtupXArhr6g9yHm2/OrjYPVUhIxcGX8XaQDpMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifzF/bi25qBN1I18BwR6X32wgjhYj5kkiQa6Xr9vlKIBWuxUu9YrUId86r/rod+Y1
	 +GqEdtZfj+cZ/n4f3RUiaaoUk/G2ib3wU1pOtzJ2SMyEHxrj7Gm0umyJdpeJnE22Oq
	 qj/iP9XqQYWH78Hdc9yme4xFXOiIxo1+wYO6CwIWXYeU+rOaxdiCpoZi4b4CxcOBFL
	 v+kxo1QnQsbAlAXyVn/HOH431DzCIG3BZOV0EbJ6IRzS2j8zqy1w174zuJGXYO1lIz
	 cKX+3WZARctSywM76n/KLrBNxub+QluJms/bb/kmD0j5JDpNK6jwOrAt6VSCB4AfNs
	 HMEfj6JTpS0JQ==
Date: Thu, 19 Sep 2024 14:29:20 +0200
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: (subset) [PATCH 0/4] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-ID: <ZuwZIN6bPzlmB_Ly@finisterre.sirena.org.uk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
 <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
 <Zuvr5nLxTR53b9Gs@lore-desk>
 <ZuwAoZ5zE16t1tjr@finisterre.sirena.org.uk>
 <ZuwIcdPbSa78agkj@lore-desk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="igX8tEt27bPfAZ+5"
Content-Disposition: inline
In-Reply-To: <ZuwIcdPbSa78agkj@lore-desk>
X-Cookie: Editing is a rewording activity.


--igX8tEt27bPfAZ+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2024 at 01:18:09PM +0200, Lorenzo Bianconi wrote:

> ack. The issue is the 'read cache' logic present in the vendor sdk codebase I
> added in the upstream driver is buggy and it is introducing errors reported
> by mtd_oobtest kernel test module. Since we do not get any read/write speed
> improvement using the cache, in order to fix the mtd_oobtest test, I decided
> to get rid of the 'read cache' since it is not useful. Now the driver is passing
> all the tests available in mtd_test suite.
> Do you want me to repost just this patch updating the commit log?

It'd be a bit easier to resend this and patch 4 but yes.  Please mention
exactly what the errors that mtd_oobtest finds are and ideally why
removing the cache fixes them in the changelog.

--igX8tEt27bPfAZ+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbsGR8ACgkQJNaLcl1U
h9AU+Af+N7hZRk2qCoK01oe3ry/uiWCaumBbpX+18fESF8xb7Lp8rutURWFQ0QSH
pjtf9SkOAdPAMMtXx4QNQRCNNRH9lrL2z/zk8LGEKWjg5aC34Xl/HmmrDjeewPEh
XREOjlQlysFRbuOPQi0QB0Vc+668ne7AILdlaG+NLiVm3ndyUVEs0Yq4ERN/foGT
0W+5RYQLyB2x0BKSkW0rXEx/I9VCw2cJ0OLIPol3SBANn48Ouq/+M4E0Z5nFNIff
wMB3r6lZPLSbOrDxiQc9baw4deR54d2gMdMy1h6B64uxi+ZLvIYQdaUYVp0TMald
0umS1LieEcGPuT4NxqOv3JKyGWChCw==
=fYCV
-----END PGP SIGNATURE-----

--igX8tEt27bPfAZ+5--

