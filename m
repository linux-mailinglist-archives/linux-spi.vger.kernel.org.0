Return-Path: <linux-spi+bounces-8913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC6AEDECB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B33F1886DFB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEC28B3EF;
	Mon, 30 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A//kAHvq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAE28A738;
	Mon, 30 Jun 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289425; cv=none; b=ll8j2bhkixkNVj+9zvrjuGE4ZtPgKZ4fw54rTeoGbf5W7FuqM+EvOVDj1HsDEM7FyeUJxr4OHeqSNKhpKpSQJe82novdSMTDNSLQutMbTosBKbV96DSSh6GdKB5nJJ7WwfSfPdIeA9mjoigdtKdG4TxYsDuYsGTusNXGb9i0Jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289425; c=relaxed/simple;
	bh=k8g9WvwbCnopbVS0TZ7r7XGLH05jg43Y4ARU0L44a2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtOa2eoTe/qBSofvdAjyYd83+R6pf0Ek8+3yqWW2xdvAkMGvm0ecdMNdWIwt6AYhvDhmn/0dGdJyhdQnOFBv4yS4yV9PiJi1fEpme0w9sB5pBLU5yCDpGrc5XODqiuvrm4EfewWj7Y/Lfc1dmn4JnypaInmdDkSTjBGdHUubSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A//kAHvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA4EC4CEE3;
	Mon, 30 Jun 2025 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751289424;
	bh=k8g9WvwbCnopbVS0TZ7r7XGLH05jg43Y4ARU0L44a2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A//kAHvqiR/9lBxy6BGD5ThUBrzqCnUf3a7UdUkl9Z6ytkKYXLjFRs/2O+2xxHuAf
	 7HGserKyCUtVjFxiaUnKervlLqv5ggZ7tnjH1vFd6P0ScdLse8zN0NDHBYLv4YVepM
	 nE3cXo4ndN40ZcqTRSKb3hbm/ykfA7EeIf/c9Wx2+S0CBKp2jXUROs08GbSHr/+aJZ
	 k4DC3EQM0fJ9QGsXloa53a/xzYsHlX5fq69A0AyOaL2jtlU/lExB2e6OrhSzocicE3
	 nZVyjatVehAGEr9j7L/AgC5iMzd34fi6RfDcyLhCrEufYWntJvxkUdTSuBIyfGqAzA
	 33Vs47G3ysrtA==
Date: Mon, 30 Jun 2025 14:16:59 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] spi: stm32: fix sram pool free in probe error path
Message-ID: <1170cf86-b76a-4462-89d4-472298cc4034@sirena.org.uk>
References: <20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhQ8pZKGQFQ+/8bQ"
Content-Disposition: inline
In-Reply-To: <20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com>
X-Cookie: Say no, then negotiate.


--uhQ8pZKGQFQ+/8bQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 02:59:23PM +0200, Cl=E9ment Le Goffic wrote:

> Changes in v2:
> - Add Alain Volmat's Acked-by.
> - Link to v1: https://lore.kernel.org/r/20250630-spi-fix-v1-1-2e671c006e1=
5@foss.st.com

There's no need to resend to pick up tags - maintainers will do that as
a matter of course.

--uhQ8pZKGQFQ+/8bQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhijkoACgkQJNaLcl1U
h9BMHAf9EmAOHlF+CSGEKHuxUPbjf2T1MfR26EqamIjCucvKDn2DKbNjugE9TZpt
1u/eBORZpXpMHNBtfNDaarrltt2zPOo7WTcqH7/bt7tKPHLvay42Vm3voCGUUwDS
0fSupWmcZxuXnSvFPEZs9UtFqWqCSnP7XI1nReImwlf8dB4EV/8AIEW11bjRPbZ4
lGw+kBsvhrW8WwUykgdg6xtYXBrCc4WKJAAC4EdvCVlUqKzryrGUb/Kzj0vl0DZb
6NGZ976iCyZuJZjRCxLw/0MF/hNwE01GyrrKaY0QXJcsxRIlDYcjxwr4YDtYFt/K
38sEAlJp4ATzVFTK+vvrcKCyg/5wQA==
=eYhh
-----END PGP SIGNATURE-----

--uhQ8pZKGQFQ+/8bQ--

