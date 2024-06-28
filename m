Return-Path: <linux-spi+bounces-3665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA591C012
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD032841A0
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816C1BE85E;
	Fri, 28 Jun 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk23BsBl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAB1BE847;
	Fri, 28 Jun 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583029; cv=none; b=XTW8jusK7RblR2ena8QNk7je62xI/HsU+EvUHho6zPwgcmhOiBQDEYmMHqS7WcGSwba2x/uAFpjKF9N1suF8PbKwY3KqcyOb9Ej6ijg+YvQ7TkAulqyNw+gpAPSkWDJ3f3WoR0FfPVzTa2n6/TPxqqpcmrFkCXeVi2DL6um3MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583029; c=relaxed/simple;
	bh=jgTgj8hpzllNCQWInO86hvCBqczz1c5oqJXlnU6t5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYFqZFBSLHszwkQa2hb+h5u/iByq7+R3ljNxaGhHINnC3Vf002zbCCZbXL0ZQAzMJ5kK6gJ4D+MbrZ3/IvgbnlKYB/Vh74iBX1fLG7mcRiQx2AM8o4GB71wY+a7E1E3McrsGDH++VTp0LMPymOLaNSaqm9100amCVqyaH9zIgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk23BsBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A400EC116B1;
	Fri, 28 Jun 2024 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719583029;
	bh=jgTgj8hpzllNCQWInO86hvCBqczz1c5oqJXlnU6t5NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bk23BsBlC3tj4xmIbhWi9LHZejcfJV91nZqYtBu972B4Oj8s5HDk5cFKoQBizvWuz
	 HXkJTRacLvmtE5znK5ba1pTudcmyw6zBQEanjD+9zbPcWQzAhifdi9CATgG1K84UwQ
	 hYmrekCcJFH+LfuUKxNUF9fbcwafLBsqqtARWxi+mwgUXEVbFmNs10N2r4R4WEVuAQ
	 fU+oJK8lcUsy5/30KCeg27CCu1xNLrlWeaT5kwVD6a2mBb20psOeyX6ACgZ9zGgMmJ
	 rEIg7Qf6ayMUiARcqovaHj6FgfWsW4gGnKB9vWPTAoqgs6v+wn10OrIQO6o+pmpfrM
	 mLWRggEkFG46g==
Date: Fri, 28 Jun 2024 14:57:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v9 6/9] spi: cadence: Add Marvell xfer
 operation support
Message-ID: <79122cc3-f0bb-4ed4-8441-55db0003acd4@sirena.org.uk>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-7-wsadowski@marvell.com>
 <408b4046-12bc-40d0-aaf4-adced4033946@sirena.org.uk>
 <CO6PR18MB409861918DAF0D8D9FE684EEB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RdpequBgoMAFoAv0"
Content-Disposition: inline
In-Reply-To: <CO6PR18MB409861918DAF0D8D9FE684EEB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
X-Cookie: divorce, n:


--RdpequBgoMAFoAv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 01:48:00PM +0000, Witold Sadowski wrote:

> > This loop doesn't implement any of the delay stuff, ideally it either
> > would or would reject transfers that request transfers.

> I'm not sure about what kind of the delay You are referring to. Can You explain?

The _delay fields in spi_transfer.

--RdpequBgoMAFoAv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+wS4ACgkQJNaLcl1U
h9BUlQf8DjSSXtPHq/fUXzfb7QZEOo7hObbT2LtRrpsC/AZ5TJ2/uH8Hcsa3Xs7j
gg4YfWNm0LbC0QVH99pzx/xUFZh2+FwJ2gWApfUAIbYBZsdcxiuetso3ucfSYMag
AyXFnzVdHqsu2qlKhnC+3GTn3GOhGnz1ZppV+yzMXMszK3UdortpSdHw2UOd9z65
lGgi3xwd7LLAhcjFdUB6nNZUZcPZ8UyY5J2N+GfcKaCR+qJcuIaBHvOvLfagKoPq
E1pB4q8H7yNiHhxiA3ZavG0lBJ+TQ045oQjveexgGzMbJ3AzP2JfSmeAAiISUoap
AtIRq/Xb8QRhV7st9Qqo6vOC7XXnZw==
=R/vK
-----END PGP SIGNATURE-----

--RdpequBgoMAFoAv0--

