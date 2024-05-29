Return-Path: <linux-spi+bounces-3125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CAF8D36D3
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 14:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A177D284E13
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577434C70;
	Wed, 29 May 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2pdmLTK7"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B7746E;
	Wed, 29 May 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987368; cv=none; b=jQbm9IHrNBjbN0ygaQpYQv9KDkyXUwaW/DTqbr4RcLr0150wXft9fUfGzBMupsLNRTb8oy3xCFYFQQ0/lDXvpwBFb6FmO4fjJuHKMva3pcGB75uDtgSfms71QHYwQl7bGVZrHT/sL++FpVI3TVzXCLcRWv76D6OUW6voDmDnTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987368; c=relaxed/simple;
	bh=K0nojx5NICne0xfYuxLzroD8EclM47ueGXsA2K0lQEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmfeYn/E1Oj/PTd9sw4aOPfFaU2/Rkg6dMU3fm2nJAut1uIZ6uBCfQcElAQWp1mp64Mmjmjv98YlpzLBZVnKR2rn3rAOMj5fp6HAt1UYNoIEU1aoY61uL1kAXsGil6PjergvtLOmMjCHmADTbmVSxCTtep02cRSir18iiQOeAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2pdmLTK7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716987363;
	bh=K0nojx5NICne0xfYuxLzroD8EclM47ueGXsA2K0lQEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2pdmLTK7kJ4wgg5/z5uUyLQptgLBjrf9EbPZ3W1OvhYwXRq77t9L+sZdfb9RxyuM3
	 VO44uwPjGxVa0r9KI5tiSzhgd54hUgxReMmt3gfRaRYfJTdnjZ75GNmzhiq8405dLn
	 Dvxy4LbHwxUH9rc/zF16WKoGdcG6g+/zRLFTHKfX9FU4kfQjX2YkRxz6pAaEGUqApm
	 P3dVa2bTAoKoglk+xQCxnc83YKqeoEZQ+9czJC9KmC2462PKSNdCRXWNGWZ6TD3s+k
	 U/cNXFhPRU2dPuu4QF1C7av4gVkyyfAyKuJQG5smueCniB92Cq1MeXIY1Y+Vp/PsEM
	 5OovF5J2P3NSA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C357378205D;
	Wed, 29 May 2024 12:56:02 +0000 (UTC)
Date: Wed, 29 May 2024 08:56:00 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] spi: Check if transfer is mapped before calling
 DMA sync APIs
Message-ID: <08b3087b-2a35-4921-b0dd-b57996d6df19@notapiano>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
 <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
 <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
 <60691eb7-ca16-4547-8744-f9bfae919a3f@notapiano>
 <ZlckBe02dybokq94@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlckBe02dybokq94@smile.fi.intel.com>

On Wed, May 29, 2024 at 03:48:05PM +0300, Andy Shevchenko wrote:
> On Wed, May 29, 2024 at 08:35:26AM -0400, Nícolas F. R. A. Prado wrote:
> > On Wed, May 22, 2024 at 02:41:51PM -0400, Nícolas F. R. A. Prado wrote:
> > > On Wed, May 22, 2024 at 08:09:50PM +0300, Andy Shevchenko wrote:
> 
> [..]
> 
> > I can send this patch to the list myself with your authorship, I just need
> > your SoB.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> P.S. Sorry for the delay, I was and still is on a sick leave.

No need to be sorry, health comes first. Hope you get better soon! :)

Thanks,
Nícolas

