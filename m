Return-Path: <linux-spi+bounces-8760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C4AE7B6C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB916ED13
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F727F73D;
	Wed, 25 Jun 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqte5sv6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EE28689C;
	Wed, 25 Jun 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842286; cv=none; b=aoo1VQTo0DLey/Z8Q9msuQrvx7aKgWOKAhn8YLizAew4FlNoxo+FzjuIET72yNCcP2CFm9wlXrvcV3fzcC/I4T53SgdzgxefAH8FbeUmxcKveLc+Vf15zx4Wanwegg+kdE6rDjnGz3CVS/APXbPebdJd6V9wvXgBEyYMHw6Bj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842286; c=relaxed/simple;
	bh=VE6S4IdljfLojze0jkDz8OAExWzhUG5J1Makz+kHkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbFuT+qm6Ea/cRHmsQTU9UfLsjynaefbSsUIPYz/Zvgr6Eb8P46gUdq14JkoCprAKd17GRNC7sIDnzt35O6fgqtYSzugHqRDz2mahm7xjM4GUpYV/Qk0A4SKg8qQx3kFtNGQcyu2qkNNOmTXHrd3vDU/cQKfjCPtkfwTKlxKyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqte5sv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18646C4CEEA;
	Wed, 25 Jun 2025 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842285;
	bh=VE6S4IdljfLojze0jkDz8OAExWzhUG5J1Makz+kHkU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rqte5sv6J+gkHvmA7D3NKdMprt8FzCyTpRTZf8mcie7sPp78rbteCQ+1eJbjwgdGn
	 UJw+wyyD5nKM+mEFYlmfmj+hJiHBGtbllto4diPX78bfNRziCDixfukr3AlViQ1bMi
	 qF/XuEamC3u/u9Puwl2Z1FYAOz5OMUR11pHZmbfUDS1PbmcH6v+ojFNIkkDZltWRn9
	 zFLTgaAhiACdCBRcmOj9Zn+cZ0h+vR5ZXzttCggbx6vCWhe2k73fnTwLuBD9wiu9dc
	 51lCZrgY60/eY7q1UELawOu0JtmdzbSa+/tA6s+gmDQLPcqaEiJOVSVKG3DHqG4Lhj
	 oLa/cIEnEeRuA==
Date: Wed, 25 Jun 2025 10:04:39 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH v7 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Message-ID: <20250625090439.GQ795775@google.com>
References: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
 <175033649656.801367.11888454651585197053.b4-ty@kernel.org>
 <f1cc8959-d420-4ba3-922f-ed7c6f054f22@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1cc8959-d420-4ba3-922f-ed7c6f054f22@t-8ch.de>

On Thu, 19 Jun 2025, Thomas Weißschuh wrote:

> Hi Lee,
> 
> On 2025-06-19 13:34:56+0100, Lee Jones wrote:
> > On Tue, 17 Jun 2025 19:08:13 +0200, Thomas Weißschuh wrote:
> > > devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> > > marked as unusable and trigger errors on usage.
> > > 
> > > Add the missed check.
> > 
> > Applied, thanks!
> > 
> > [2/3] leds: lp8860: Check return value of devm_mutex_init()
> >       commit: 426e0c8e8eed26b67bbbd138483bb5973724adae
> 
> Thanks, but (as mentioned in the cover letter) these patches should go
> together through the mutex/locking tree.
> Could you drop it on your side and give an Ack instead?

There has to be good reasons to do this.

I didn't see any dependents or dependencies in this patch.

-- 
Lee Jones [李琼斯]

