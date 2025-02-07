Return-Path: <linux-spi+bounces-6657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B5A2C3CE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B5F3ACC2B
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2B1F561B;
	Fri,  7 Feb 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq026Jov"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BF1F5615;
	Fri,  7 Feb 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935373; cv=none; b=Je9CfjXDFYUzXmdkaYrrbSfEDqWEvKCT0yTLc1i8ToDDwsodfRv1UnqKh1g6JH1l6yERaVHHRxMquLTs86JKlPa2JdTXIVn3prODMBiDNow1fGyX5IloVFCNL2zOGLiB4jxhjcpZEKCG9QEtaSL5B7MnwDf8A01H4hLLUJlVYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935373; c=relaxed/simple;
	bh=ojf88dhxc0pRcsyVS1I57XmZyRQ/XrFxIjRhU9DWu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOfjOPF8h2OlQQmHWILcH+8VbjmWG0xi5NqsY/fCerizJ73ifYPhT6I8a4GZIVjTrLiaHsYqw0cziiK7zkiwg/+ltgVAOxyoL7nNUo0FYiEgv0CSfblQ22AXwfAmcaRPtpTWW/7FfZykNjQgYHQkOlsQhzqPfp7syukiL1h2Xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq026Jov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2EFC4CED1;
	Fri,  7 Feb 2025 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935373;
	bh=ojf88dhxc0pRcsyVS1I57XmZyRQ/XrFxIjRhU9DWu9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hq026JovajaQwDy/ikLGifCHv4cPbS4LfZNthRBxdLtKbXYLmGMdw4QdEbVU1f2dE
	 9QXe+HFXM1A6IAHuZWnwKPW/WC16gTtIzqpK11NL0NcFExVjKD0HLF5LtgNn0IATdE
	 mt3iSofseORjHhJAypfadAofJLE9Xrj83ZJUwhL/S7Pdty32GU7AiXSU1p4b24zsAa
	 e+lWiMKYksVCD9cKNxh+Pq4XI+V6k+Fn1L5Ofj7Sq2FcFUe2Pe+d6U1gyOIYs/3ghv
	 JINogUeHRaDmUSw9F4WjkD3Vh5065wkXGAWqG6bBrMfSimU6ceW5Ot6Y/luHa+YkCs
	 0SOLpEApptbSw==
Date: Fri, 7 Feb 2025 13:36:07 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: axi-spi-engine: fix missing bitfield include
Message-ID: <7b45b00a-a070-452a-9560-168e5585ac11@sirena.org.uk>
References: <20250206215513.2842270-1-dlechner@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qoW/KnOVjkgeuTjA"
Content-Disposition: inline
In-Reply-To: <20250206215513.2842270-1-dlechner@baylibre.com>
X-Cookie: You enjoy the company of other people.


--qoW/KnOVjkgeuTjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2025 at 03:55:13PM -0600, David Lechner wrote:
> Fix missing linux/bitfield.h include needed for FIELD_GET macro.

This doesn't apply against current code, please check and resend.

> I know you prefer patches like this to fix something in a patch that has
> already been applied, but it doesn't look like you actually picked up the
> offending commit[1] yet in your main tree, so I don't have a commit hash
> for a proper Fixes: tag.

> Do you want a fix like this or should I send a v8 with the fix squashed?

> [1]: https://lore.kernel.org/linux-spi/20250113-dlech-mainline-spi-engine-offload-2-v7-7-e0860c81caae@baylibre.com/

I haven't applied that because of all the build issues that the bots
reported, you need to send a new version that build cleanly.

--qoW/KnOVjkgeuTjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemDEYACgkQJNaLcl1U
h9CTEwf/cJ3gRShrmKyQ7ogFD+6LKBX64/IRoKomRnBPaqpeWYrTaxl9rf4/5LyF
synrLy8kArPYbxfVFnzTa9eylLnEEAhxJJv3cFhG7GWO5+MqmJ/a5QI4kTMoTVcp
0EqPhLiLpHHzo3UpbBjLopRwAiAoo9mgLG2Hb+516WvxjuetsFyeyOdnx+ysmeE9
v4V2chtL460jHUUngvDkgJ1Jmus+eRymWYhPTfNkC/nKkJP7KJAeJRtnEoi9uYJL
ryWrWlw7bsGt8BmBROlwElxa9V74VfyS5QidxrMqIV0OAXQxZiF3a3bEI20tOSB+
9g0+mEQcHqF40hy9XwgagZxjJezsXg==
=Bh0m
-----END PGP SIGNATURE-----

--qoW/KnOVjkgeuTjA--

