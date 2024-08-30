Return-Path: <linux-spi+bounces-4484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF9F966949
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 21:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8041F237A8
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477B1B375E;
	Fri, 30 Aug 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjoUL+si"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275713B297;
	Fri, 30 Aug 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044968; cv=none; b=r+RpaARA5RbTX+oz+JCG7N/xPiNdDfujBJgKHqUoXzbO8qse2+7oB5e5/0RRAD3rUAuJ74uGg4LaaLMbjoUWAq7rO7XAMqK5kbgFS8r1k1Ax2jeFtZMJs2WsWMKgE0qHS52VsfuAxOCMdd8Uv6aQsSCZrx9JaxPt/Yjm4WrP9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044968; c=relaxed/simple;
	bh=+H0oADayPpchtoOuk5ksPNnleoX4Wx+gcrhLBOfKGMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBESUOuEpVgrsTvSvCZWtcatC4p8LG1bNrWdelDbGBTDe57xU33n76X/uA1KMR7vNksVWpgwR4N1/oUcSmxJOaeWxDtg/z397SPLzyD6kSbw47tdcNLcc0/iqGK14zj5bAcaOVRBQHpw2xQT6Kwz04Xu0n0kl2wZdzDUcxXkYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjoUL+si; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725044967; x=1756580967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+H0oADayPpchtoOuk5ksPNnleoX4Wx+gcrhLBOfKGMI=;
  b=jjoUL+si15agwbApo35m77vuL6YKrI9Y9jcKnLRRJXZSSk72xXA9KJCK
   gAtLvCo+caWCwKJX3km5qj9AQ989Tp1KOb+iEGXtoyOGPiNiAnYSkYIcV
   0Z/e48Ah2IALExVqZMW1/kE3TDAfccFCTUJ+G5QQ3Lnbm5wiGQt8Oa66q
   VOB9djaUYdLVtrOCwTCNx6T5MaFBT0LrurDlQsqoGVa/BLLUj66hIKLT8
   /qQZcIpxT2ugYZBzzGaRQ8SzFfUytkkKZxLwhWl7NwueTxJpZfcLIuaIv
   HcIf5afxCPE4AEHTwipe+gus5QTVwvuntsA2AhhNkOLOS+lucvL/8d+M9
   g==;
X-CSE-ConnectionGUID: Yz1ns0/0Q/2ityo3rw2Clg==
X-CSE-MsgGUID: M6fp1ZlKQAGMj3krgOmkTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27577960"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="27577960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:09:27 -0700
X-CSE-ConnectionGUID: 2PoVBcedSxShNUBTl4RoXg==
X-CSE-MsgGUID: VSjPd05BTo6/syzb1qATZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68379302"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:09:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sk6za-00000003SIx-3oo9;
	Fri, 30 Aug 2024 22:09:06 +0300
Date: Fri, 30 Aug 2024 22:09:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ma, Hao" <hao.ma@intel.com>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	"Li, Lili" <lili.li@intel.com>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data
 on probe
Message-ID: <ZtIY0jkEkX54u7AK@smile.fi.intel.com>
References: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
 <20240822113408.750831-2-andriy.shevchenko@linux.intel.com>
 <CO1PR11MB5204FD6B12B682AAFB5B813F8B972@CO1PR11MB5204.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5204FD6B12B682AAFB5B813F8B972@CO1PR11MB5204.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 30, 2024 at 04:48:26AM +0000, Ma, Hao wrote:
> Hi,Andriy,
> 
> I merged following patches and tested it works.
> 
>       [PATCH v1 1/2] spi: pxa2xx: Do not override dev->platform_data on probe
>       [PATCH v1 2/2] spi: pxa2xx: Move PM runtime handling to the glue drivers
> 
> Tested-by: Hao Ma <hao.ma@intel.com >

Thank you for confirming that it works!

-- 
With Best Regards,
Andy Shevchenko



