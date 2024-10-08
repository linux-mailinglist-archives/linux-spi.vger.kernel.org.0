Return-Path: <linux-spi+bounces-5152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95199543A
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2529E1F2633B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3376F2F3;
	Tue,  8 Oct 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="N+kX042B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997E33986;
	Tue,  8 Oct 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404331; cv=none; b=UQ86mRfLxtgrGoQsEwTKGDp7E4mupHnaWm48UsaTyyf/t3OvzqZkh/HKnPKRRXLTviBLWFwEhmA81uRg1Eai2WEpn3wlhhjoQ396ydoqGXyuD0DAPKcotN5pYYyh2E+pLdB3Ua1xDldGGB1x11IpYgdZmclWpJshjHkWJTa2oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404331; c=relaxed/simple;
	bh=+8ay8vAeT+yhVnHB3MeZaHdeZWEIQQThJ35GfikM7Ps=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PXKCH9srni0vI1sYwqclHWyu/ng+b3iwaIVa9epTivxyWgvj8qilrWXec+tYXhPpIh3crzr2MtZkfxEe6fA0UwvFy0XzJxFQ4wC496Y3I7eX2CTuRfTGdIUt2C7RFuKQoZvO6zxnZELCW2V65Ylw3B8+ekLTzWWGBXCu5giI03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=N+kX042B; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728404327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxQ8IxcGyXJP1zufYJ5M9jcB29xMFBanedmkDjAMRI4=;
	b=N+kX042BIyH4GAwVaT870FLMjhOz1FkC06gB6NqhrM3hfiE3WNEAvGhlmoJKq/W1Nql1/O
	Qx7RvqH0ghsBWC8EzF6Sr3F7RezkXGT/MTKKQ/5yrVjhdJ63YjictAq3Z9ai/M9jryeOcW
	SYiABf3JB0n6jdzS9PmYTwVylFx9wFlbBOw6Yp7QDPFCzog7sAQVwWivfzWxkxu5JOtJ2M
	2XARZ9Sb1XZuO6Eda7lBBFjOgdlMpwPXkalSQ7DFJOwGc50e6A3eO9Xrtm4PgEARhpcvex
	XJQT7/PiphETvSHXTlcLVcahxqnt5OHbuhdHRw794ps/Z/VikYPaUN6y1YM+Dg==
Date: Tue, 08 Oct 2024 18:18:46 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de, gregkh@linuxfoundation.org,
 rafael@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
In-Reply-To: <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
Message-ID: <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Mark,

I just spotted a couple of small typos, noted below, and I hope you 
won't
mind to apply the fixes by hand before applying this patch, please?

On 2024-09-29 11:21, Dragan Simic wrote:
> Some drivers can still provide their functionality to a certain extent 
> even

s/extent even/extent when/

> some of their resource acquisitions eventually fail.  In such cases, 
> emitting
> errors isn't the desired action, but warnings should be emitted 
> instead.
> 
> To solve this, introduce dev_warn_probe() as a new device probe log 
> helper,
> which behaves identically as the already existing dev_err_probe(), 
> while it
> produces warnings instead of errors.  The intended use is with the 
> resources
> that are actually optional for a particular driver.
> 
> While there, copyedit the kerneldoc for dev_err_probe() a bit, to 
> simplify
> its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), 
> with
> the necessary wording adjustments, of course.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/base/core.c        | 129 +++++++++++++++++++++++++++++--------
>  include/linux/dev_printk.h |   1 +
>  2 files changed, 102 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8c0733d3aad8..f2e41db0c09f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4982,71 +4982,144 @@ define_dev_printk_level(_dev_info, KERN_INFO);
> 
>  #endif
> 
> +static void __dev_probe_failed(const struct device *dev, int err, bool 
> fatal,
> +			       const char *fmt, va_list vargsp)
> +{
> +	struct va_format vaf;
> +	va_list vargs;
> +
> +	/*
> +	 * On x86_64 and possibly on other architectures, va_list is actually 
> a
> +	 * size-1 array containing a structure.  As a result, function 
> parameter
> +	 * vargps decays from T[1] to T*, and &vargsp has type T** rather 
> than

s/vargps decays/vargsp decays/

> +	 * T(*)[1], which is expected by its assignment to vaf.va below.
> +	 *
> +	 * One standard way to solve this mess is by creating a copy in a 
> local
> +	 * variable of type va_list and then using a pointer to that local 
> copy
> +	 * instead, which is the approach employed here.
> +	 */
> +	va_copy(vargs, vargsp);
> +
> +	vaf.fmt = fmt;
> +	vaf.va = &vargs;

