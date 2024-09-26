Return-Path: <linux-spi+bounces-4995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C83986FCD
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE7C1F23D5E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BB1A76D6;
	Thu, 26 Sep 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3dt0nVY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FA13BC11;
	Thu, 26 Sep 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342231; cv=none; b=aoYURk8YYSsgivTvYMwBH+ruW18DxfT2zcwO2jR7/L0MeFxpYtwtuSnZ7V8+6WZOFzjExa/hBaq2x0ncJAwUq0qlwkq95Ye5PqsdgzEEeDjIbnbIUVAhZpG0EMWbOXylQJVqYH9is0QNauyxLuKCpXl8tR64hlbEh3eovaDvqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342231; c=relaxed/simple;
	bh=Z8FKTFtdVkt8piO+ANbZF+sTBj+Nn9taKRQPvsLjPxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfUbNyt5OicWjC+PH101HhKccpeHYx4PPKCZsK72m76BYamer9ttkhTqpZ8XLHxDQ2Gfq4tTUov3LGTtjqL+uJPfCScWg8O0EQ/jTN1aO+vp547W/XJcyq/o00EIgJTubEfJPQ4bEUjabgtLGdYneBUtBI5rPa1PG2Scg/iYte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3dt0nVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84084C4CEC5;
	Thu, 26 Sep 2024 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727342230;
	bh=Z8FKTFtdVkt8piO+ANbZF+sTBj+Nn9taKRQPvsLjPxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3dt0nVYzTvp+tIt04rWJPOu1Z5xu7OU0onTnW0aSAWdVZGCwOtv02uC+X2IcJpdx
	 yLXss8XuV9Hn59paSleTWWkF3ht56MqOdV8K0GBVll6jChCqbeagX6A+PkCs/81G6x
	 SFqB5Oj/ag5NGm1UmMEdIAqqBc15Lt7T26liyBosbTkawR0IstMCtnimPvNx45aPka
	 5VbWORZ7t7zhuZD9NerPtXgpWdwb6XfinCkMzOopn6MIycajxsJNOWgK+JE56U157I
	 PB3lo/SBX+jHC4SjrNnN97B+jvMUKKj+fKbWzkmVhn2Uu6+gNeaUstTpZjf2NTfRMT
	 q6UXaI4kscJZQ==
Date: Thu, 26 Sep 2024 11:17:07 +0200
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>, oss@helene.moe,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: rockchip: Don't check for failed get_fifo_len()
Message-ID: <ZvUmk48R4hZYlO71@finisterre.sirena.org.uk>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
 <2382990.BjyWNHgNrj@phil>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pfXUhZvHB+tfTaAG"
Content-Disposition: inline
In-Reply-To: <2382990.BjyWNHgNrj@phil>
X-Cookie: Editing is a rewording activity.


--pfXUhZvHB+tfTaAG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2024 at 10:55:01AM +0200, Heiko Stuebner wrote:
> Am Donnerstag, 26. September 2024, 10:38:14 CEST schrieb Dragan Simic:
> > Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs"),
> > function get_fifo_len() can no longer return zero, so delete the redundant
> > check for zero in function rockchip_spi_probe().

> Didn't this topic come up in another recent patch too?

> Anyway, having looked up the what the current get_fifo_len does,
> the 0 case should never happen, as you describe, so

One of the people doing random cleanups posted the same patch which I
pushed back on since probe() isn't a hot path and it means if
get_fifo_len() changes again it could silently break things.

--pfXUhZvHB+tfTaAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb1JpEACgkQJNaLcl1U
h9Aumgf+OmYjgmwcu50QggzoSHtpI0nSgOq+vE3c6oVwxPEQXpT3JnD46/QfU58R
n+mNWpljb7zCYn9f+lvCcG0FmVo+q3Y5tjC7xQmaAbn8tpfaxa7Q+UwadpCroJPq
xqFYYTgLq5EVfCWDYvIOEALT6WVb6PdJDjl+/FR9vh3IiOvIDYcXxrHpMvDGTkwI
58w6UiAz2dXfNCaaiDMrbSOM59zIGgP0JJR0/ktb3T4xUpKhbo4H+A2jeFMm8Lm6
hwgdjWx1DVGw6O97pAkikXXLgHSxWcPOWSLhNED2M8Bk3aGbtHTzSa17qYGQA6kv
qpJHXBJrRVNh/IlueKwMcuR9T3hf+w==
=LpZw
-----END PGP SIGNATURE-----

--pfXUhZvHB+tfTaAG--

