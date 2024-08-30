Return-Path: <linux-spi+bounces-4456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAF965C5F
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614B81F228B9
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8316F0EF;
	Fri, 30 Aug 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqFaoQQa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461417B4E0;
	Fri, 30 Aug 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009009; cv=none; b=i+Jihh0cNALamkJwH2+57TTmbuK42ocX5tN42WJ9OHBv2+BfSHjuxPP2zRrHPkO+Ny8xnslN0u9eiiaCBh6+R7amES3sgxkkM3OdYz2OAar2jKUEQykUJ05+BZ3h+oh0nuqNisYoQZX3h38XvomPsj4GgJkzZac4CIykEIV9LN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009009; c=relaxed/simple;
	bh=kfijo2+xqqW8XW+d5fPcNJSGyaXGNiyYLFllsro5SXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1pCSDRBDgSfXxDC0rHFBVbAVmEVt2t8qFVMoAbwMsAswsUPmJCNhjvzWfCUL+aaMeQ7SAztqN1E5Sr/25MAl1zCdDn0Xe/PGuGvvr/1tKCPNI72F8E0x6MFTqDydwwRdjHEoX3NgXb/7d+wBtj9sf0LRF8NGYKAjUfT7RAdjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqFaoQQa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725009008; x=1756545008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfijo2+xqqW8XW+d5fPcNJSGyaXGNiyYLFllsro5SXo=;
  b=KqFaoQQadXP0rwgK1O8Z/+efodXDw+xd8sPgvx0yAl1JtHHOIQZKPrGm
   BL4lNZgf0wGmPlqXeLqhQnmdiPsMROYRP1/wjF985J42/d+vi4vIs1OXY
   yrqz+ffZsjGg7/US4wB0ckOnv9ml2XCO+g5he9x81a+S6+Bp3vOwqMKtN
   9O7dOrlpRIilAaa42/zWXutEAvpUlHecgvkJqCWLTl7lbaRJcv9F5+V4i
   En3IMUi6Epwwj7FtmRfmWjRkNCoC468SrlvjFxfk87YpmGZYTPomn4vpX
   vH5omoPs0WwgDV8K0gcU4JTlOCBOeVSjn43oNcG6w8JbSW/gwMvyV9lo2
   w==;
X-CSE-ConnectionGUID: TfP95sb0RzqtxJ+QP/xatw==
X-CSE-MsgGUID: MwIv9tuMR2Oj32LKCsfj9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27403225"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27403225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:10:08 -0700
X-CSE-ConnectionGUID: km0/PoejS56FPsXA/Nebmw==
X-CSE-MsgGUID: NRNeCkb6Q3KWq6SkLayRFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63536281"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Aug 2024 02:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 65302142; Fri, 30 Aug 2024 12:10:04 +0300 (EEST)
Date: Fri, 30 Aug 2024 12:10:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: intel: Add check devm_kasprintf() returned value
Message-ID: <20240830091004.GW1532424@black.fi.intel.com>
References: <20240830074106.8744-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830074106.8744-1-hanchunchao@inspur.com>

On Fri, Aug 30, 2024 at 03:41:06PM +0800, Charles Han wrote:
> intel_spi_populate_chip() use devm_kasprintf() to set pdata->name.
> This can return a NULL pointer on failure but this returned value
> is not checked.
> 
> Fixes: e58db3bcd93b ("spi: intel: Add default partition and name to the second chip")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

