Return-Path: <linux-spi+bounces-7741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D410FA9AD02
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EC9178CAE
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED74221FBF;
	Thu, 24 Apr 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDY5HUPy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E01FE45D;
	Thu, 24 Apr 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496961; cv=none; b=UTM6OXyRvpDSjURNsXuWdgrkOdGi3rwTZeWQ22a/vBPm+50B3rgD9eVPFZl4JeJgAcvN2/8hWX/tlnJV04lldPkXggjH83TuolQ3Aq+VQIjMsJYvMAJWMAg7y9xq2zBsXS861AxtG+apdDb4303rC0Y/YY+Yui80cl45AejvWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496961; c=relaxed/simple;
	bh=QoO22iMaM/sq2uWj+Xo2/VbeVEto6Z+yVbMKVEVKG/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1EABcqYTu2gXgORPgFbeXvwDDWFaFHN2XtSyoJ6Tt/XMkmSKk+s2aQT9LI0Iv1ALgDl8HKX6ZEFMH04HtmHCACQd3/Tn3mmjiKJX5WGZcGLUNT36yrEu0TotvJxsF8cI1NiS8nw+ebYBq5y3njPd/Q+TnZYxbu+ODlQgX9B/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDY5HUPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F441C4CEE3;
	Thu, 24 Apr 2025 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745496960;
	bh=QoO22iMaM/sq2uWj+Xo2/VbeVEto6Z+yVbMKVEVKG/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDY5HUPy2Oo1HefXK41llPmX2EPLM6M7hrtrq5eGUzaFKPFE6u0ODxl7zCeOQhna7
	 X9AZjY7RIT2tp1SOJXdYWCyWS2V78XI0Tq1gkawC6HtobaDEa6uhf1mqbOAgezAHzN
	 wrwEaZqsVTQu5OuV1/3XPWvP0sYZw21SIhrnksRc5bCl7VKA3FcSAnRds9Rd0VQ2pz
	 6kL5KwRnH3CEXs8U6KI0ysLP1H8nV0fvvN9MfaGUTrD0TdPZqCAfzVJtO7/JOrtSYm
	 QdSrFzrjNtBdeu/CSQ3no3E7ePr9iXLEGPUnLiqXnVuqB3JrTrniT1fR4xhadHjpwm
	 oqp+PpKvUAIWw==
Date: Thu, 24 Apr 2025 13:15:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
Message-ID: <8e9af5cf-0098-4b76-a945-f8a96b75e163@sirena.org.uk>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+Zti1CJyFjDqSv9"
Content-Disposition: inline
In-Reply-To: <20250424121333.417372-1-Raju.Rangoju@amd.com>
X-Cookie: Star Trek Lives!


--R+Zti1CJyFjDqSv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 05:43:33PM +0530, Raju Rangoju wrote:

>=20
> Following divide error is fixed by this change:
>=20
>  Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 15 UID: 0 PID: 1872 Comm: modprobe Not tainted 6.14.0-rc7-zero-day-=
+ #7
>  Hardware name: AMD FOX/Lilac-RMB, BIOS RFE1007A_SPI2_11112024. 10/17/2024
>  RIP: 0010:spi_mem_calc_op_duration+0x56/0xb0
>  Code: 47 08 0f b6 7f 09 c1 e0 03 99 f7 ff 0f b6 51 0a 83 e2 01 8d 7a 01 =
99 f7 ff 0f b6 79 19 48 98 48 01 c6 0f b6 41 18 c1 e0 03 99 <f7> ff 0f b6 5=
1 1a 83 e2 01 8d 7a 01 99 f7 ff 0f b6 79 20 31 d2 48
>  RSP: 0018:ffffb6638416b3d0 EFLAGS: 00010256

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--R+Zti1CJyFjDqSv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgKK3sACgkQJNaLcl1U
h9D4Sgf/Ug87foHmzdPAklGOggiE+uhINm0yuB9TEn3DIqb5XTKuj4lIUa/kkwgf
Bp4EVMo4Mrnu42R6Zh8QO/RqpdKN9zFaSRce6cVFe2sWk2BBkR3TLR6w3Pm4Dv7X
k9iX/5+pWr5HJrb+QhFtTqjMo1jY2/4qWrjLUpPxX0Bn18cdCgcERxyj6mwWNAME
YKNWHPqIrCkOUAzLIrULTQdZrAegjjl47NO13WfKIN6g+ZzngAQyuM3CzuzwUUmo
Q+qtXYjbQ/6NYh6JCmaHmy88wYWfsY7Up5Y8Y1+SRMFdiWMvbi3QCcWk14ielJd7
Yt/b0jJASp4Iu2AqQsM+reSyAWZjig==
=DY4t
-----END PGP SIGNATURE-----

--R+Zti1CJyFjDqSv9--

