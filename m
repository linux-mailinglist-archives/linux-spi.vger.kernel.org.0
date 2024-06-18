Return-Path: <linux-spi+bounces-3437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FB90D825
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D5F1F23FAF
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EC48788;
	Tue, 18 Jun 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPBMHbIJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA1482EE;
	Tue, 18 Jun 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726781; cv=none; b=fLCAFscWJlYqsC8dF/AMvWRJdNKaqj9rngdcwgEMy3Ps0CeX8nSXnUM7EfcKHU6ZXD9p8Q2CK+0Z83QYSe0wBsVvk6Xha9xuZwNK4Xi72IAM/CpWOIi5E9PHJQJ+M9lo8yGQAlBhivcSvOe1W7zgQuBqgVmkrJkF+enzI1wfLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726781; c=relaxed/simple;
	bh=oBKM1LJV8ZYOYaVKPrKUh71IYJ/uxB2+DXWKBB+yrPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm1mP6adzMAI1olLAR/1AcEhHMJdrLtyFtSv3YQoLYoeMsmxNmXf+lDPcikzNEY8qrz1iOslbM6LQ4AF/FvllLV5CbddcbhUtC/rtpd2UuD95pNe7h5R6fuL34WWbXHgC5CjxyoHzAu/rFsql+yNapJoTLFP1cIKTNlAbKZ77wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPBMHbIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28E7C4AF48;
	Tue, 18 Jun 2024 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726780;
	bh=oBKM1LJV8ZYOYaVKPrKUh71IYJ/uxB2+DXWKBB+yrPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPBMHbIJKlIzCXe6FipDG2ksaDBDxuvTLCc4B7sGcOGKGXkfR5W3mbfYl7ah8kCxl
	 J5cMLc4bv6PZ2BCduZ8oWgVA8T8TwsmsVNF7mXNitpCvbTXVQiSJk5WEjf+N1WfA3R
	 /Ot/SdhFVB41aZlTWN32YK9ePV1I8vEF7U9mb4xcKuzTjtbOOFt/UAWXlgA1/Aq3sK
	 2FMDF2eFIOxal4W7CbThARjqevUhpReVfUtMJKVelJUDb+ewEHvUKNeNNXvOmfmyxr
	 2f6oymofmFld3CeeR8cpEQ2Q0z23hOtp0L0udCugyNGWd7+rtN2brfXUe18MUtOoHs
	 iGQ6EukfBfP5Q==
Date: Tue, 18 Jun 2024 17:06:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 2/3] spi: cs42l43: Add speaker id support to the bridge
 configuration
Message-ID: <3bcb0b44-8885-40f9-938d-07b44116f3bf@sirena.org.uk>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
 <20240611132556.1557075-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5UoClPS6UrjhK232"
Content-Disposition: inline
In-Reply-To: <20240611132556.1557075-2-ckeepax@opensource.cirrus.com>
X-Cookie: Printed on recycled paper.


--5UoClPS6UrjhK232
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:25:55PM +0100, Charles Keepax wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> OEMs can connect a number of types of speakers to the sidecar cs35l56
> amplifiers and a different speaker requires a different firmware
> configuration.

This doesn't apply against current code, please check and resend.

--5UoClPS6UrjhK232
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxsHcACgkQJNaLcl1U
h9Dr0Af/VJ34RJgI9pWc2293sec60rEFIMRvjAcIeSFJYY4WLxiCEoF/nLxdNipj
jXG2fanbfi0Ldca9aMeEvt3k0SVm9X6IpoCDkg3uN0hYUu/boRmFgmBlkzvxGRMF
T80WP9r6qDCNev5vY1qpWvuCJ6bn5ywvyKyo51KMvHjU1q+bIs8dMKOGjrdwIV1D
o3voy2gjUNlFug6fI67EQips9OObvcwc7YhzQM+gepHJayuxwam9K2PmLuwflOJW
Elu6u4Qm3JvXCCpljWII0CDHv5LoawwiInhDEzi91OF2pQF1Rp/zbrMHXb8K6ZD/
lN1ywGeOuiX/BaQ//Q3xT8WSsq/1Fg==
=9CfF
-----END PGP SIGNATURE-----

--5UoClPS6UrjhK232--

