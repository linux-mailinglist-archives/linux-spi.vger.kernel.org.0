Return-Path: <linux-spi+bounces-4856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D997BD1F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5EB251F9
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAA18A92B;
	Wed, 18 Sep 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ktmbCm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEE18A926
	for <linux-spi@vger.kernel.org>; Wed, 18 Sep 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666536; cv=none; b=EKiGlHeyOTqjkkl2z+BCIZV9YJn84qO3hPW0HpSHyhNB/Hbj1GyPz2uMgjfD3+WQ0YE1MnlHb04w/9ER38JsxgHaNuCK/VsIYvHdAxla47GRyRiDJQ7mBPyQlMj1k40kICGMpArdE7/SNFd83i7ODQsxE3Ngc15HBxaco8fiSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666536; c=relaxed/simple;
	bh=k0YjMuTyRy6bW50pv7BP9O8+81yBsHxqndrsew5qUZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc8jF/k+vyXrNvZDW1k8Gv4aaBxcRE6e5BsCQYD9Yly4HmnBfOa2fzZkzeO6rIe0JtT3LP1HTYiuCwmIZMEh1/my/SrEjDunR9QyNpqSt2ZoL1dVPlK+y6EkVQhLkgjIBpy3bkhOm3X7vy3U0ZgZTqgnD2UgmS27r26ozbQYhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ktmbCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022FC4CEC3;
	Wed, 18 Sep 2024 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726666536;
	bh=k0YjMuTyRy6bW50pv7BP9O8+81yBsHxqndrsew5qUZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/ktmbCmZzdggB7E6Vq1nfM+HnGQhLNDv8Ev4R6If75ikZzzy5m3aSZ8By9c1FkWb
	 kz+ztXFqXOeh/nAZLUz7QhEkmewR4Ec4rtlcbTrDMM/gujbjWDayjECwN383ZWyUp3
	 yKnpzLCEmk7b/u3PS5l+/tgxICiPmge4+MAOmfaKgTMIGxeukjogXKlo0+d3ALP1ke
	 Uopha1T4fV2LFikMBorpQG5zvSS8dqaev690IL5CuQxMDydxeLN/ryXe/1FbKvJw1s
	 u8zrRw/xD/bh608Qj/n/46ImSsWv2GSGM++etwOGiWxU9SmddqJdC8DvQIeoySKjCn
	 xKOn9dYCSfQ4A==
Date: Wed, 18 Sep 2024 15:35:31 +0200
From: Mark Brown <broonie@kernel.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v6 02/12] spi: intel-dg: implement region enumeration
Message-ID: <ZurXI2g00duqMUjo@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-3-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4E2vtPXFpUvSi0jO"
Content-Disposition: inline
In-Reply-To: <20240916134928.3654054-3-alexander.usyskin@intel.com>
X-Cookie: Editing is a rewording activity.


--4E2vtPXFpUvSi0jO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2024 at 04:49:18PM +0300, Alexander Usyskin wrote:

> In intel-dg spi, there is no access to the spi controller,
> the information is extracted from the descriptor region.

Which information?  I can't tell what this patch is supposed to do; as
with the first patch this shouldn't be standalone.

> +static inline u32 spi_error(struct intel_dg_spi *spi)
> +{

> +static inline u32 spi_read32(struct intel_dg_spi *spi, u32 address)
> +{

At least these names are too generic, please use driver specific
prefixes.

--4E2vtPXFpUvSi0jO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbq1yMACgkQJNaLcl1U
h9CPYgf/ZjVGyEO9Y7iKYItfa+LbEduFBmRksC7xQpoW/Uh4qJfkXH37ns53BxNZ
FthkWsw64WaUfLhv5HtPzk9tMtNuojS/m1tao0FxZlXzgUhFylgCbhLEzutdKvtv
CQ7ghKdjhhUaELp5Cw1e1OsOwjKirsgMGBgvjUBlFCEWpgWQfxkYKDiS1sD/lkSv
xN2f/tV6BHbW9/mc+9hrfL3y/RV1OvMpv5NLRFgOnBpNndEGyRr0r3jdiMY0ZkWX
krmmNCFPoCbbm1qAJBUopFmb2+jnXtal//XbtGMUNf63wc2IYr6RVSWC39LaylHZ
eVX878zAvbZAo1XvV1MMaVo60yc9xQ==
=P3sn
-----END PGP SIGNATURE-----

--4E2vtPXFpUvSi0jO--

