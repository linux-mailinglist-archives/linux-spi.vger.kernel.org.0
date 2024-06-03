Return-Path: <linux-spi+bounces-3202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC38D882C
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819E5B21D7F
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11D137939;
	Mon,  3 Jun 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8cIzh0S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEC137748;
	Mon,  3 Jun 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436675; cv=none; b=pXCKPEUh3gv2rO1esPzIosLkq05AXzQ/pX/d2MaQ4FK3RB97GUia6StqWs+ikeuGWk9nsekIOeI1kPp4ZUszhgdn72s+jNyUL1G8fq7d1XTaIfuwmaMlx0PM7Z6jmnDyGWSqkdgOMjt0fX9MZIV5ZzpDThA7vx3KvHviDnoVqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436675; c=relaxed/simple;
	bh=QNR/X5xxyFemetrPvkq2y26D71VYRaSZsqgSMk5nDVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsH/vSXzVSvreo74BiNwzfYei1sHihpq/piujsFL32/PXoXbsrg1yYz3Yovc1ui3P2kQEaL9bNnQz64HDK6phIBUg/lbFuFFSiNwzdTxw/G+tmC7hKOfYatXV9k5z+MHDvNhwc1Og17CqmuuwivCrcOgdOkAAt/RVTFcMlEOiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8cIzh0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC86FC2BD10;
	Mon,  3 Jun 2024 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436675;
	bh=QNR/X5xxyFemetrPvkq2y26D71VYRaSZsqgSMk5nDVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8cIzh0SOYSHNbegHakmmc6ynPO+0y2ebcsTmlqrhqZRMzketlKdOJlBu+msY5ePM
	 492RIQuVXO5hc6+4FWxuqDToYNYyoAzPeuN2a/IWvxuW2kMYG+CZmGzgMXskI/ZsZ1
	 6kijwycygCgU87utvIF8dykWEBy9vwZs5wG80QXGdIaBo6bbyjWaNg+jFRCIjNIS0G
	 /MHtZWUxsEQPuTuwsJ44MYGKe0RYhoLZVARa+MwOj61k0BKEZ5E3d36xqkXZKbeRqq
	 8SltHcT5vL62+Nhob9vToDfQkNNR5ozvmhLBMazXH1NntbW9+52ZGVfiG0EZ2QPMPD
	 CrWNMrevXtDXA==
Date: Mon, 3 Jun 2024 18:44:30 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <f5048ffd-60e2-4ca0-8fe4-8e6290438a13@sirena.org.uk>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
 <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
 <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
 <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
 <c258a169-cdbc-4a92-bae6-46bd38df86fb@sirena.org.uk>
 <e5c5edcb-e07b-4400-86ca-4d9a7fe4fc0c@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YKMRGBjoiRo4d/AJ"
Content-Disposition: inline
In-Reply-To: <e5c5edcb-e07b-4400-86ca-4d9a7fe4fc0c@notapiano>
X-Cookie: Don't let your status become too quo!


--YKMRGBjoiRo4d/AJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 01:37:02PM -0400, N=EDcolas F. R. A. Prado wrote:
> On Mon, Jun 03, 2024 at 01:26:36PM +0100, Mark Brown wrote:

> > That feels like a sensible cleanup but also a bit much for a fix with
> > all the driver updates...

> The current state of linux-next works fine, so there's nothing to fix. Th=
at
> series is really a cleanup series, since the fix merged wasn't the cleane=
st
> solution possible. (I'll be testing it shortly and posting the feedback t=
here)

Ah, good - I'd lost context and thought there were still some issues
needed fixing.

--YKMRGBjoiRo4d/AJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZeAP0ACgkQJNaLcl1U
h9CabAf+JFrYHxWM+qXxlbd3UOCR7vipYnX53XRX9Bnz2EpnAImPypjVZ/yXeroy
HwXSuKLPDm5kgg+8GmdyKKB8GnjRFN93393bmKVjjQ1GtStdTfOxAyRylTwjTNcE
cpQJcbUKjF2R2bE54nk/Dng/A1Cqat3tq+BuIEz/e2E8+w9/R1jQDGUnkXtx2QCA
wlIWe80TUZvAUZdeAGpmqvMjoX5suuCe9UeZw9w8t52pk/Go8h2tulwZXx4UiUVa
rNwJNnecKhDA7L/14cL2a23B5/MY0KjZPUW3W+kJgnu48qNg9cqw3wo2X5ZpSyAL
2vcVfG6WnAnmo6IlPb00l4v5Hs6KCQ==
=gX0M
-----END PGP SIGNATURE-----

--YKMRGBjoiRo4d/AJ--

