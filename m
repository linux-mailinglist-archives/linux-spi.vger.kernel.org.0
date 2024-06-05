Return-Path: <linux-spi+bounces-3269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896D8FD853
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE98328851A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077415F416;
	Wed,  5 Jun 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOUGjncM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A415F3FF;
	Wed,  5 Jun 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622519; cv=none; b=poRYCmuiurHvucfMKEN0Iy5YvBnny3sFcXmX5NSZR8i6PXZuCkY81BAYKDsfv8IiHCI6DED1kuvwl2jpIWtUrJcrcBtuQ1B/3mZUveKysM/dZNtmLJyKGvgix0No1aaMVcRRkDDUBB0YqMlXd+VZWc3ZMQM/uaM65Og9QFfvLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622519; c=relaxed/simple;
	bh=SAxDOUUo9A/5W1+X4zneET1Rg60Ehfzp8xnstsBp7NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGzPwJWSoFE8u3DT5kfXSrX1Uvs3EjdduaDPUb1Yu0ntYWrE0tsqxgewd3MZueRYF1SHNN2koQygg9Wn14DKo4CvU2g4nUuofP/rpDW9bGST2Hfo2ZhaqYmQZFRvqT1LiWq9SqQ9h1pPCL4HFv/AXBxchVd0doXOO6+t86ztp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOUGjncM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD12C32782;
	Wed,  5 Jun 2024 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717622518;
	bh=SAxDOUUo9A/5W1+X4zneET1Rg60Ehfzp8xnstsBp7NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOUGjncMuz68FPp44Nv54A+nHg1HlqduA0CxbIUCR+3Ir4f82dQbC7H3u3G4a+nTk
	 HfmyFyuEwXTTHvw30OrHtow45q+5KFuB7rpZ+spSHdCBJW0grGjNPdZW/LSIyX/EVx
	 f/v25K/I+6tXflLcFJanLsFkIA+fKB0ikjOEIDp/6ruyvsq0sqLSbUkaWDQmA52n7J
	 fsFLhNon99Ydt4fSNYZWSjZpjCA51yG5NKMwri0p+4TvUSMkqivpyXhcthE5H83wjC
	 Dm0mHGqh1YKLwKbZhYxU7XHiQB/K9OCnmdS+ly8TVARD4RMa5O4xKGf3AdTSNbA7ZO
	 rsVVhsMuDutLA==
Date: Wed, 5 Jun 2024 22:21:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Refactor spi_stop_queue()
Message-ID: <58c2f209-1553-46ec-a471-2f33afb20139@sirena.org.uk>
References: <20240510204945.2581944-1-andriy.shevchenko@linux.intel.com>
 <ZmDTuqMTR-KiUyVO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="80nll8J08/D7fgTw"
Content-Disposition: inline
In-Reply-To: <ZmDTuqMTR-KiUyVO@smile.fi.intel.com>
X-Cookie: Simulated picture.


--80nll8J08/D7fgTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:08:10AM +0300, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 11:49:45PM +0300, Andy Shevchenko wrote:
> > The refactoring makes code less verbose and easier to read.
> > Besides that the binary size is also reduced, which sounds
> > like a win-win case:
> >=20
> >   add/remove: 0/1 grow/shrink: 2/2 up/down: 210/-226 (-16)
> >   Function                            old     new   delta
> >   spi_destroy_queue                    42     156    +114
> >   spi_controller_suspend              101     197     +96
> >   spi_unregister_controller           346     319     -27
> >   spi_register_controller            1834    1794     -40
> >   spi_stop_queue                      159       -    -159
> >   Total: Before=3D49230, After=3D49214, chg -0.03%
>=20
> Hmm... Other more recent patches went through, is this lost in cracks?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--80nll8J08/D7fgTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZg1vIACgkQJNaLcl1U
h9BmhQf/SpUO0aQmrEek0HgbtGMVEMYa6zSeboXhms8aRu6z9Nbvk/FSgnEjU7t5
TLpko8Z6+wT3GhXvCB7QKZRV/MjvZm1UvXid5yi4tkYDkfcJfg1qirW3WVqffQSB
4+epVyqsCGQxn8X3pJ9FVnd3JhX/ZY+biACE01rMIkK/LRyfqT3RSSyyj3So/W8n
K9WodcjkouJeOQEdJmYXdV/u4jA0kHC9CcB8mUPRgU5Z2wEWkLkNRH6146q1h6d1
2GwUeZJogLeXBqCV3shwGOp6cDMTXORPL9fJUge8lOYE9xv9mhavg3QqsNJrl82t
1IxRSGh5Hou+MnBNJYmObhwfVAma/w==
=VHhh
-----END PGP SIGNATURE-----

--80nll8J08/D7fgTw--

