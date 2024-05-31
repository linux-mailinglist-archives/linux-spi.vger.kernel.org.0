Return-Path: <linux-spi+bounces-3181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949B8D67E9
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E811F22488
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744F17623B;
	Fri, 31 May 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bAwIFyec"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916B76C61;
	Fri, 31 May 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175663; cv=none; b=WGQDsDSuSEVn4nxI7edLU0nzeepKxwj28GyVG31IgpU++64TIxY+OUN9jZvybSCYG+yE5CZIwTXa1nYig7ev/tw8MLKaaA3OJXnsnL0SkR5zmquMCF/U2Pns9K+7mvp5wtbRMpbljEkSWYRyDEKCHSIoes5vlXYJr5gNqqAltiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175663; c=relaxed/simple;
	bh=LubOuqlsH4juCCG6oiOYfWn/zCpV01ttl4daFeGIC90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJUVeMwAhOCaWIV3pbIOVFNn2QOey4tbEACg6ZUcgYWikrcv84L2QWajz1kJh/7I1M1o0lbND4AJkQY2QWNOrJ4oRnXyKMY4+2Ceo2y3kAvkwNhMmCuHj/A0gYtgrQa51Q12/cvhNsPWNgq2viUakFDfs8XmiMlWoZHqpqKhRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bAwIFyec; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717175660;
	bh=LubOuqlsH4juCCG6oiOYfWn/zCpV01ttl4daFeGIC90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAwIFyec8xOQLP+u85aLmIRFNaEL0y85Vc97SzlzjnFTBmIVyAVT+TWi/+PH+9zzx
	 XmiftPLZ6+5Pd1xTCHlrnMdomyD4TNUNVinPFJyJMgeZ+VGd9byt8zFGDn3G6DVFT7
	 eGH12LnjlqYMAVXDgD36cRsnugWUbSflT5ZFxXizwYdfC+GKACfakRn0SUQvNypmZ+
	 0/j1WMBSFLKTUfU8eSjyS0ciwFzzXrilHeVwzsW38ZZ5d4VR68cHcr9QHGtyeyMEu5
	 nGQj5gFReLTt7gvjNDu6CaoCf+gVkQsStdELWNqVxQl+d6gnjotg6FjjtgRqv01cZw
	 RjMECUUhmyBrQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B4FF437821DF;
	Fri, 31 May 2024 17:14:19 +0000 (UTC)
Date: Fri, 31 May 2024 13:14:17 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
 <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>

On Fri, May 31, 2024 at 06:51:46PM +0300, Andy Shevchenko wrote:
> On Fri, May 31, 2024 at 6:46 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, May 31, 2024 at 5:37 PM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > > On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > applying either of these patches causes issues. See the traces for each one
> > > below. This was tested on top of next-20240531, which works fine.
> >
> > Oh, thank you very much for prompt testing! Can you test just the
> > second one without the revert?
> 
> Ah, you wrote "either", so it seems you have tried that already.

Yes exactly. Both patches are troublesome. Patch 2 causes a slightly different
null pointer dereference, in "dcache_clean_poc+0x20/0x38", as the stack trace I
posted shows.

Thanks,
Nícolas

