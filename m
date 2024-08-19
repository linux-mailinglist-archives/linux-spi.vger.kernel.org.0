Return-Path: <linux-spi+bounces-4229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27357956C32
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A2BB27DD7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1416B74D;
	Mon, 19 Aug 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ljkVb+lT"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FA15D5DE;
	Mon, 19 Aug 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074407; cv=none; b=XYuNpPGqj2eY9ffLcvEi033RCvohzpR4YL1pUNE+QBicex2vnGbr08+UrPNiS3QfZMxU2Sn0gcPIk6MkwhhAAst4aOAMelG8NDCqyYWbF9ujqS7TtNlHxTYjvhTUsB9xNDknU8RQTsIEXE3+50KQjTeLUhoQLKtAmb7xYGT1PHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074407; c=relaxed/simple;
	bh=mUcz58dl6COkNRjXiS+XwoZIpjirix2gMX2fsFCVwqc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QbFEvaAeGfv38VEUvlyXiC5oLL1W1T+a3U+yOOD/ZIin4rxB9IexQG7FXHbsYkjlve3S38kk+isZc2Fk2NUkZx+7F1JwRlGsqZcFnJubXBHXTNnzmx9MjD70nicfdF4qAyozLHGev5Me0Jmtm7nWbt6T0ZOy57owNWpaJNmM9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ljkVb+lT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1724074402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUcz58dl6COkNRjXiS+XwoZIpjirix2gMX2fsFCVwqc=;
	b=ljkVb+lTjdnqwLJrKao3uSZiJ5UsRjbEoSgjD8lP0CE2ae3ASMI3BPgcebBDyt7VyscRJS
	ycmtkDoUGtdj8BblhOwd3lny3sKz1P/wK9MZ8c9S7nDEuBGCG63Zh8F30JMULw4QNSEIx/
	6bU2giLnAuNEy5Z1orKiH1iquaECTqX5kLv3KB2BjfT92JBHXofm3w4U57/oeq95UAslL3
	I5NkSlxcg9/xouNExxDHcqzerrtAVEzjhnC9h0jfgHQi3c2DWB9GRu8agOgphE3y7lhtly
	oBeE3ybeLJqZwhFlowQHbKVKOkeAP7BeNrgPuSsxOjfnrkpJtOmHNjR5s/SirA==
Content-Type: multipart/signed;
 boundary=7d622726182a96d2bf0672ce2e9576632d95c43943cc86cf0e8f4ee1b5f3;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Aug 2024 15:33:12 +0200
Message-Id: <D3JXD607339U.2F1IAKUSM59UP@cknow.org>
Cc: "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>, "Mark Brown"
 <broonie@kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Vicente Bergas" <vicencb@gmail.com>, "Huang-Huang Bao" <i@eh5.me>,
 "Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 <linux-spi@vger.kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Sasha Levin" <sashal@kernel.org>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com> <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com> <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com> <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com>
In-Reply-To: <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--7d622726182a96d2bf0672ce2e9576632d95c43943cc86cf0e8f4ee1b5f3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 19, 2024 at 3:14 PM CEST, Vicente Bergas wrote:
> On Mon, Aug 19, 2024 at 2:49 PM Vicente Bergas <vicencb@gmail.com> wrote:
> > On Mon, Aug 19, 2024 at 4:12 AM Vicente Bergas <vicencb@gmail.com> wrote:
> > > > i am a user of the CONFIG_SPI_SPIDEV device.
> > > > It stopped working between 6.8 and 6.10.5.
> > > > The SPI bus itself reports no errors to userspace, but no devices
> > > > appear connected to the bus.
> > > > The platform used is RK3328.
> > > > The only spi-related message in dmesg is:
> > > > rockchip-spi ff190000.spi: Runtime PM usage count underflow!

FWIW: I've seen this issue as well.

> > Added:
> > Huang-Huang Bao <i@eh5.me>
> > Linus Walleij <linus.walleij@linaro.org>
> > Sasha Levin <sashal@kernel.org>
> >
> > The first offending commit is:
> > 29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmux
> > bits for RK3328 GPIO2-B pins
> >
> > I've also tested 6.10.6 with it reverted (and
> > 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> > 7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
> > works fine.
>
> Sorry for the noise:
> reverting only 29d8101fb9442544077e68e27839a1979f85633d makes it work on 6.10.6.
> Ignore what i said about 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> 7127c68c76f120367b9a5053f524df0b603d4a48.

Please try if unreverting that commit and adding the following:
https://lore.kernel.org/linux-rockchip/20240709105428.1176375-1-i@eh5.me/

fixes the issue as well.

--7d622726182a96d2bf0672ce2e9576632d95c43943cc86cf0e8f4ee1b5f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZsNJmwAKCRDXblvOeH7b
bhyQAP92MFS0tEffPQaPvXYIqpxKxcuOQKgtci09ZuJAZ8cHcAD8CHTgUDgpnM8L
KrOfRzWCigYY3k5CT8KNO6/JOHeTUQ0=
=ku1k
-----END PGP SIGNATURE-----

--7d622726182a96d2bf0672ce2e9576632d95c43943cc86cf0e8f4ee1b5f3--

