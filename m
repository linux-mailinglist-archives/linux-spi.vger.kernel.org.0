Return-Path: <linux-spi+bounces-3192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F68D6BFB
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9AA1C21F4D
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76079B96;
	Fri, 31 May 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iDENixAm"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E79171D8;
	Fri, 31 May 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192749; cv=none; b=K4a4bNyqtIpYwAhA0kfFv2fwd3pnEHlG7ZGPGwkRIjk1mZQZlWzS0PzvJtHb7lMWPleMgGkKK7M1ZO+bf3nizpM48EFLpw/x/Rf8tugy9yCz7lp4aAiL9pSY3f/icVfwRZF1NUJKBmrU81U5if1gn7x1PFSn+NZyuDm93+mGRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192749; c=relaxed/simple;
	bh=O8ymDQ5yVrL9D3e0P74XI6rP7Eiyi8eowDSo7R2p2IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc2WN3Zxy04brAPS+2/MOxyYVEt9tGu7qixXGttBsC9ODd1XnHdwrZsoSW/XP14//gcFkIQCpL2YJ45VbEiv0f0w2EkhO3kMuoo6lo+pffwXjpa4m2QQTUN71YxA2zhaAi4HbegIZPbru8ZE+NJkANZkDB69FnQ3y+1Fe2Pk15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iDENixAm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717192746;
	bh=O8ymDQ5yVrL9D3e0P74XI6rP7Eiyi8eowDSo7R2p2IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDENixAmQswnvaO4IWzp36sGYIgk0EWhzXLxMxE5rW6b6HQS33SpdJM7DuOJLwllH
	 HyB5Ks8G9Ptc8yEv5KOjAbL4OiChv+HBUFoVcm3osRJpo29QsL3dXIOB1MIPBFAZft
	 KonOrSknU4oRIJvCLlXKcubdSLb4M8DfIKYm481PdKgkaSNe66lLyXPXq8u1y+D7LZ
	 zqtEFBQ75fT+TFJj3EIatzAUm0sWosPB7GPr7w0YVe5FwTILfWV1RlAxb4BJp3vtZj
	 ZjVOb2wTN1/9+/GrwqTtayoPWMoQ18Mj0iaddOagj1XJASNN9sCPB/2ZH65QTUmVCX
	 orHx+G0cftp1Q==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 957E13780EC6;
	Fri, 31 May 2024 21:59:05 +0000 (UTC)
Date: Fri, 31 May 2024 17:59:03 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <401f38c6-78ca-4553-8261-03290886a70b@notapiano>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
 <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
 <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
 <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>

On Sat, Jun 01, 2024 at 12:45:30AM +0300, Andy Shevchenko wrote:
> On Fri, May 31, 2024 at 8:14 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Fri, May 31, 2024 at 06:51:46PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 31, 2024 at 6:46 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, May 31, 2024 at 5:37 PM Nícolas F. R. A. Prado
> > > > <nfraprado@collabora.com> wrote:
> > > > > On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > applying either of these patches causes issues. See the traces for each one
> > > > > below. This was tested on top of next-20240531, which works fine.
> > > >
> > > > Oh, thank you very much for prompt testing! Can you test just the
> > > > second one without the revert?
> > >
> > > Ah, you wrote "either", so it seems you have tried that already.
> >
> > Yes exactly. Both patches are troublesome. Patch 2 causes a slightly different
> > null pointer dereference, in "dcache_clean_poc+0x20/0x38", as the stack trace I
> > posted shows.
> 
> I have sent a new series where the last patch has a massive rework of
> the cur_msg_mapped flag. Would be nice to see if it passes your tests.
> The main idea there is to actually move to per transfer flag(s) from
> per message one.

Ah great, I really felt that the flag should've been per transfer, so thank you
for making that change. I'll do some testing on Monday.

Thanks,
Nícolas

