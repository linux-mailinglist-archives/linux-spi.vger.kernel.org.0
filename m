Return-Path: <linux-spi+bounces-8810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F803AEB84C
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 14:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DA11C47E3E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6ED2D8DC5;
	Fri, 27 Jun 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkV4kRSM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BF2BD5A2;
	Fri, 27 Jun 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029099; cv=none; b=NejzDApUDDlEXclt1KetBPiUeeYwh4pM7m7zYO4ViqIUCYR6gJzE/TvXFLyVlTpGARI3Ec8N8xshi47SCBBoOi0oQMtmwSd8Q1BeppG9gX3V5Ba5wmIs/p7a9ugCFhvPK1cKa3CEaEWbij+4pDURYPgFH2Ydck5E70K1ZPRAsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029099; c=relaxed/simple;
	bh=NLK9LVywafopxTYCHb6PiC+xCymbm8kdUK/ydn2ddaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+IHR7aTP33/ASF5XRA1c7IrIrKgePGDDx6TjC+8SOBpW2rpZkQjlaliZWiOH2J6llhaQrvqw8tJkctf8gGE4D8xB8v4rGXsIqZnS5RM26wxpW1hpB6JWwE+iwZfLaN39AIGQIOB6d6sSIyK70rprNe7vPYWMoMg8MO9i1HYyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkV4kRSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E882CC4CEED;
	Fri, 27 Jun 2025 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751029097;
	bh=NLK9LVywafopxTYCHb6PiC+xCymbm8kdUK/ydn2ddaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkV4kRSM6WLllV0xsEAvUFoZk1GvCn53VzRv3t61qWGvnreGTEheBvBqyMY5aM6vx
	 x/xBD6cnT+/ST1+thGTWUjz+Goxq7Zygw5g0d087qaDjhUMGQ6POj9RcpurfFvMZGL
	 denfCzTOvqn8ICVFS2Mud3bfr9DiOPBbEGn8m7UeOFqE3JHbuDCiSQQooQxDxPdLbu
	 ioVjA7tzZWmHKG6xjBXjMVr2onRxqvDzDkxw+1fe1JIRJ8uYj94w6b3gz+1N14HNSw
	 9xUgjaPxZ3GPTb23QufuJThE38C4PM1PvpUaAiCNTyNDH0oGtwS5WQ5+7eOH5BrUAN
	 DV8ti1P7umYCw==
Date: Fri, 27 Jun 2025 13:58:11 +0100
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
Message-ID: <20250627125811.GH10134@google.com>
References: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
 <175033649656.801367.11888454651585197053.b4-ty@kernel.org>
 <f1cc8959-d420-4ba3-922f-ed7c6f054f22@t-8ch.de>
 <20250625090439.GQ795775@google.com>
 <e340b32d-8839-43b0-8662-edef1729ad6e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e340b32d-8839-43b0-8662-edef1729ad6e@t-8ch.de>

On Thu, 26 Jun 2025, Thomas Weißschuh wrote:

> On 2025-06-25 10:04:39+0100, Lee Jones wrote:
> > On Thu, 19 Jun 2025, Thomas Weißschuh wrote:
> > > On 2025-06-19 13:34:56+0100, Lee Jones wrote:
> > > > On Tue, 17 Jun 2025 19:08:13 +0200, Thomas Weißschuh wrote:
> > > > > devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> > > > > marked as unusable and trigger errors on usage.
> > > > > 
> > > > > Add the missed check.
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [2/3] leds: lp8860: Check return value of devm_mutex_init()
> > > >       commit: 426e0c8e8eed26b67bbbd138483bb5973724adae
> > > 
> > > Thanks, but (as mentioned in the cover letter) these patches should go
> > > together through the mutex/locking tree.
> > > Could you drop it on your side and give an Ack instead?
> > 
> > There has to be good reasons to do this.
> >
> > I didn't see any dependents or dependencies in this patch.
> 
> Patch 3 depends on patch 1 and 2.
> 
> It will break the build for each instance of an ignored return value
> of devm_mutex_init(). Therefore all such instances need to be resolved
> before the patch can be applied.
> So the patches can't go through different trees.
> 
> In theory we could fix the drivers in this cycle and then change
> devm_mutex_init() in the next one. But new regressions are introduced
> over and over. This patch is already in the third cycle...

Fair point.

Acked-by: Lee Jones <lee@kernel.org>

And patch removed from LEDs.

-- 
Lee Jones [李琼斯]

