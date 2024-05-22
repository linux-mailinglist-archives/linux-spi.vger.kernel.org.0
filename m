Return-Path: <linux-spi+bounces-2992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1B8CC04C
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D942817DD
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AB81ACA;
	Wed, 22 May 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8y2NcjM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBE2A8D7;
	Wed, 22 May 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377621; cv=none; b=R0U8iIOekIFN9gm0Nd5GWvyc6UOuN+65iks5DWbewdPdselkwkNH6x5ASsKD2C5ZQd2v/WzTPUmR95TUbqFnNZBw1oeEEOqRftteEeGdshbMRsEKQ1P/5szaxu8tHLI4v1X1OkTa3OS84nQlxMUVqnbFL3BpFfXu8Wkf4LTHBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377621; c=relaxed/simple;
	bh=ppLA3GtdGJReY+A88qxBFMZYBsM5WtwL4sGmG7lx61U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUBsyhW2+K8kMfnGtEor0aHNoKjvbmwRHfgSnEOuP1omlQg9U+ovCs9vQxJzToFPUKmbb7bej9+BYEXBcbtvoDIcHzkWxmOTOE5DMbgyqEblgykrhYvCDuF1LLa/AydfjXsBnITQoio+dqsR+dq0wbHBX+cb/UNTnvO5avXlspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8y2NcjM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716377619; x=1747913619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ppLA3GtdGJReY+A88qxBFMZYBsM5WtwL4sGmG7lx61U=;
  b=G8y2NcjMpj+/l/P7UHOyaUddffTulsyWhtVidB7GNmsRjm88qg1ANF9n
   yXZNjrLS1Ghgy3lncD7Vh4RFxhz1eP5wphn4kGCLD67Ukf97jJUzSrwDK
   4dfovW00vKOy0YdYaldw7ligkV8RXIW98PSIPfmcAYi1AeQOFbx/nIVte
   flrF8JSNuS9ZsmHjLlnxGw7Wi6Gs4sEJFpnvHMokuueEc8Pq2zAeki0Tf
   NieAGU+ZjxReHO163Z/uTkiTqqHTaxFUjXiIF2UaarTOIRjrV4HL6geVl
   PtTkB4P0Fbev1i9D7MmYN0HcAoHqkaT5j5CmF2EHjzKZttBL6DdAIKaz9
   g==;
X-CSE-ConnectionGUID: YgrQ/WPbS8Cd+SY5uwbufg==
X-CSE-MsgGUID: Zd6SrbKVRgKJLV5KoUE6kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16410563"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16410563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:33:05 -0700
X-CSE-ConnectionGUID: STpzZLEJQgy8EMLg52h4aw==
X-CSE-MsgGUID: JUnZ14FAQc+QX6sUZCtHJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33680482"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:33:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9kDM-00000009xMi-3ino;
	Wed, 22 May 2024 14:33:00 +0300
Date: Wed, 22 May 2024 14:33:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
> On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
> > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > have checks for orig_nents against 0. No need to duplicate this.
> > > All the same applies to other DMA mapping API calls.
> > > 
> > > Also note, there is no other user in the kernel that does this kind of
> > > checks.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Hi,
> > 
> > this commit caused a regression which I reported here:
> > 
> > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > 
> > along with some thoughts on the cause and a possible solution, though I'm not
> > familiar with this code base at all and would really appreciate any feedback you
> > may have.
> 
> I also see the same regression on the SM8550 and SM8650 platforms,
> please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.

There is still no answer from IOMMU patch author. Do you have the same trace
due to IOMMU calls? Anyway, I guess it would be nice to see it.

Meanwhile, I have three changes I posted in the replies to the initial report,
can you combine them all and test? This will be a plan B (? or A, depending on
the culprit).

-- 
With Best Regards,
Andy Shevchenko



