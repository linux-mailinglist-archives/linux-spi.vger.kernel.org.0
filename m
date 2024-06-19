Return-Path: <linux-spi+bounces-3471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8190EF4B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215D21F232D4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71014E2FA;
	Wed, 19 Jun 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEWrYQ3i"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EB143865;
	Wed, 19 Jun 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804674; cv=none; b=T2kkJdijz+JgGokGZdK6S6iRDZ/fDdp9BYiV5bpuuqLZugXeSWTGj2VNk9buVbqwAoVOl7yGWiYqgZfJXomosPgrP0bSVr0QqUPIqcuHizxMsRFgUi/ZUgIcFnm/QOekVAgHVyerya7D/WgltDj7epJMcVEuByJW9jiso1E+Uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804674; c=relaxed/simple;
	bh=KjMzy88T8+MBmxn5ig8E0cRUEWIyobl2U+xfjsORXtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXfa6HROT5ZCH525JGTIACYAPHCpN8WDa4TcMRJ/PW14fwBgGtmdnEG4iLdFKD72RjiALPS9+fUjcn/suz4pTrZgHtdGdMApF9a0WOYQ4XtYkKO7G46x+3uZ12nGSP3EHI2yE1ga335JF+6X2XfbiSyo9Zv97QT2HybZ17o6A8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEWrYQ3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D9C2BBFC;
	Wed, 19 Jun 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718804674;
	bh=KjMzy88T8+MBmxn5ig8E0cRUEWIyobl2U+xfjsORXtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEWrYQ3iBLKz2cKWRGVk4Ru2z3rLG6yvE8pKwv1U9eYcDMLNm1Jx5I5zsoJYMmj60
	 cVFIZQ+rjTJQ+nzb5/PpLqkwgS69Dw4rfU7ETGRsSuDkptz89FdxCKal82/cTt6gAh
	 1gVu457hbZdrhCbwR3LQ0SP2r42fTMYVMWTk/EtXojwghNZo/IsKrhcoZY97k9NYNv
	 2qaKk5XP9B6taQUeYozAxM8iReuZzWShJd+r802l5ZVi+rjN2qIcuI5SWCaGzmWVD2
	 NGp6dL+Bme/JY9VtMm0EF6YnuVZ7A3FeCK8P7weXRPfvAEsmQ40PhzkxSKPB+Woq02
	 +OCzv2u0vBUbQ==
Date: Wed, 19 Jun 2024 14:44:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <d58879a4-a83a-4e88-9f31-e33a38e4572b@sirena.org.uk>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
 <ZnLcjO67FH2weX+y@opensource.cirrus.com>
 <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
 <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JA1kDGm5Wz6DQ6av"
Content-Disposition: inline
In-Reply-To: <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
X-Cookie: Don't I know you?


--JA1kDGm5Wz6DQ6av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 02:40:04PM +0100, Charles Keepax wrote:
> On Wed, Jun 19, 2024 at 02:30:33PM +0100, Mark Brown wrote:

> > That's because when I told you that the second patch didn't apply I left
> > the other one in the queue, and what you sent now didn't apply either.

> Hmm... what branch are you applying this to? Pulling the patch
> off the list and git am-ing it onto your spi for-next branch
> works fine for me.

Nothing gets applied to for-next or for-linus, they get applied to the
version specific branches or sometimes a topic branch.  Those two
branches are constantly regenerated merges.

> I mean I can just resend it but presumably we will hit the same
> issue again.

I didn't mail you yet because I didn't look at trying to figure out what
it might apply to.

--JA1kDGm5Wz6DQ6av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy4L0ACgkQJNaLcl1U
h9AdYQf+LbA9hVzXVoX11tKeG74w10pRKLFCl2Pu2h2uRMsI0vgBlMOy9GZpl891
2N8IXRTtTrBbXVrqfmlhHnzH00Vb3L7ZJMR6QhYVoCE7MOP9tecH8AbTrs2cSDyq
8tUUlihaIVchIBqAtFcubznLGzBdRqREk0ZzHhwiUX/KtnGXYHVlk9p6Sxo1G/Od
o/GljhM0S2fLd0WqdxowLoqPuEfxcTeRfn5R9uIdkenyA0yIxxGMQUHGEm4XQ8wu
9IIagMzOuSQDBnaW8QT8ZToJPj3Dqn9Mc62TtbGLbnzW3UmT1xafpDiFV11cVyIx
/ckxBpN3pimt1CZyE2FwgoOvs2tcMQ==
=AIt9
-----END PGP SIGNATURE-----

--JA1kDGm5Wz6DQ6av--

