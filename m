Return-Path: <linux-spi+bounces-2943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E838C8DE7
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2621C21DD6
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268513DDB8;
	Fri, 17 May 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br3RZU5R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0A1A2C20;
	Fri, 17 May 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982959; cv=none; b=kfC2ZFWQorRhsrnJO+Ezb6VDq1h68LIWJsF3SAHz9+h7qzAk4FAEmB6Y7WpKC2xdYgM9jR3i+CnC0lDC6O3hfBxEXYNFlWox2MdJyxo+RAm7VXNLbC5QG2sZBMbH1dWmGypCF4bYE4Xmony3Ap48wUxfxig4wIyjPVwuQFC+KMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982959; c=relaxed/simple;
	bh=ghGC/qD4YYwRu7VJcfFZKkyW1l1SLUi2sKVi4dYyITU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy7la/z3+T7I7zmRMm08rNJGgSO4I7Q5xXsvP7RV19T08wKwMZvi9OA9m8fYEqRgHLeAgvkDfXAMeTUe9IzcdtR8fOryk2jCSrROpsJl0JjlRLEn7gp8CTeNVLemBevZ6XHMkEdVpGGmE1YCHzZOOeTNmDuR8xdkfLyrMDmYUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br3RZU5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB900C2BD10;
	Fri, 17 May 2024 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715982959;
	bh=ghGC/qD4YYwRu7VJcfFZKkyW1l1SLUi2sKVi4dYyITU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=br3RZU5RKzjPkkHDhTB8a7BD6A+j+/+FAEnnMgM1Bm7UG91jxu350+15IV2VZmNGC
	 TBStr+E8Il/cgwT10FinDZTIsb9r9Ixtrze19b9P73XcXKyYF78p/ze+Wpc4lnktlj
	 JiXS8SvQIYFS5KfbcMws5tGQRzVU0gAhZioL+7rt1ehWug7WEslrZM76+a3gQZGkeI
	 Li7NNgjiXp3K5+5R49z3Wt/VjrCvEUc+vZdSeg2s4mXXXz1/+gEiv1u4iA7OMlq8O/
	 W5XInYZvDmmOeqIMokgHTV/aHppPS5VyL0N/YNB3SyEHKUQ3ZQokwu1Vt8NjqBagYf
	 yIpV5sfkrDPwA==
Date: Fri, 17 May 2024 22:55:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the
 struct spi_gpio_platform_data
Message-ID: <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
 <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lx1NAW7LWTAVBckq"
Content-Disposition: inline
In-Reply-To: <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
X-Cookie: Function reject.


--lx1NAW7LWTAVBckq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 10:42:03PM +0300, Andy Shevchenko wrote:
> There is no use for whole 16-bit for the number of chip select pins.
> Drop it to 8 bits.

because...?  It's the only field in the struct so it's not like it makes
any meaningful different to struct layout.

--lx1NAW7LWTAVBckq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZH0moACgkQJNaLcl1U
h9DPZAf+Lqc9Ezwvnd8c3HfCfl8KYyxemvF6LAJrcp/+ZxXZI9AfBNeDIKOrCXQl
nTLcrteD3bfQaOfM4Bm8ZpScR5SGlZYKVDqJlevrn3ATSGNZOwW+uwdvgmyNrhaR
6G+UncXMes3ebPUxs4faStgb4SkYAPbD/JVGYIuiN3M4wK4dxgcDO7jHmkiq2LPk
OkCvsk2bC16I7ip875hXNHONjT/KP/vrwTKnMxwmj/mi22fWb6hsj1mjLpScQuOG
DCRx2iH9LxEDKJaATFWQ8nQv/bw/C9rQzVCw+WKbCdhrzBaZdN+1TwTK68MJ1eMC
vGWMOu7gRalV5rcnO8WGhzqQ3/vV2Q==
=KR/p
-----END PGP SIGNATURE-----

--lx1NAW7LWTAVBckq--

