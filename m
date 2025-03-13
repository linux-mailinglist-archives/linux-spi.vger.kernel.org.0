Return-Path: <linux-spi+bounces-7118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00022A5F762
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65D53BBE64
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30561267B6A;
	Thu, 13 Mar 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stC1z9H+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA9266EFF;
	Thu, 13 Mar 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875154; cv=none; b=LDoXO5t6U2n+MpMSNBZoNsOJgS2ztdEhCuhA0+iH1UKcjB5Prg2lVPHqiGm6tnJKejjlO9m2T+KR7wndWxEsRNUOiOVUo2DfLP5bPsccssm+Q3frZMM2AadraCfNjo4h/kwxtohdtpfRhXR8rgSm8LoU7z9U7LWnORTfDT7J3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875154; c=relaxed/simple;
	bh=DA6m5+EiBnD41tufQejm+xwXLCCmYZ9MVRi5RH2h/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT73HU+tcuLzlSDrp2lw9tAJ0ZxipCBkB3WFdOjJEjacPncflgrp70vyA56AmHKDwlU+TUGsVmJW3l0jfS4khAVoySczCHF7rvvgXj9L5ycL9Z1bqDzZrivlvwRSIUm47V6PuCwsL7Q9TEZZGwq43fktAXeNlKlWUFGif6zHvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stC1z9H+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731BC4CEDD;
	Thu, 13 Mar 2025 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875153;
	bh=DA6m5+EiBnD41tufQejm+xwXLCCmYZ9MVRi5RH2h/tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stC1z9H+9/kAAGH7QIPLgteAtSiOs2Ne/FJzz6sd+hFcBKSRMtOo5WVeT4SBkbPgW
	 fXxFBvmAscH30Kf8sag6YB4fxOkadg5GNhWMjFqaT1jIErlY2G8XLaRzPUSO9l4o4d
	 uvzRRAL3iiCKsgKvaAZqPNPdl5SJYcB/q/eIKQfKSfujMCQvxefBrwdWs8MbUZp4Oi
	 0jHWkR5GwQgWKx+3ruE8DCxtnsjgovvhyud+olPJtp95CnxSh8+xYcTyMn0+9IiJ6X
	 jCcIcO7AfU4XoiAImYwFf2mv5tF8uxTOPguXXsnT7sEe9bP9/zVdrsewGBJ486pdlL
	 bGnSjugIUBc+A==
Date: Thu, 13 Mar 2025 14:12:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
 <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PN06eFSQcyNoMqyb"
Content-Disposition: inline
In-Reply-To: <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
X-Cookie: A beer delayed is a beer denied.


--PN06eFSQcyNoMqyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 04:01:49PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 12:47:32PM +0000, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> Hmm... It's based on the spi/for-next. Should I use another branch?

I did try to apply it against that in case there were fixes that needed
merging up, it didn't apply.  Are you sure you're using an up to date
copy?  I have ebd50ac3cd97ecae231f92b2d64b68d3c66b3474.

--PN06eFSQcyNoMqyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS58wACgkQJNaLcl1U
h9Cmkwf/U3kUdxZX9DeoVXQXsCXUVGzBNbqMKoGMkOHFqhjouoeG9S76Z+dbLPCM
/CswAb+U/OLFcHDNkUPrl63W1Ei8PzEIZlUv1Hvum36J9RsoMJJdQDNX+15aQkqf
fKLfNeXuQj/BVYKvAk1TRqIbyug90D2IYHyEHZp/GtrjrmRRYvoWoWW3ESIyAjZu
1uv3sSthwMOyxIzQ7jvqGPx64W2h7oCMK3fdYuG0wlI7pWmtHnOrd8k+4LDDlJgu
pDDjNwJ5HXV6nIPXDHT7t9HrfsWZQgGKiFhLsbI8pI150a/nWmLGOu4fVSZg3f1q
dySou2ZDyNb8QiwI2KbIiHufIEG3YA==
=M9Mt
-----END PGP SIGNATURE-----

--PN06eFSQcyNoMqyb--

