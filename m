Return-Path: <linux-spi+bounces-5156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538179955D2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A0B255DC
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083C20ADC3;
	Tue,  8 Oct 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujxl7g5R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891A20A5F9;
	Tue,  8 Oct 2024 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409080; cv=none; b=IcnkUq8dmwtQr010Etd8nx+02n1JnKAvfmNBhvDnDmRQPlSF5W20W8ydBY6x+9YTPnzRMpXNHYXbuHR5yTNvlKWvlcNFMhtlmg3jfXGiwTS4X1kzn7YemPNod0B1abG+ze57gKUQCC3Qo4ObyPvCaIhukLg/ssu3i5i8G5uHGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409080; c=relaxed/simple;
	bh=BJ31tWGgWIkFEfM3an1hvQTx5iLrS2z6Qu7X016gHEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzxfIWTdS21NH/lEvW2qBHFPsLqNU/CEetAMqUYWMw02gmbRJ4Y37WA5k3OAhqP2ZTW582SANDTQi0AyoWNytQUOGeg8I6wwWrcBHtgZUjoZhvsLBEgn4p1dCVRD94u1j0WTMrnSpoqy0IvQ8xmtwkaohmk1XGU+x24fWkkN7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujxl7g5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EAFC4CEC7;
	Tue,  8 Oct 2024 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728409079;
	bh=BJ31tWGgWIkFEfM3an1hvQTx5iLrS2z6Qu7X016gHEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujxl7g5RxzFi1e2P90HheHYUpVml++HJCrWWdl1Ykg007mfzEyWXm2DWxoneS/zYX
	 k2lXD5pHr57L5PNuaa/auxgvh12V6+aH3OxShbDvJVaLCTkZeR8Brl4HvkjHe6QMQ+
	 AaihhXVPDpO+JeYbNgMWMleFmJYbBHSn9OWWx9KexPO/5SP6+uVbE4Zt+z/FYKdBrE
	 HA9wkpKPjjhPFmpUaZBgoDu98WkGYpXQpCSXmG/Q8mn5EAlgzW9hVYJ3mRsLQGLaO1
	 eg/Uo8QmXOyMvY5ZrPPspHUGR6+sNo1V12DZ8tXp67pPX6PRdC5HdCOOjxGa2Z7KLR
	 14iRFE6xrEKYQ==
Date: Tue, 8 Oct 2024 18:37:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	oss@helene.moe, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <ZwVt9e44jc3CQaV1@finisterre.sirena.org.uk>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
 <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
 <ZwVlE9bgHYNT8J7J@finisterre.sirena.org.uk>
 <c4a72fcf91b30a8eae2fff851f01d10a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o/mJtvBmFcf33s5p"
Content-Disposition: inline
In-Reply-To: <c4a72fcf91b30a8eae2fff851f01d10a@manjaro.org>
X-Cookie: Editing is a rewording activity.


--o/mJtvBmFcf33s5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 07:32:18PM +0200, Dragan Simic wrote:

> No worries.  I just sent the incremental patch, [1] please have a look.
> Thanks for merging this patch series!

Oh, sorry - actually now I look again I got this confused with another
patch and it's still in my CI so I can actually fix things up before
merging.

--o/mJtvBmFcf33s5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFbfQACgkQJNaLcl1U
h9AaKgf/XO0FMAXJJkUkas1jH+dzY2hoEPBpdCgmQ8Cpn4Jt70keLNNW1u4sTE+9
Cb09tobajLzVX8aRVVYKveazE8pxu4srSw0GOPPK5aF+SbB8nKn6r2y+d3LLbUgM
2C3wMFoWqJ8OTFIiwfQY/a4XNW07dZwuIRflTSTA0QbulDUGr448uTuipPAbqpWK
4Lk19r94uo4ptWH5IdxA4pTa3dss/0orAdCTTSf02O27yOA+sHon3ZarV34VqgrW
IMgR8mEflE1z4yxdrY0KsperCDvn7LvucnUF1dWdhb1CzGIOFIva590OFt36Eg5u
Ijv1S0PaneNlutJXaoNakiKDKXnF6w==
=nzfO
-----END PGP SIGNATURE-----

--o/mJtvBmFcf33s5p--

