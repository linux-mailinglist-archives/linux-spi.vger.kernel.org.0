Return-Path: <linux-spi+bounces-8783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81AAE9BE5
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1204172AEF
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841026A1B6;
	Thu, 26 Jun 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NS2N6ibF"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731126B2DC;
	Thu, 26 Jun 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935256; cv=none; b=qPWVgC95UQ1FrBmfAt/GeqQ7MShY8y9yuOKDxNUC5IKLBKNvW3hgquntbZkbKFSPc80X7xYQuuCjdp5YkBP675FYLKKz1yKpmCDRNaP/tGJ7yfrDi1RAySM+1Cyzm2P2yjc1z1+nxbkqqGAvOjhDKr5rXx7v8tGboRIeQZr4bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935256; c=relaxed/simple;
	bh=u4FAkkOPIZ9Sb0kPH8gkTxSqGIvSB0tKE6FdM9MQkpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqGqJNVe8t4RrxVfQMQEr5Rdniq4KsI0fOcyGX3Ycyoj+ZIvnDwyYV4rI8MVaMrhMxn1fVFjCyQ7itVXG/FTuiKULCtNtWgt6AkLEaapD1NcBSbNMQd71qpdUG8XvBBxQf9ggtrIiqWMXK+zLVGNdOB1ur1TPnJx5+RI4XFr4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NS2N6ibF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750935252;
	bh=u4FAkkOPIZ9Sb0kPH8gkTxSqGIvSB0tKE6FdM9MQkpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS2N6ibFj6oaTIBo24pnT+DGukdYkKlOAu/TnzAIu1YBEqkEpeVCSTO97Pq3w53W5
	 JqhjmLcHJi93Q2c+73u8qJFk3AB8W4zk+IW4rQu9lHqEl7+CwilozoAO7niKWlqTU1
	 rmZwNIob/4UwUMMBt6Hs5PZM6ABZmdYixpfoDhaU=
Date: Thu, 26 Jun 2025 12:54:11 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Lee Jones <lee@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH v7 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Message-ID: <e340b32d-8839-43b0-8662-edef1729ad6e@t-8ch.de>
References: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
 <175033649656.801367.11888454651585197053.b4-ty@kernel.org>
 <f1cc8959-d420-4ba3-922f-ed7c6f054f22@t-8ch.de>
 <20250625090439.GQ795775@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625090439.GQ795775@google.com>

On 2025-06-25 10:04:39+0100, Lee Jones wrote:
> On Thu, 19 Jun 2025, Thomas Weißschuh wrote:
> > On 2025-06-19 13:34:56+0100, Lee Jones wrote:
> > > On Tue, 17 Jun 2025 19:08:13 +0200, Thomas Weißschuh wrote:
> > > > devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> > > > marked as unusable and trigger errors on usage.
> > > > 
> > > > Add the missed check.
> > > 
> > > Applied, thanks!
> > > 
> > > [2/3] leds: lp8860: Check return value of devm_mutex_init()
> > >       commit: 426e0c8e8eed26b67bbbd138483bb5973724adae
> > 
> > Thanks, but (as mentioned in the cover letter) these patches should go
> > together through the mutex/locking tree.
> > Could you drop it on your side and give an Ack instead?
> 
> There has to be good reasons to do this.
>
> I didn't see any dependents or dependencies in this patch.

Patch 3 depends on patch 1 and 2.

It will break the build for each instance of an ignored return value
of devm_mutex_init(). Therefore all such instances need to be resolved
before the patch can be applied.
So the patches can't go through different trees.

In theory we could fix the drivers in this cycle and then change
devm_mutex_init() in the next one. But new regressions are introduced
over and over. This patch is already in the third cycle...


Thomas

