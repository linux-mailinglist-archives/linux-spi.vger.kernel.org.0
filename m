Return-Path: <linux-spi+bounces-4237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2013957577
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2EEB24FD3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F61DD390;
	Mon, 19 Aug 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YBCsQiDQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A41891D9;
	Mon, 19 Aug 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098464; cv=none; b=r87++zy6g31yW3QSeg0IyYx7v4STSCZZFqDyFWxPjKsLqGx5jL138xQeXcmWcvp1NpjNpOYljZ17opK2LVe6NllS3D/YmQgqr9YjB8KYQ7wi67P+FmvsgXKx2iaPixd7Uvg8WgRPLGhq2VnE/1mVEWLOWlSr2msGXbLD7XM/voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098464; c=relaxed/simple;
	bh=rwkk8LQNVQlD9RwFHTm1jcVQ1zV2YJJ4gWgj2o8KRL0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ja+kIldelAk42PkN/WjlZmYjOiqF51aVDWJtufJJu1RZIyWh8Mo61etsCUJOY7HqPJuNE8IGPhgv8VXRDvarvh/nDvIRfutthCgnczUr85ezDtKzMD3SpsVEZk1vYfsHMfcP38zaHjJc8T19gFn7jpR2k3zKjmAGwdUgjkCPYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YBCsQiDQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724098452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW7nBfaUoWGYI3LaABUbY8ys4mwOX5zqzPW9Oi+BnTM=;
	b=YBCsQiDQMvk8FzjJcNLq/AItWxnGaj673csQreNjjDaZqjm3SpID+TQ/2C/Y8+6H14lUjO
	pdpgmvvxSp8f9ohXDF4GfiQmrJD0kR7xlRf1Jow+J2ubvjlQ35jjWpAb8bJ5DsAr1mXZ0k
	C47uWBPhPuK7ZNHVlnfNUwuXJk9ddm9wZD2qn/gw39KswaI3hMmego1JvNK2omhoZ/n/CW
	Q/bQYvYpTydUQpdirL7JbbxrGciJB4xlLBzPZRprPgnHV1rs+1UmRTp72BBEnOeBF2za3T
	9oOTqOJ/PlqtGb8wlUpi+xa56UqavY5PBjAjJZ5tRpqCKICw1HvgRChArqwmXg==
Date: Mon, 19 Aug 2024 22:14:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Vicente Bergas <vicencb@gmail.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, Huang-Huang Bao <i@eh5.me>,
 "Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-spi@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Linus Walleij
 <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
In-Reply-To: <CAAMcf8BAiva1GB_1AoVH-Nq8sp81KdtVe=rUMVjV2ZxCiM4NAg@mail.gmail.com>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com>
 <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com>
 <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com>
 <D3JXD607339U.2F1IAKUSM59UP@cknow.org>
 <CAAMcf8BAiva1GB_1AoVH-Nq8sp81KdtVe=rUMVjV2ZxCiM4NAg@mail.gmail.com>
Message-ID: <164916293044ff73e8b35e9a9ab4283b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-19 16:37, Vicente Bergas wrote:
> On Mon, Aug 19, 2024 at 3:33 PM Diederik de Haas 
> <didi.debian@cknow.org> wrote:
>> 
>> On Mon Aug 19, 2024 at 3:14 PM CEST, Vicente Bergas wrote:
>> > On Mon, Aug 19, 2024 at 2:49 PM Vicente Bergas <vicencb@gmail.com> wrote:
>> > > On Mon, Aug 19, 2024 at 4:12 AM Vicente Bergas <vicencb@gmail.com> wrote:
>> > > > > i am a user of the CONFIG_SPI_SPIDEV device.
>> > > > > It stopped working between 6.8 and 6.10.5.
>> > > > > The SPI bus itself reports no errors to userspace, but no devices
>> > > > > appear connected to the bus.
>> > > > > The platform used is RK3328.
>> > > > > The only spi-related message in dmesg is:
>> > > > > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>> 
>> FWIW: I've seen this issue as well.
>> 
>> > > Added:
>> > > Huang-Huang Bao <i@eh5.me>
>> > > Linus Walleij <linus.walleij@linaro.org>
>> > > Sasha Levin <sashal@kernel.org>
>> > >
>> > > The first offending commit is:
>> > > 29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmux
>> > > bits for RK3328 GPIO2-B pins
>> > >
>> > > I've also tested 6.10.6 with it reverted (and
>> > > 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
>> > > 7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
>> > > works fine.
>> >
>> > Sorry for the noise:
>> > reverting only 29d8101fb9442544077e68e27839a1979f85633d makes it work on 6.10.6.
>> > Ignore what i said about 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
>> > 7127c68c76f120367b9a5053f524df0b603d4a48.
>> 
>> Please try if unreverting that commit and adding the following:
>> https://lore.kernel.org/linux-rockchip/20240709105428.1176375-1-i@eh5.me/
>> 
>> fixes the issue as well.
> 
> I confirm that 6.10.6 without any reverts plus
> 20240709105428.1176375-1-i@eh5.me also fixes the issue.
> Thank you all.

Great!  Could you, please, provide your Tested-by in the patch thread
linked above?  That should help with getting that patch merged upstream.

