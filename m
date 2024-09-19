Return-Path: <linux-spi+bounces-4882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EDF97C90E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FFE1C211CF
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03219DF4B;
	Thu, 19 Sep 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjAqAcGW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170319D8B8;
	Thu, 19 Sep 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748775; cv=none; b=Htp/h5l335doRMQbD/ZcaapjAbgbri9gwCXd7/XjU8KQk+seBoGM/OUO8B/gx2aazU4GJE127UcwuoQq3FaxKlXMWyydkiGsdJoCEmapG9/0fwcjIwnDU0tytOzl1LeMOS56L2QKu4OaFyonzcbEC7kJVRkPBZEY4w0h/kXhoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748775; c=relaxed/simple;
	bh=X4HJKjcUVv7A3ogg3mjwc9zaPWYEZyj1nV+T5ayJ7yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwgzwUQu3ThW8hozSZNMFDW3qwbI+Nr7g4atRGqjA+euiSOhrOJNNw85Qrv0m2VHhvRPApHt58cxmNxJNzH28fHJIkJef8V2jcCHigKjbQuTkj+sQpACyKnWV44+m90Xz5mMQAGx0KhLpWYvsRHGcmljQyyTiicyWydj9h9FG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjAqAcGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00745C4CECE;
	Thu, 19 Sep 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726748774;
	bh=X4HJKjcUVv7A3ogg3mjwc9zaPWYEZyj1nV+T5ayJ7yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjAqAcGWNhOSRSlmQM1q3yR4eoTWLvi9n9saaZ74/ch8nJSNQEHS0SywB8Fw0JbKn
	 iFZBPEmrzB91OKaehhiQteH1xereF2ac75vl6EnBJqXfH2ZwxNuBqNZ0murd47NWpU
	 EfLCjaP26Xt9nCfyJO/8JBNuZCNmrky7W/7MbtO04jObCks9dATOmAEQhz+9rNhh0j
	 AwGPEeZE2EwyvnTvBqM6Cn5+HnRihISInYGz1e+NRUxk7OCfjXBbX9G7ZSvgXDbbX5
	 i6wRk1jNyT4cNUz5F/BnH8JOFFwcGXWX6nmsHEEtWClRJFp5W4or4TZyYIzuehE3YM
	 3f8I5kJfyuedw==
Date: Thu, 19 Sep 2024 14:26:10 +0200
From: Mark Brown <broonie@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: xiaoning.wang@nxp.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in
 request_irq()
Message-ID: <ZuwYYqsBR-uL7F4J@finisterre.sirena.org.uk>
References: <20240906022828.891812-1-ruanjinjie@huawei.com>
 <ZuwBWofLJ3ZbKpi8@finisterre.sirena.org.uk>
 <1e2f2408-b6a3-64fe-b616-05470c75b0f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="od2xPA1l+5UNA5Tq"
Content-Disposition: inline
In-Reply-To: <1e2f2408-b6a3-64fe-b616-05470c75b0f4@huawei.com>
X-Cookie: Editing is a rewording activity.


--od2xPA1l+5UNA5Tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2024 at 07:18:45PM +0800, Jinjie Ruan wrote:
> On 2024/9/19 18:47, Mark Brown wrote:

> > This now enabled the interrupt in the case where we previously would've
> > disabled it - I would have expected the condition on the if statement to
> > be reversed?

> It enabled the if statement rather than the else because the else
> statement has been removed.

Ah, yes - I'd missed the else there.

--od2xPA1l+5UNA5Tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbsGF8ACgkQJNaLcl1U
h9B6Nwf+K2HHBRXGXMBp/nW8zHB0KSGnRG5lfZtwMgrT2CLRiFZAOdvMdse604kw
RgmEc082Bqtq7ewQsCm+iZcEzJaNXETTAYEP50k0teM8yVaVBzbzzJEXUg/juM6T
TY8qHFGB4EVo4YzT7X3VbAVnOCWcj65JC7/4e0qk7/XcYe74gGVlHcs4bqypvSxL
8/c1Skvx8/dQF+brZcIeJaiOW4nm9Kflt6JCTFUr8BRAsWCKw648j4a/SU4RMWlM
3CHpltFN3bJHM8XSMEJUNfciQBB5XbbDyXUscGuQyF2nxnQY/2SpAM3dI0SCw4gb
y6//YQgkNdssQJLUmQWAnK59jZQQHw==
=K9Uu
-----END PGP SIGNATURE-----

--od2xPA1l+5UNA5Tq--

