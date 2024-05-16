Return-Path: <linux-spi+bounces-2861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141828C7481
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E72835B2
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89D14388D;
	Thu, 16 May 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El5SV9AX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48924143754;
	Thu, 16 May 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854692; cv=none; b=n7KeogpEouQaWQfN59dv/5dBuCLMOiT0y9yEIUOW3wec8ZoWRYEvg0glIfQmokIuq1Mi5fXgo8+PNn54/WiUfFOL9Cc9IpljbjRoeJo9T7sUZq8Bb+Ek8Tj5s/9vs1xorkeqHU58r1o466N1K/nwlwvSZuCWrKv2AxV8Gfr5l9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854692; c=relaxed/simple;
	bh=oM99wvMghWzRLZiCkmAW+JkH+y2MSn2kxDiVKwQUaAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U87Mqw0Hmq2g1IJEwbfQtoASJbnFy/7n3o7bk/Co0L/yN6qMMRVBATF10hKDwJQDRaRN4CA3wSbG15zwPMgS2C40kcU9Bum+OanEIKW6iR55pRvgmW0FEDLte4ZJJWCsagpa53Aij+TRz7xe6mUnrgvhwd/j5sYl+UKpYSeTqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El5SV9AX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715854690; x=1747390690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oM99wvMghWzRLZiCkmAW+JkH+y2MSn2kxDiVKwQUaAk=;
  b=El5SV9AXm2bQhTK0pIg0D1k7JNp120y5OR97qWp8om1uP25nov2dFlSV
   6qed0njNeFHTK34LUhMzHpxKzPGWu58swrQCAQOqgg/fkZb5upvSkad2l
   tlARvPbbWf5QTpQ+42JPDyRItNt1rT9VPldkBYCsnx7W1ROQUogZDoTCg
   c8Q8EhlKg+yjcrMak+nrInL/usxRktC3+I5/kj8og8fq3IeGJNhTqlc2j
   0bPS53hGGD6nlNORTt+ROYKO31rJ6pfplJntZk1usiLudVOabDb4yTrIv
   mCOO8zOcvOj/ckKSQEgBHI5s5X2f205FDsxO5dFBaXuwAhnujrBAT+Qf5
   g==;
X-CSE-ConnectionGUID: ub3PLRTQQcG4zFId+icWJw==
X-CSE-MsgGUID: zfMXCRMgRdql7KQqF09ZvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11555063"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11555063"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:18:08 -0700
X-CSE-ConnectionGUID: g6LZCYGxTf6yynXW1143Pw==
X-CSE-MsgGUID: XO4C68ctQzK6M+0msbGgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31796158"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:18:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7YBY-000000080RE-3xMw;
	Thu, 16 May 2024 13:18:04 +0300
Date: Thu, 16 May 2024 13:18:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <ZkXdXO4Xb83270V7@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > have checks for orig_nents against 0. No need to duplicate this.
> > All the same applies to other DMA mapping API calls.
> > 
> > Also note, there is no other user in the kernel that does this kind of
> > checks.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> this commit caused a regression which I reported here:
> 
> https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> 
> along with some thoughts on the cause and a possible solution, though I'm not
> familiar with this code base at all and would really appreciate any feedback you
> may have.

Thanks for the report and preliminary analysis!
I'll look at it hopefully sooner than later.

But at least what I think now is that my change revealed a problem somewhere
else, because that's how DMA mapping / streaming APIs designed, it's extremely
rare to check orig_nents field.

-- 
With Best Regards,
Andy Shevchenko



