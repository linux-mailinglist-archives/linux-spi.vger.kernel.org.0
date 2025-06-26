Return-Path: <linux-spi+bounces-8784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B394EAE9C57
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D14A6021
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49027275115;
	Thu, 26 Jun 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/1xu7Jz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F925A2CF;
	Thu, 26 Jun 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936623; cv=none; b=ko/ngp8qnlUkKjHl23N54p2bQKIEvEkyT7w/76Wy8tjrFq9nPEnWZQ9rNAqyRdnqO2GE6GTnz3HriftxIxFxSqjWeSnwwka3FPnss3+N6O5Ds3DFV8Hlbf59u3hD7JBmLqVdG/a2rp2r+TkDZBIEL0lnl7z4gsA/r/M16kp2Lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936623; c=relaxed/simple;
	bh=PvXnzULHDsB0iScxNH0vS8qfctuDjyYljIyCkRI8iME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C58WhKDaymytV2s+du1YAiAwbruHPL6IKmhZB1q+5WroBnkTV/Ylnjo+PWhTNKZ0PfwykQGo6XbFB0nWBJKVJ5sFIf0WkmW9JlYlVwqJ/98wqXvQiYeNOrG+AuC3rFSwRsncsxuD93J0oFN+phIb8mGEqS6bGXOIGVPIU87JkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/1xu7Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F88DC4CEEB;
	Thu, 26 Jun 2025 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750936622;
	bh=PvXnzULHDsB0iScxNH0vS8qfctuDjyYljIyCkRI8iME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/1xu7Jz1yYgy9ytqJra5ceN/37n2Pw1x/msQ05reJXUeRRgjPr9rwibkOWhAwHuX
	 6luWeOuUrgTKD18U1l7J2bNJoJSt8NqTWx2MxMHEh/RtnYxhwL4+Roc7IjuJhA8GQ+
	 JEnWwMSpEH2dYqywZdDQPKWAZEPXnOCDbobtrXAmLvGF/IWhLJMvvgWXnlwpVf1zip
	 r5cQsAjZQOYxqDERlozzywU7sSPyNL8hECHVKnE+0A0QFNIOuYZe4zgwHf5+OpRlWg
	 nx7Nnh1c62YK8/4VeXY8I0qehmdy9VeX74GEZqNOXhcvVXI+S7oj3CvuBUfAOYQUwZ
	 XoZ4M2wo7O0NA==
Date: Thu, 26 Jun 2025 12:16:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aF0sKdrQercCEDgB@finisterre.sirena.org.uk>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
 <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
 <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
 <aFwQCL0tQh9peb7x@lizhi-Precision-Tower-5810>
 <6fe9eebc-b050-4b12-a28b-e2f0bcc707e2@linaro.org>
 <a7c71ee8-0931-4af3-a68f-3f21fea840d3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24Tny/Q2cQpjNPAh"
Content-Disposition: inline
In-Reply-To: <a7c71ee8-0931-4af3-a68f-3f21fea840d3@app.fastmail.com>
X-Cookie: Do not cut switchbacks.


--24Tny/Q2cQpjNPAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 11:38:46AM +0200, Arnd Bergmann wrote:

> If you submit your changes as a pull request for inclusion, the
> common solution is to put the cover letter into the signed tag,
> which then gets used as both the description in 'git request-pull'
> and in the merge commit.

That does rely on the maintainer taking the changes as a pull request
which you probably shouldn't expect without some prior discussion.

> See e.g. commit 5b31d2d81a4b ("spi: sh-msiof: Transfer size
> improvements and I2S") for how a similar series on another driver
> shows up in the git log.

That's not a pull request - for my CI I generally apply serieses on a
separate branch then if they pass merge them into my branch.  If they
need a merge commit I use the cover letter to generate content for that.

--24Tny/Q2cQpjNPAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhdLCgACgkQJNaLcl1U
h9BnxggAhhjTHbbMk0GT0D/5dfJHbKG+xw/OYKDTqmGr39d+bavHZnUSNcCdv3md
O361xwr6gGgoCtfceQ2Vm3rHgLBr9SbwXbw3hmHYte1rV4uCxM1nn9bqD66Pfjv1
zO9Q6PnQnaquoMnM6bQGOZuUjzWacuISTMlCR2psq8MMncuKhpWJEn4lKyG+uHlY
E997X1TTYN/RbcpZ+sD9IeDGUp5sZ64WY2GNrmQwAAZPQd0wjk8k9rT94XuDikbN
JIkoaOEpvU7axgl5rUPY9bdgi6/yw5SpcT6l23xfxdPOuF2p7Kakoq4bc4szk5wA
iCsn9Mx9EsUm5yKr+mKpgTYncGmzvg==
=9l1Y
-----END PGP SIGNATURE-----

--24Tny/Q2cQpjNPAh--

