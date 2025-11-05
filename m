Return-Path: <linux-spi+bounces-11036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D118AC35CEE
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1F5A4E9336
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98B3168EF;
	Wed,  5 Nov 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHM5sXvF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72E2F56;
	Wed,  5 Nov 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348977; cv=none; b=KidZOA+M8wiKvS5d5Lb9XMSXymsBQa/TpH0kKY8Tftr0lRwlpOEnN+Pui34fWiMnld6G1203tkSBrMF8OnKsWVUcYwHFEpx/Z3ytOi3M4vzNpvus9iJfJJ2yY3ApKPK8CmcUFEtwlDD5c5Yb53dcUHQ4tnJM6Fl+44XIkt3kAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348977; c=relaxed/simple;
	bh=B95eVH4gIcSqc/WQ/YtpqJQxu1TLbgEzFDA9oDcpFHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN8nagSlIJKOfrPyL5OUfTB1iKIBAkBEPSiMO13pXx0CWbJ4AiMJQa9Hrc+W4J3RM31KinytVNb+tWqPuBsXdoaKfrwS2hrq7yOeyjnDwMxYuIZg/tFrWTQ/FSep2Mdlg8Fv0LjiwVZgDnZ+NlEnZn76oig9OyQzxNu7eSS4GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHM5sXvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8B2C4CEF8;
	Wed,  5 Nov 2025 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348976;
	bh=B95eVH4gIcSqc/WQ/YtpqJQxu1TLbgEzFDA9oDcpFHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHM5sXvFq3Mrtro4l2Ena35Nqj5NrO95Y9KqOhQvHQMg40NvBil4Ahe1sG4vNEbJp
	 QlFHUpOMm7tPm77MqQKlSX3qCD09BqqwxntL0tS/xZ2fwv9dgonUI5mdv2qUGvej50
	 v+wKjKVAa3tj0PTF0lEEc8edino/1ixZce8FFv6WUAAAQRG+iMOnDEMDcLkOvWVzce
	 o62QMfkONd4O2F9he7d0E26hjJGnu2Tefsw8gWGp+5NZi5/7RKKs+kHQSVfZ88Iy1t
	 YHnjz0xmz9fGhr8L2Odpgt5mCbCL8rUi7RdRwui7UPxNfwwuk7c6sOh/Vu2cWChsQc
	 Fa+YR4JEEUc9Q==
Date: Wed, 5 Nov 2025 13:22:53 +0000
From: Mark Brown <broonie@kernel.org>
To: carlos.song@nxp.com
Cc: frank.li@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: keep dma request disabled before dma transfer
 setup
Message-ID: <aQtPrS6_spVEzKSu@finisterre.sirena.org.uk>
References: <20251024055320.408482-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zw4qTt7we2Pp5ch+"
Content-Disposition: inline
In-Reply-To: <20251024055320.408482-1-carlos.song@nxp.com>
X-Cookie: If in doubt, mumble.


--zw4qTt7we2Pp5ch+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2025 at 01:53:20PM +0800, carlos.song@nxp.com wrote:

> From: Robin Gong <yibin.gong@nxp.com>

...

> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

If you're sending a patch your signoff should go last in the chain, here
it looks like you're forwarding something Robin wrote so his signoff
should be first then you add yours after that.

--zw4qTt7we2Pp5ch+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLT6wACgkQJNaLcl1U
h9ARBwf/ZKAAS4rKRLsk0T/vrm4mhVcNoHt8+qTOhmw6TJ1mFFM1eVJE7j4ugOg0
+pmTj5wFiv3+g9MEegx35jOweJ0X2mYKsjzShLksgVQERU/va5xd2pG7rdzd8UyJ
KzQnAwnEdPCRuAX/pLoe7HTjcizpaYqg9yNJO9e/pFmBOKS9JqfRWjKurWUIj6XB
pMIVkFxWE0aPKANXEZm1u5aeOtgHp8/GEWYC66vpQagTWaXzXaaUm1kPuP6G3Uwa
culMCwQviacBrXO4gBSGRAHV4V1XaeIfJ7qc0i8ht2BeO3afCme+DeodlrKwrx+h
0XZ0VjHDO0keZWqudi99I1h4TtAI4w==
=Y+p6
-----END PGP SIGNATURE-----

--zw4qTt7we2Pp5ch+--

