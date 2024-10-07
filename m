Return-Path: <linux-spi+bounces-5127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D879939E2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618E61F21A63
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2501925B5;
	Mon,  7 Oct 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5gPEfRV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0918FC7C
	for <linux-spi@vger.kernel.org>; Mon,  7 Oct 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338947; cv=none; b=Xt2uXm/nBq1Wio9UtyWwXCXOsnMVqPSSeZZoN8rdfgdivuxOPZXNOLcDsTPfNJRMLV/LzBQsTGibbxk5MeypaCHKG+Fl/GkTL6mho/ca5tDTIrEoNwmWMIU0oecVXH4QDny/Bb1x1cd250w29JjXQRORtpmddCyl+0xD5EHP/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338947; c=relaxed/simple;
	bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo8XNrRxoNcCp7qRkcvSeEjolX937k99H65Iik/W4yLoNhw18I+Faa2sT/nDyJ0ieTqU7raLJJFqfVRRfAYn9wf9QHLj6sNIc73n5t/HvGwloSt1Obnrx6/dbP5Pvqh2MgTEzGZUHd2u3LhgkgDZEqtBzZbfiLGV3ZXaJjO+iZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5gPEfRV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so4024463276.3
        for <linux-spi@vger.kernel.org>; Mon, 07 Oct 2024 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728338945; x=1728943745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=o5gPEfRVAPlC3zVYqo+I0JP5NyXEZ6n92t/2cOOeQ+1bivAKOH46p2bRVGrUROWBYT
         oSIwcf/2mr6bCpUy6cAuJSTfxZHQn6u/koaFilEE7hkWQtwLutjSSjObnMoFqnSCDUd6
         QcpOgUYQNCKCUlfM9zTp778rnlwmTFmH7qRDpCxertomXwBHlFbdgFM4FnJRkkT8Scrj
         iVsXCm94AC79Zcv8S5e8yEGIla1BdfDxAdjB1WxmYMcIlYZcr64/ODMAAi2tbl/r0LkA
         ZS149sixsABPNgCjPBYoToTrNoyThZ33SejHHAxasC4XHzVbJYGnn+XzB8qXtt3350lt
         PGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338945; x=1728943745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=mm+3mlH9GegWnTZxehy+CZef4jtW2SH0KhtUJYG/QbWBEFti36YRuOGpk4MrSOx17E
         WlTDN5m5Ez4vXkpA6YgbTmqR4PymfU4wmDaTmV4oQ5VdA3Wk5alhafb1XYaGX+Ab+yko
         sY8HB/YsEdLf79e0jAYWnqgfxe6WCEgrvn74fgc0tFL8dLti5Uo+ToqXl9me2RxGCyuD
         tzRIZBBSrilZ3I63JiK4u0zmJpLY9DDhCCeSbqZv9cEbQyJcWdWElcUCZcRInbn2b26l
         JO9jzc8moD6QEbj+WPzYKRN23KByuHWpaQJ4gi1wTojWVecsQbdme6jV1z8+MYxb7FIr
         DI4w==
X-Forwarded-Encrypted: i=1; AJvYcCXVPqPGdAmhttGZloJJY9ax7apxcQG79pbWNoHmPuFwGgWt6UibzaWwG5VQY8yASaIf7+p8y/U9jH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLno2oVveCmjxxdbaGm6cXI8iNfAR5DJ9NEf7llUrHRUSf8rOL
	gxVFeiAhht0gH8tJbgx2oabw5e1PcinjCORfrh8UYaT4rlbLYJIw8IRCtH48+IH8buOxCTm6atG
	Qx/50EWT0A7zejnMNrPxXnpfXg9+Mxcv4tmuexg==
X-Google-Smtp-Source: AGHT+IE2nJVabbXdwibt1H0pVBms5dYTsG8RkBKKAzfdsgMhYsZ8VyWIk7HanuWHiQPQxXFBk2ezA08qlljJFN0QQR4=
X-Received: by 2002:a05:6902:848:b0:e28:edbd:765f with SMTP id
 3f1490d57ef6-e28edbd7f75mr206026276.2.1728338940867; Mon, 07 Oct 2024
 15:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com> <20241007184924.GH14766@pendragon.ideasonboard.com>
In-Reply-To: <20241007184924.GH14766@pendragon.ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 00:08:24 +0200
Message-ID: <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, rafael@kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > __pm_runtime_put_autosuspend() while the former will soon be re-purposed
> > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > always used together, apart from bugs which are likely common. Going
> > > forward, most new users should be using pm_runtime_put_autosuspend().
> > >
> > > Once this conversion is done and pm_runtime_put_autosuspend() re-purposed,
> > > I'll post another set to merge the calls to __pm_runtime_put_autosuspend()
> > > and pm_runtime_mark_last_busy().
> >
> > That sounds like it could cause a lot of churns.
> >
> > Why not add a new helper function that does the
> > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > things? Then we can start moving users over to this new interface,
> > rather than having this intermediate step?
>
> I think the API would be nicer if we used the shortest and simplest
> function names for the most common use cases. Following
> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> most common use case. That's why I like Sakari's approach of repurposing
> pm_runtime_put_autosuspend(), and introducing
> __pm_runtime_put_autosuspend() for the odd cases where
> pm_runtime_mark_last_busy() shouldn't be called.

Okay, so the reason for this approach is because we couldn't find a
short and descriptive name that could be used in favor of
pm_runtime_put_autosuspend(). Let me throw some ideas at it and maybe
you like it - or not. :-)

I don't know what options you guys discussed, but to me the entire
"autosuspend"-suffix isn't really that necessary in my opinion. There
are more ways than calling pm_runtime_put_autosuspend() that triggers
us to use the RPM_AUTO flag for rpm_suspend(). For example, just
calling pm_runtime_put() has the similar effect.

Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
during rpm_resume() too, for example. So why bother about having
"mark_last_busy" in the new name too.

That said, my suggestion is simply "pm_runtime_put_suspend".

If you don't like it, I will certainly not object to your current
approach, even if I think it leads to unnecessary churns.

[...]

Kind regards
Uffe

