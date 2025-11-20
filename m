Return-Path: <linux-spi+bounces-11364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89907C717D5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 01:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2A5E628EAF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766492AE68;
	Thu, 20 Nov 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIbP0GBu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F23186A;
	Thu, 20 Nov 2025 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596983; cv=none; b=RY7J8tCBs5tPvcz9N3MxK9u+diszjHo3EbYA9KHMmqNGRFdau1yDt2yWL+AqQb+oD+lwY5iEwl+RjG1FcmjWvX6ol1UTecuJFRB7kdblipQ+r4YApugE0S64NC3xLmsJ4DoIHQrtY6F4llxLdgRNwKH56au16VFUww2xpDmA2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596983; c=relaxed/simple;
	bh=cVyPOnT/UBn71uhx+refF3VSlWZ4EZjVCMqRawXSxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgLuSD5Q0owfSK5tDtRNwEzskgttdfCq8QXz+VkUhTMhd/mDY6aHKPpzSdqNOCjf5jxlVxriPzYNgLgUkYzL8xE0PvoxLC8PWzmsuxTr48ATQHiOsuXnBYlv7Fz1+KZWL5oNjekWUdOPq+yiyVhH0vLSETzgy+ohiIQXlel1P2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIbP0GBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD4C4CEF5;
	Thu, 20 Nov 2025 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763596981;
	bh=cVyPOnT/UBn71uhx+refF3VSlWZ4EZjVCMqRawXSxAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIbP0GBuOYzLLwjKfTQNUFmNriOakF0h4AhRoWeQv5l4W5ZGWjVpM7SDMAHhwwsfq
	 4+WNYNhf6tU3/qCISfEDI+fSPba7oAD5LoUYFq14bKtNXxHecDt5T2AF9OvKBypTyA
	 pFulrewuumd8hz74L53uXjuKnbE8NMmH8stFyShBLz/9TSnD0kf3F5RCGtPCE8JBkX
	 lLcDqFH11piEulLk9zz9O2CHPpflAJTpov3ZTGd/kYLoIusFTnyEQXgttuXg96JyZd
	 cSzPL55WxGvtYNNZjviujxHPlyRnc/WNrrJlFojiNLRM6UPXXB/1o6SzL4tFF4X9iN
	 8mixZr6N/wmZw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6C2CB1ACCCAB; Thu, 20 Nov 2025 00:02:56 +0000 (GMT)
Date: Thu, 20 Nov 2025 00:02:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bough Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aR5asBZpmtM_JiNt@sirena.co.uk>
References: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
 <20251118-xspi-v3-2-6d3a91b68c7e@nxp.com>
 <aRyfoXaTdL1gvPOY@lizhi-Precision-Tower-5810>
 <DU0PR04MB94965531DB74151BFE651BD690D7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <aR3qK18c4/XJY8JW@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AoC14FpgipN46l3S"
Content-Disposition: inline
In-Reply-To: <aR3qK18c4/XJY8JW@lizhi-Precision-Tower-5810>
X-Cookie: It's clever, but is it art?


--AoC14FpgipN46l3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:02:51AM -0500, Frank Li wrote:
> On Wed, Nov 19, 2025 at 07:02:21AM +0000, Bough Chen wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: 2025=E5=B9=B411=E6=9C=8819=E6=97=A5 0:33
> > > To: Bough Chen <haibo.chen@nxp.com>

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--AoC14FpgipN46l3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkeWq8ACgkQJNaLcl1U
h9BQFgf+LoQSLm97OTEsjh3Y/QsqlCXXQ/uQKZ2jgf57X7sAtmHP+Az+6nK5yjjC
TlOdyDX3MDVs3hU7qC4tG74VhsBrIwXWQPMLpt4z/xuu7LvMi3X8UcS2LqFehTam
p385IAOJOCVqP1g9ZWBjPlIRGqQUz2Yh1iAD1/cIpEpbv9sFKWUHv+pRS2L5q6Km
esnCXXfmjwcthF0cCP2Ysi4BSndTB0xE1KubkK1ZlotxJv5BBMZC0gTuFSGWGzK/
+aqGv++vD0iE68KFsrfX3KQ92XvCNPTR5jFhDB3XiTWj7an96+5Iuo2cEYEfs6vd
rLyNDRRdYZbyoNeSVvfq0e/GSJ3pOQ==
=frvl
-----END PGP SIGNATURE-----

--AoC14FpgipN46l3S--

