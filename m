Return-Path: <linux-spi+bounces-9988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA2B52FF8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9001CC0790
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D1311C20;
	Thu, 11 Sep 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il5mUS2Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE4220F2C;
	Thu, 11 Sep 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589403; cv=none; b=USYSSlsrEm7FyjwdUE5ff2yfW6WZtrl1KiekrnrvhIQtLwmuCvt6/RwqktLzYy5QBTHaYh6uo8oOYVJKGQfnZC1oKJNcCPtu3S97cq5rOx7Nhbalh9E7+umHirSAk9HawqEYE9o4NfUBX+3KPfjvSI2fQvrm9Phh+uigCdnjdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589403; c=relaxed/simple;
	bh=rC7yGzQct+fIEdNhLeLpkS5bCrHbsoTeEY03m8CJ1cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/fz/r/q/JOGbAOcUA8KlKsypuA7gWdEgpnQ0O5+q+f4sWCELPKi6z+o+8oDDlZcUnnGggZPHlzta0u6HmJZNkRR4EiSAc2WfyITPIIrbtdcwQBam3eYFNJtax64Li7MGF4YKz36bF0PcIgaGcdSbU1qDE2qT4BPKS/kTnI88O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il5mUS2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49107C4CEF0;
	Thu, 11 Sep 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757589403;
	bh=rC7yGzQct+fIEdNhLeLpkS5bCrHbsoTeEY03m8CJ1cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Il5mUS2YRuo5E8SpOTZn6CI+TxhZScz+qqVSVErzCfnopnI4KCvGtP2B2os8CmkTM
	 Ekl6GgWbDLRVMyEegKtzC+zuz1ijD2K5GI5NJJufusHMgryOErde3xaKEWUsMRmizi
	 fJeECpvHYP9Q3jvxaO32wRMws3TO6fl8YuQIDHKeRfo9EhM8WLdYpt356y8vJWHTn/
	 HUndvsB2iptcUk3ZTyTdTgy+Im8D1oYKLpkPGzdm9+niPjQBnSHN7lUYjRV8pDUYWz
	 9pjoi3444mAIMV9rmQVNgyXSpEsDpNITdCOGtUNYXOQL0MTXEp3ExqlOo69SnyNyqc
	 8JfRKoaM+fY6w==
Date: Thu, 11 Sep 2025 12:16:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: miquel.raynal@bootlin.com, vigneshr@ti.com, marex@denx.de,
	computersforpeace@gmail.com, theo.lebrun@bootlin.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	praneeth@ti.com, p-mantena@ti.com, a-dutta@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 0/4] Miscellaneous fixes and clean-ups
Message-ID: <d52cb067-c89e-4f61-8305-031315585e55@sirena.org.uk>
References: <20250905185958.3575037-1-s-k6@ti.com>
 <96bc8718-8902-4f2e-be96-1cd5e19a6355@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7K/GiPR7HnIhfjHP"
Content-Disposition: inline
In-Reply-To: <96bc8718-8902-4f2e-be96-1cd5e19a6355@ti.com>
X-Cookie: Your domestic life may be harmonious.


--7K/GiPR7HnIhfjHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:57:05AM +0530, Santhosh Kumar K wrote:

> Gentle ping on this!

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

--7K/GiPR7HnIhfjHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjCr5MACgkQJNaLcl1U
h9CMRAf+JNzKuGVBeItVBvkfRhDFbyZ7YAIfgCgH7MBeo0EGO+5S0zRLe0aPY3J0
B93d19LgZhSROujsThANNooHhWwNRgYPmpxBwda9xzHDIPUSGkbHJcTWchpFT2o1
eSSK0rSK+HJo4qt/uWQbhGOWOZAecwtCnGFhGL4klu19dlqvLGFFElYEM/o5dF9q
/bEaAzZnNjwT1zp8C3qyBHGJ1z6KN8giDmUqZA4vnDHneFv4gVXBBLl7ly8+jv9L
ry1JjQxgSUiZWoeEdvF06FONE2+HI3I0R3XvLEgd4pTHEJbT0+M7xxFcEkRqIqw+
7gXspu0hwS0pUHlD26BNdUTofknzvg==
=gRo5
-----END PGP SIGNATURE-----

--7K/GiPR7HnIhfjHP--

