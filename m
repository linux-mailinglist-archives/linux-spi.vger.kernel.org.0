Return-Path: <linux-spi+bounces-4231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA8956DDE
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 16:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2F51C23E8D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD11741C3;
	Mon, 19 Aug 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="kE/tizXz"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942A16CD22
	for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079097; cv=none; b=U3o3cjJnUNNr5ns7tAHpTWEWogtKhZMBYPgosAj0JLPuLwVudQtBfb74R3aUcOR8DEUfxDErQaqmP/qKGr3DqxAigONrr7uD4xC3YslXCByGEthWR5SYvYpcwR2PWCx9Bus7YcaL5rVOVJN+3MUAD9YAbJwvdqDq/1WUdL73BZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079097; c=relaxed/simple;
	bh=anC9TSfJ9atzD1KEU7o2hISDrSWZyCtUZv3frTZMXYA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lc6bFbIQoNRrDKZDw18W45Xkkpc4sOixdqCml4KQftYsPzfBWMkNVWgGJFdczD/VhUs2eetZ4F5foYNz3B+6KJbl9jA4sT7E0kasDhwLcD/L+wTwaFdGWZHqT90wC9moXcCOekxASA7cG54LuQ3KU7gQZq8P344Xx+3hVk3m1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=kE/tizXz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1724079092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anC9TSfJ9atzD1KEU7o2hISDrSWZyCtUZv3frTZMXYA=;
	b=kE/tizXzU0003+6EVOibXXnk/fULdkZnyJkdCAsb0BEllVv27hciztIMtxAm8rCn+68e31
	nAfAJo7rRN5E2o/HS0s4WUWhV6FN5mRxRrXOPC/lIbkTqIgMaHjsB2s0ch+z0r/eOEbe1d
	jRuP2L2tVqHAMphAvt1uMVOv6RRnBpoTiVk8TyZrdI9efwa9GWUEt7sPcyWQmZ/fCri1Iy
	4fRTDTiPUHxUbDlI4KRX38Ca2RuMqvEuQYP3nH0P78Ea/01OEG2irjw11Ybq27XgMpZ8MT
	Tr3o/48WZeV14Bz+4QpokbDhBT7NMa9u6SBj1UP1IivRbmBF2RfETbCjzTRqdw==
Content-Type: multipart/signed;
 boundary=96437a84d4599b1620474bb25d7caa8cc60be0169b1ebc5c8503e60b90be;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Aug 2024 16:51:21 +0200
Message-Id: <D3JZ0ZQ0BF6A.1J4UHWMDS3JWJ@cknow.org>
Cc: "Huang-Huang Bao" <i@eh5.me>, "Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Sasha Levin" <sashal@kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Vicente Bergas" <vicencb@gmail.com>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com> <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com> <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com> <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com> <D3JXD607339U.2F1IAKUSM59UP@cknow.org> <CAAMcf8BAiva1GB_1AoVH-Nq8sp81KdtVe=rUMVjV2ZxCiM4NAg@mail.gmail.com>
In-Reply-To: <CAAMcf8BAiva1GB_1AoVH-Nq8sp81KdtVe=rUMVjV2ZxCiM4NAg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--96437a84d4599b1620474bb25d7caa8cc60be0169b1ebc5c8503e60b90be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 19, 2024 at 4:37 PM CEST, Vicente Bergas wrote:
> On Mon, Aug 19, 2024 at 3:33 PM Diederik de Haas <didi.debian@cknow.org> wrote:
> > On Mon Aug 19, 2024 at 3:14 PM CEST, Vicente Bergas wrote:
> > > On Mon, Aug 19, 2024 at 2:49 PM Vicente Bergas <vicencb@gmail.com> wrote:
> > > > Added:
> > > > Huang-Huang Bao <i@eh5.me>
> > > > Linus Walleij <linus.walleij@linaro.org>
> > > > Sasha Levin <sashal@kernel.org>
> > > >
> > > > The first offending commit is:
> > > > 29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmux
> > > > bits for RK3328 GPIO2-B pins
> > > >
> > > > I've also tested 6.10.6 with it reverted (and
> > > > 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> > > > 7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
> > > > works fine.
> > >
> > > Sorry for the noise:
> > > reverting only 29d8101fb9442544077e68e27839a1979f85633d makes it work on 6.10.6.
> > > Ignore what i said about 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> > > 7127c68c76f120367b9a5053f524df0b603d4a48.
> >
> > Please try if unreverting that commit and adding the following:
> > https://lore.kernel.org/linux-rockchip/20240709105428.1176375-1-i@eh5.me/
> >
> > fixes the issue as well.
>
> I confirm that 6.10.6 without any reverts plus
> 20240709105428.1176375-1-i@eh5.me also fixes the issue.

It would be great if that patch got accepted to fix the breakage,
including on a number of stable kernel versions.

--96437a84d4599b1620474bb25d7caa8cc60be0169b1ebc5c8503e60b90be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZsNb7QAKCRDXblvOeH7b
bpLRAP43HO7c7+6ex8WcGcQs/3phh9JuAbc0tAVVI5tGO48g0QEAmeA/twUmoTUL
4Ieigmn/2Uv+eIsvOtIabv01dKjoyAA=
=P5nK
-----END PGP SIGNATURE-----

--96437a84d4599b1620474bb25d7caa8cc60be0169b1ebc5c8503e60b90be--

