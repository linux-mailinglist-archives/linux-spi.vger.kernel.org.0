Return-Path: <linux-spi+bounces-5360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC389AE3A7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8271C229BB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86D1CDA01;
	Thu, 24 Oct 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM8swpYX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080C1CCB55;
	Thu, 24 Oct 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768784; cv=none; b=DZ7NeMjr43Oa09ymIGq/bzs5+t2MYSBpUcIWZaCJkTtlKL9lZFkX8VCKr/WdQq05ypi533hri2sa0aHVB0j74fY39jnE+FfBGOH3o5LGt+T6JTOFuXYe0qbyOHAq/5DEJJ4D79qkHGHh6cmv+vd24JvqEORdpZ1gwrDOqNs4jWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768784; c=relaxed/simple;
	bh=R8H0oTrJhlxLauZX8Am2cYhcj+75a4gif8pXEAK16Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+g9+yC95JTDEETR7efNVrOLjuKLW3nYb192R3nKNX9ayhO5menQ94sgMBR5d5JPfvUZb+Rcdo8N5ULFQfQanNZ64KnFZkXLqvamLQ7JWWtzWZvO42f0JAEV9JKAOjUCEWzqjlEVPUWd9OirpxKFlpMWbxSjbsum1QBp9kKufto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM8swpYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC84C4CEC7;
	Thu, 24 Oct 2024 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729768784;
	bh=R8H0oTrJhlxLauZX8Am2cYhcj+75a4gif8pXEAK16Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VM8swpYX6CpbBM+wKTB2ZxyzQKkiHc9ifZN2U0QzK+2MLHqun9l6x6+jzy4OGT6Ey
	 ebDwPiunvpB5Nk7iLupeSXxDDupLXpGCQjXml8pF8poDobF2Z1HzhH0Av7hhaglUtN
	 4V80dcSp9LMk6tSn4U5ww7ypNglUrrUBCYAFvFAQzaiI3DttQdjj9Jgju0dfBXTuHu
	 KEvW1EjskymUnPuezPoIaFI5yrvE4rGEmncEYig2jHstz6mQEyoOolqZr5219YSkdv
	 Fewd3eF8qTiI+h9Mi85CeP8AqOvR9lhF0fqPfEB5qtb5tc/+GhkejkqKpwWVvxfiwD
	 PhhUegQv03euw==
Date: Thu, 24 Oct 2024 12:19:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Dhruva Gole <d-gole@ti.com>, Yoshitaka Ikeda <ikeda@nskint.co.jp>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@pengutronix.de
Subject: Re: [REGRESSION] spi: cadence-quadspi: STIG mode results in timeouts
 for Micron MT25QL01 flash
Message-ID: <99fe47e0-c4bb-4a25-86e1-513d79835c8c@sirena.org.uk>
References: <c2cdfba1-afcc-4a77-8890-7da49c4b73c2@pengutronix.de>
 <43b6b750-3f7d-437f-a62e-ab2dba06827a@leemhuis.info>
 <1127989f-3175-49c0-9611-e30194b04018@sirena.org.uk>
 <ed331ddc-9b61-459f-b7a9-90b7442d0166@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jvHP5gYAIx+jHDm"
Content-Disposition: inline
In-Reply-To: <ed331ddc-9b61-459f-b7a9-90b7442d0166@pengutronix.de>
X-Cookie: Real programs don't eat cache.


--/jvHP5gYAIx+jHDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2024 at 09:12:11AM +0200, Stefan Kerkmann wrote:
> On 22.10.24 18:39, Mark Brown wrote:

> > Given the description of the original commit I'd expect so.  My guess
> > would be that this is either tuning of the lengths involved or a quirk
> > that's needed to disable STIG on some devices.

> Adding a quirk came to my mind as well. I unfortunately do not have a different
> QSPI chip to test against to see if it is a specific combination of peripheral
> and chip  or if using STIG is generally broken on the socfpga. With trying

I guess if you do a very tightly defined quirk initially then it'll be
fixed for the systems we definitely know have problems and we can always
apply it to more systems later if we discover that it's a more
widespread issue.

> different lenghts do you refeer to `CQSPI_STIG_DATA_LEN_MAX`?

Yes.

--/jvHP5gYAIx+jHDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcaLUsACgkQJNaLcl1U
h9CQLgf8DbkA+dPq7vyyHJQLo7hFLdrPwOqvkVVkMtbuIMQH1j4WFCSy1/d+iYB5
3wHXap+R8i2IY/bUicp8g9mp9Yve93Anq6FSahn7iidDA95PVhyioB18iKq5nWpW
q6VRUh7CezQo3AeDimsv0H0ZVJcvGBgLW6ohoPf2+IRR4StnvU1IkgZYRcIvJu42
mOFxbUK79+U6QSSwutGpKCSt/cqsui+bFOqDEagMGLWukuMQVVReWsUHJM7AmXQy
3jBMPlzK1nPQSpGkBeDHufjX/+47YSogXdhIFrjYmSnWGpqplGrpJ60L6oyXnds+
Ixqd3fZfSbVc3bswDM5TgsoQHVnZpg==
=5ZRi
-----END PGP SIGNATURE-----

--/jvHP5gYAIx+jHDm--

