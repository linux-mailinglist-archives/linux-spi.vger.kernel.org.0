Return-Path: <linux-spi+bounces-1131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68384C7B3
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B8AB24022
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A03288AE;
	Wed,  7 Feb 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlCawc2T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CC3C466
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298712; cv=none; b=qNmXZeWdF57OMr4e9HwJhZOH0cWD7w6wznzsBWHLsFvV8JpDJASgwKhxlYS+lZ3CYNilLgiLJGVIshOR+uu9R7Zjk0NUQ1XKTLHhXJhj87KOLcZSm5MIH9choo4kYTBAlKYgbqzFdKOIym0kgNUOarxxWxL39jyPwAhZuLeXOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298712; c=relaxed/simple;
	bh=+MnEmPiPW3ByNQkxRAp6q2I4EMRUQl7iUXohSuwBMkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXBJDHE7DhkHlcJtGqjInDEDjP3qcGSQlFVMUJk97rVT2H9ETlbuhId9YdZ6+xDCxdp0+dm7vcE0sOuk54/MYc3cIOijNaE3KnQL2r4AZXSnqYMtRK6Eq+0ufIyCZz3yNp0CNOmQTcgTZIeprRJCo7aWypZNSi/H14Qyvcxciso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlCawc2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20617C433C7;
	Wed,  7 Feb 2024 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298711;
	bh=+MnEmPiPW3ByNQkxRAp6q2I4EMRUQl7iUXohSuwBMkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlCawc2TqTP4BCnmN2V6OCsWpd8sjTfk0ZLnqh/KskmS8m8pOwrvHAs2n/pEIsnqT
	 0fQRej8nbdjPTMtqAHeJPIe1x0ajMtueb8OPPXHLGWnal4+iT4cw9cd7ErszMuitP7
	 nUczoWEL513/clXZAL0/8S4kiq9/CQpBHkswVIwcrL37PtdON3bUwdnoJelvKRBT4I
	 0ltgTRYdChgh/thJrj8VpKavILp8aRUMZanCzONkHkFl2Td76nUanJ2Bf3aXjEg2Vx
	 b4H3THQ3tTTJYRG3FiBtLRYuCy+90ojqUZpZpB0KzDGtZ+LuETjrczw1JT5UYuQI8P
	 kbjp+fEXlPT9Q==
Date: Wed, 7 Feb 2024 09:38:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Luis de Arquer <ldearquer@gmail.com>
Cc: amit.kumar-mahapatra@amd.com, linux@roeck-us.net,
	linux-spi@vger.kernel.org
Subject: Re: Regression on max controller CS lines
Message-ID: <ZcNPk5KVq8BkXihw@finisterre.sirena.org.uk>
References: <c518235ce0ccc878726fd1d97d0e56070ed89103.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhavOE9WFwa3UHHP"
Content-Disposition: inline
In-Reply-To: <c518235ce0ccc878726fd1d97d0e56070ed89103.camel@gmail.com>
X-Cookie: You might have mail.


--xhavOE9WFwa3UHHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 07:59:20PM +0100, Luis de Arquer wrote:

> I have seen this has been discussed already[1], but rather than increasing SPI_CS_CNT_MAX, isn't it better to remove this check altogether?

Yes, it would be better to remove the limit entirely.

> (I ended up here because I am using a board with 12 CS gpio lines, and this change broke it)

The limit has since been raised to 16.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--xhavOE9WFwa3UHHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDT5IACgkQJNaLcl1U
h9CpTgf+NznTZ88RXoqUDcAJ/cC1/c/ER7QOI/2hNjUSD+FTLLpUZ9ZbBhjIn4sd
LiMuTNx/JivGXeDhE/ta4dHZU2XocLiTnlGfalw3H+txJrm4I6Ia5xWCl9vkWwXk
RRl7y4wS4klx3i8qgzE7zoiELgbj/boxOmrHbxWgJimQ2JGZByNVkuuPzg96xPKC
rlskG+gPO/NETG7Y7/d/FVJ6zZh+CdIdnUqJ09kDKW4vVSP4/RKY338Wo9s0uo6x
TuKQvXFDp8xe0MVzB2BVgoAQgEl4iHkkqLuP9R1pn6JJc2m6N7jQP7FyfNrGIXWJ
rLM7daGQ8Es2DYsjqOpijr2uL9b9+Q==
=mkVo
-----END PGP SIGNATURE-----

--xhavOE9WFwa3UHHP--

