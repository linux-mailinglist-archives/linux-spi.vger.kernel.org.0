Return-Path: <linux-spi+bounces-5250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DED9A2616
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824E12842D0
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DF1DDC3E;
	Thu, 17 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFRttVsk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD51DB956;
	Thu, 17 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177674; cv=none; b=IPChfB38fuCgv5KoaoH5hC4ohwO5mEvtPNOsi+h/bElPEpxJT74UMv51KlyVfemPR1kOT3fWiOlplyrXWCVaZpud9+Ai8oGrUiNun5RkBqJxTNrpQz3zNFaRAnjhh8W9zWo0WqqvyIGY3aLSZC07Mq7zUGXoVERQUnwjB0xo1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177674; c=relaxed/simple;
	bh=QSHRYCgTGOlCiy4/3pMT/U8yrfGOKzLeEBt2l4JooDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9t7PS3dDoEzlUxOQzhPIkFaR1D0RWClLCSgP2pMBLZWoh6reQx06TmLlGDizug7tBVRXhPf2/AYU0emULGkFuGLRW99kqklmBcfNkgwqR0H2hv8EtelxF/RnK8U5zxUxbgwic1LzuyZ0mIxZTTSqq9ae9JuVeEz5+LJAc9BU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFRttVsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64523C4CEC3;
	Thu, 17 Oct 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177674;
	bh=QSHRYCgTGOlCiy4/3pMT/U8yrfGOKzLeEBt2l4JooDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFRttVskpXJdZmzXS4i18eQ+LNNQMCt69nRPxzVeYLkG11w2iN+qG7z8JAHKvrUYP
	 sIcMBAicKVakCf4jFp2gj7pFoknqUHYwD/L92o2ZZUKHCAXFC66bTrCPIox0zdmdbV
	 we3bY9UrD8C8nB2uKK1LG/LTp0Z0KV8tGbltXuT3o4/ik3JrGSjvLnZDJlAutVrMnY
	 dEbKDCb9IRNOk7E40SbX+dgs+qrTlTgncjp5Kuym2CREvoeNtg2quki9kccxbH22OL
	 l16kRl9rp6Mp8PZzSuE5FZpHoBsQOQnAP1LPmue2/b63VtYSw6D7jQ/mMYsroBDvFY
	 h68GuIeGFXrgQ==
Date: Thu, 17 Oct 2024 16:07:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH v4] spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to
 dtschema
Message-ID: <e9a3b158-5c38-44cf-829e-3c9e1d607842@sirena.org.uk>
References: <ZxEm-H-PjlQyXeOH@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sGS+dIfSb9JFEzO"
Content-Disposition: inline
In-Reply-To: <ZxEm-H-PjlQyXeOH@Emma>
X-Cookie: One picture is worth 128K words.


--6sGS+dIfSb9JFEzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 03:02:16PM +0000, Karan Sanghavi wrote:
> Convert bcm2835-aux-spi binding to Dt schema
>=20
> Changes since v3:
>  - Updated the patch subject line
>  - Reformatted the description to fit within 80 characters

As covered in submitting-patches.rst inter-version changelogs go after
the ---.  There is no need to resubmit for this alone.

--6sGS+dIfSb9JFEzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcRKEMACgkQJNaLcl1U
h9Dcsgf+JBEgmTMplzymu/DfsofE8ALvY5+J5gISHD6rGIZEJMq37kBdTpixn11i
jlthfsWz30df9pU+G6fg9tIvtRckm374sqI7zCL8ITz6k3BFyGJGGfhnGizttsBQ
s0OfsMWlwwFYEU03VmFCCk9nLr9U764j9VtQ8pVT1jhBD4gbvgK8LQZRtNnshqj5
zcbQDs4X/u4lncbHh6whAIlEtsyhdVAPxoXBQ1gHN/mnqJDNjIO6WOCoxImte143
SfmBPHCJIpACxsTHq3ZazUuvMbhgsSkhuLpyqqdf2XRKhIyQqI2F7LCdhwy6c/DV
GfZV5Ncu2rq9fQ4hvmpLgWqjK5mmlQ==
=Aiz5
-----END PGP SIGNATURE-----

--6sGS+dIfSb9JFEzO--

