Return-Path: <linux-spi+bounces-3546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E8914FEC
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146421F22ED8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE7143C44;
	Mon, 24 Jun 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtbH4R6e"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A73EA72;
	Mon, 24 Jun 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239383; cv=none; b=p9Let3bWXjir1B2eqP+JppEjLg17MdymzOmo1VZMX3mqSkOXghFpJMhPwh4NJElkLYnLwZnHA+rOz11aMo66KgWPeVGfZuCghwUT+iRZxH6f19d9uizpOUQErqeioB7bAmskRlNsMW8UeTsV7LwpfFkvISADFqEIoNYvHvSVv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239383; c=relaxed/simple;
	bh=WY5hYIC0PNBIF7V8uvQgCP/BsotrkH9mINLicqCn9KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrxQBA9HZMoj8ksJof244qmqqrCBYUK5djFdE/CrSY34f7HU9eSHWXyk651DYY2JXGxeSzjlkvj46VCH1RLLKJBBZU4odBucMJ3BF8WgZtCPp3TSkz+PhQHIZ4Ppk4u+tvlkxqU/oCb/6wognwytvx9VRnAEdBWXJ9M9Irnj5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtbH4R6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8311C2BBFC;
	Mon, 24 Jun 2024 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719239382;
	bh=WY5hYIC0PNBIF7V8uvQgCP/BsotrkH9mINLicqCn9KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtbH4R6erQHvxOESUyXymA1LgB5ktOLpoVxTKUyEfXFZ3uEmZlLbYO6Y844Pnw6Fw
	 +vNRCjwE2Late2zqXvnQy8HJW8EEPI5Ex9Ylj1BEg937YUS1LqU8Qx4Jj2jUi9jU6O
	 Zhc2ClLLmLz14F30q3Vul601mxtP1fOPy/XQ6oug56MbucpGGN81v1BcOaFlupKNSf
	 nMb/J4sVeU8bGBVYlo10LiKxjke+u7RK4O6ZugQgXhmk9uBmDsQ0nW9zgVGIlwBmd0
	 2Yq84f0XsWMVrBIvrtTmpDDCCnvz5MulsiJrrrUl8TSlz2pMIR/akbLDLxA4+CMxAP
	 RnZOcAVC7w/5Q==
Date: Mon, 24 Jun 2024 15:29:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v9 4/9] spi: cadence: Add Marvell SDMA operations
Message-ID: <67123003-9987-492f-b9ab-718e5dab0acc@sirena.org.uk>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-5-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0y4A91JLAVwHzarg"
Content-Disposition: inline
In-Reply-To: <20240619141716.1785467-5-wsadowski@marvell.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--0y4A91JLAVwHzarg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 07:17:10AM -0700, Witold Sadowski wrote:

> +static void m_ioreadq(void __iomem  *addr, void *buf, int len)
> +{
> +	u64 tmp_buf;
> +
> +	while (len) {
> +		tmp_buf = readq(addr);
> +		memcpy(buf, &tmp_buf, len > 8 ? 8 : len);
> +		len = len > 8 ? len - 8 : 0;
> +		buf += 8;
> +	}
> +}

Wouldn't it be more efficient and readable to only do the memcpy() for
the trailing bytes and just do this memcpy() for the final word?

--0y4A91JLAVwHzarg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5gtEACgkQJNaLcl1U
h9A91wf+MfWKw9rvsqrhvI5pJMUZJBxkHyv12uRMYD//3txZMDXLldRBBJoRqfIA
amkaXeXG2LOqZD78edIt8x7fMRcMr3UYd4kXbtEkkRYPYlN3E30TObWWGWAJFQQA
1Tch/oj5V/ohbLTK3hePmDqx1PsNWomMrxJECYOB7ZY1q8jQ6TObDdC7Gk7Q9Sw0
AMWnIZZw8+eii1uMrBoSd5G4YjuMqMztoQy4nu7s5T0QhwWQIaa11Qfi8dK86ucL
zj4uy/MxflSFzE8BFFBW0TRFn7+tw0r2uw26JXSXRCUX5XLtsroW+mbSm3mPMlEl
Rtl58AgfCIW0OltjGxwuyqDLVHTTyw==
=Pj+p
-----END PGP SIGNATURE-----

--0y4A91JLAVwHzarg--

