Return-Path: <linux-spi+bounces-7075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F84A568CA
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B273AD30D
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BE187872;
	Fri,  7 Mar 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfuiCWPm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E221E868;
	Fri,  7 Mar 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353849; cv=none; b=B5byQHoGCBVIOQ/sw471ZSVWoi6GlYIQ3W8rq/FIPvc60UEnqB0/Knu3P7Luhnuya+LV3qe8xk5X0ruBfXlYABbYRg9m246gOcnWA7dQAy8AgVQu+la3yDQF+BYb+4o1cyhN2HXwQB4LmVXD6lPo+R6z+5hXRW0+Vh66+SkjnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353849; c=relaxed/simple;
	bh=9OCou/LxbyRarhdBQeea7UlQ71nAsQw9C80k68D611o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrB1ppbw0AwLwH/agD0+lnK7B0KgefUSHWmbvI0a3CNHbJjAwCq/vtqYzNlv04Omv6llYr1AupYkDCnSMcQLOLmgiThOqhTxQjatmQYh/XVkqPPN/nnhgv/CudvjlQ+tzRJHb79DyYsLPl7t6XQEXurE6rWgPT2R1tmUU675LRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfuiCWPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D7C4CED1;
	Fri,  7 Mar 2025 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741353848;
	bh=9OCou/LxbyRarhdBQeea7UlQ71nAsQw9C80k68D611o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfuiCWPm2uKw/bA0VZBhF8DvMN4wC3kmsCCSkVg3wQWJ5U7R+GXJRPSD1cOCy5zQu
	 F0tv3C5Or9FtqrXicOro/2LlUsst/NGLfQlses9yin2wxMXfg61LWcx+L1tVWyZg+F
	 KYTF+LiktZxrE2nYFfE/aPFyxVbGp9V7K/wHEyUOZCNoJXRZZ4hxQHICr1fLowvAFR
	 arY7ZGqbHCcAS8i8srEL3Uvn1n+q7pnB4ItpQ+5S9baEFZfC1vzO01fosU9R5WZT94
	 KC/ePncWmhWoe2bcsomh0P5zxsMOYFhpaRKRFHHJDZs+lUTJtp7PCJX8vGRS/njkvT
	 Q77DT+ikKhvzw==
Date: Fri, 7 Mar 2025 13:24:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Charles Han <hanchunchao@inspur.com>, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: stm32: Fix a NULL vs IS_ERR() bug
Message-ID: <Z8rzc8suhKPr5SHV@finisterre.sirena.org.uk>
References: <20250307032530.116837-1-hanchunchao@inspur.com>
 <dfd831ec-e004-4132-94f0-3bdc755907cd@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fKhienEiuUGd3VD1"
Content-Disposition: inline
In-Reply-To: <dfd831ec-e004-4132-94f0-3bdc755907cd@foss.st.com>
X-Cookie: Editing is a rewording activity.


--fKhienEiuUGd3VD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 09:59:42AM +0100, Patrice CHOTARD wrote:
> On 3/7/25 04:25, Charles Han wrote:

> > The devm_ioremap() function doesn't return error pointers, it may
> > returns NULL.  Update the error checking to match.

> No need to copy/paste other contributor's patch by just swapping some=20
> words in title/commit message.

> This fix has already sent By Dan Carpenter and merged.

No idea if it applies here or not but since a lot of Dan's work is based
on static checker results it's quite common to see duplicates of his
patches when someone else runs the same or similar checkers - I think
all the people running these checkers are aware this happens but often
figure it's easier to send the duplicates than to check -next.

--fKhienEiuUGd3VD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfK83AACgkQJNaLcl1U
h9C6DAf/SppwraYcs3hm+tA8JgynoM6XNXFnzcupDCDn8T1COBVOwH2vXjv1IxaL
NtNktXiNdmlS4s1gVJK/xhlNTf24sa+SCj4AiRZd7gVhM/3ajKo/ONnUzTnBsmhi
QdzADx/vYjhHj1kLjG9srDIs5nDtP1lCfcUimCxhu57dZHzEiT4yDSnrQfYZNKva
lvKvTckBdBrDfDmzSAOV9BHmHOZdeeGsmbjpHXXaao2Q5VhpdYO+HG6lds7TzPWw
KJJROXJwjT8hsdstk/n7PyT5C183z/8l9D9Mj0qPqF4Dzd0LfdMig3eTJz/E2Lvd
Okl9rsg7Lkrf0YNo52PA0NMbLNgFKg==
=YO1O
-----END PGP SIGNATURE-----

--fKhienEiuUGd3VD1--

