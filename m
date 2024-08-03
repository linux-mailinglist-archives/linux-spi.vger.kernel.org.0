Return-Path: <linux-spi+bounces-4134-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30051946A65
	for <lists+linux-spi@lfdr.de>; Sat,  3 Aug 2024 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F43F1F215E8
	for <lists+linux-spi@lfdr.de>; Sat,  3 Aug 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6AC14EC40;
	Sat,  3 Aug 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uZlVrNKq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CC1ABEA7;
	Sat,  3 Aug 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699588; cv=none; b=oD6h6AZap0TZVNNfY7xJIPtUkpOzN9b6WzUzpPa6vij2XbLxDfhvoknYgiIsNPzLTQPuxzZv6MmxFvRgiaFkyH+QMDfYs4Ks5a9dGPpKyUYresbF/IZFswHJTKOmihKDedwqaFK/zWMLuYo+pcbyxTFMuKdj3o0+HaGOCzC1uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699588; c=relaxed/simple;
	bh=c7L5c3f+OISTHPHqMQv1tS6fuEny3qpUpcF3XQ/oz7s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VsQfPYRSTRUhnIG6ZVNtYRRVD6+bs1Rgj/xMxlddVU5e6Veb3jj7DpLNZZmMMf73LOXK35+Kl4LKY3u2PEvAU3JGGeaxT8nqNXO/3d7bbhAVtj9ZrFx3aVMR5xuh4tC4ju/fsB7tfRm09Q6pEYJ6cv9T7F1lDBnn09t6ngPVA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uZlVrNKq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722699582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VkmBHa83uC/0UHbHBRgJCGZoqWtVGLYi46vvcLgbFU=;
	b=uZlVrNKqvsLYZ/Ct2pv+NUKRWagfkhmVuZDSGuJ8HGk+lU5+7CKPtQynXjC3ugR+G/tAEn
	xFEOg8vNK7fye26nZK/AOB6vAIb7cXs8k/GRDDZ+OIydc7XZgeWuFKb94j5wVyfia1PAej
	3ySI2hatosLuNXxsRn2SF7RIVH28Lns+/Oo7e2m+5czUlErMFrBGUvBAJRdHIxz3x3EfTY
	A12qUQ/Udm7vDpWJmIq40eWjKOkuM6TkdYiuiOibpjv3Bf/uUYsflLCmN+qhlKrBA3s31S
	a0FwNdCKtuKk+3B+Ew/syk8sA/xUBc+6ADOdAI/LAleBTPI7vTXYnsRIOBTLsQ==
Date: Sat, 03 Aug 2024 17:39:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Dmitrii Osipenko
 <dmitry.osipenko@collabora.com>, Mark Brown <broonie@kernel.org>, Urja
 <urja@urja.dev>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
In-Reply-To: <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <20240801131823.GB1019230@google.com>
 <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>
Message-ID: <4637f562f327f7495ccfdd88590e07ef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-08-01 17:22, Sebastian Reichel wrote:
> On Thu, Aug 01, 2024 at 02:18:23PM GMT, Lee Jones wrote:
>> > +	/*
>> > +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
>> > +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
>> > +	 * handler, so we are using the prepare handler as a workaround.
>> > +	 * This should be removed once the Rockchip SPI driver has been
>> > +	 * adapted.
>> > +	 */
>> 
>> So why not just adapt the SPI driver now?
> 
> This patch is simple and thus can easily be backported, so that the
> Acer Chromebook shutdown is fixed in the stable kernels. SPI based
> rkxx has been using SYS_OFF_MODE_POWER_OFF_PREPARE from the start,
> so it's not a regression.
> 
> As far as I could see the SPI framework does not have something
> comparable to the I2C .xfer_atomic handler. So fixing up the
> Rockchip SPI driver probably involves creating some SPI core
> helpers. I'm not yet sure about the best way to deal with this.
> But I guess it will be better not having to backport all of the
> requires changes to stable.
> 
> In any case I think the next step in this direction is discussing
> how to handle this in general for SPI.

I agree about accepting this (hot)fix first, and improving the SPI
drivers later.  Having this fixed now provides clear benefits.

Also, please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

>> What's the bet that if accepted, this hack is still here in 5 years 
>> time?
> 
> Even if I don't work on this now, I would expect somebody to have
> issues with broken shutdown on RK3588 boards before 5 years are
> over :)

