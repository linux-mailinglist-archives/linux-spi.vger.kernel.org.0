Return-Path: <linux-spi+bounces-4056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D148393F506
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 14:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB971F22227
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDF1474B6;
	Mon, 29 Jul 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPSv4F42"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9541474B4
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255550; cv=none; b=FQQmd07kfgB5Nzsrp+F54xG9/5pXiv9+KDJJzwQxWACRCJOVmXg3O22X+A8trEHHDQzShQkLzyaKfbnGtasTQYfJpQ3o7KuQyiDW5jqPFOyEm0iTiJYGqfx7NHH99ZkhJXgFX+/ycunG99/FBm3rGmHxls/5wH1gJ9ecRn9+8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255550; c=relaxed/simple;
	bh=tIzcJd6foO8ybptyd/SyJu705RkhfF4wS/3uvuz9Vig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URq7CJwGEdK1I1/Zsom0Lv+KFkWV/cPtCVoVp1tacGlbL00daX053J0xInk47YpPJC7Mzr5n4kkrT4Olyqqk/YQ8a5Q80EL+ivj/+xvCfDECCBuHvrRk/ADAsufteD5HBzcppxNnyYasP5nFYyticDzcOA96G9eK6QdqdrslfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPSv4F42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D9DC32786;
	Mon, 29 Jul 2024 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722255550;
	bh=tIzcJd6foO8ybptyd/SyJu705RkhfF4wS/3uvuz9Vig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPSv4F42jTw6sPJ1kRcRlBn/PWbQ/gcuJ4gPaM1AElCmTTQxcvMQ/VZsYeZFIvW49
	 fQnA0vqNYBEJ4bCEiJpdVdTkwAe4cnN8WgmhfTpwTy0Jz4Z26q5rWhE1IudhkIZ4mE
	 8TaFz+3yd6/nUMLqn3rknbn3Ray1X2L+1IwkHJJezDLm8IywSU8WikgaoaJlgJmA2D
	 27Vzbt1j258x8bbp8hIAzXA2s/E4wFhJ7dj+4XwI/KW9CKH5yN/76ogyK6pEpuz+A6
	 6/Qugdd9fYsPfXkmpr6hYhorwSbNngJxufJGZPqiJZjqIxyqhKLoxOFSaoVbJtU49k
	 We6rLQKs46a2A==
Date: Mon, 29 Jul 2024 13:19:03 +0100
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
Subject: Re: [PATCH v5 00/12] spi: add driver for Intel discrete graphics
Message-ID: <9e188405-1508-4019-ba65-6803c51e9c1c@sirena.org.uk>
References: <20240729084326.2278014-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v8Yavn7pPaf63/9P"
Content-Disposition: inline
In-Reply-To: <20240729084326.2278014-1-alexander.usyskin@intel.com>
X-Cookie: List was current at time of printing.


--v8Yavn7pPaf63/9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 11:43:14AM +0300, Alexander Usyskin wrote:

> V5: depend solely on AUXILIARY_BUS, not on COMPILE_TEST
>     disable spi driver on virtual function in Xe, no spi device there

> V4: fix white-spaces
>     add check for discrete graphics missed in i915 intel_spi_fini

> V3: rebase over drm-xe-next to enable CI run

> V2: fix review comments
>     fix signatures order
>     depend spi presence in Xe on special flag,
>      as not all new discrete cards have such spi

You're sending approximately one version of this large series a day.
Please stop resending until it's in a reviewable state.

--v8Yavn7pPaf63/9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaniLYACgkQJNaLcl1U
h9B8Fgf/R84LLkxVU7o6YWZXc87iNf2D4zwFaOP1TaZaTG/pZ83HiD3OP07jg8H+
K4gpsiPmfjgxll7albPKJ/6Wv9mhXARdK68ZgDdtrAE3FSf7HUkYa+dLzgwZqzjd
u9KCTePwAjhcvePOfgcF2SPp2TDVASPWnqG/qG6qhLxpIFx9Alv0UJjVy2tqOEyR
nRoRuO6+WhJYDxGlhipUvD2bAb045MTOMV6pRgdlHN6RpaGpswN5Yk3suwjda+qH
l+kEpEYo0uXz/xlK5a3O1TrAN3JJgocjV3/sm2HQ4t8PBL8YG2RaFE0gpSEIr4SF
41kyRyWffD8Dv5jONOaupsVqZUmGrQ==
=VvS7
-----END PGP SIGNATURE-----

--v8Yavn7pPaf63/9P--

