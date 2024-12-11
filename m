Return-Path: <linux-spi+bounces-6003-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36159ECB4C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 12:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA5E18897D2
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E21D5CC1;
	Wed, 11 Dec 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK6MSRNm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F211C5CCB;
	Wed, 11 Dec 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916822; cv=none; b=Nhc3zAcAQAPkID7PYXAbMLz9i+kEARgNshvkaaLEvNsVGoXPzcg7osQhA2ptvldoAikwBc8BdciYPZnTD8AiiG8UTLQV4jJH+rGTzSSu/o/KMJrCwx99giU5lCBFskOD+4xjFSvffCtwxzk0LvA0fyjLMwHTgycPv1myVKvzqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916822; c=relaxed/simple;
	bh=qhqHdcl3NWiibbFCCVo7iHKiCJ4FrrhBPjDsMw3+SP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVnBzRydpDQsCujB9yZzdFAxuuNhxFVSydZzsf7SYPINOKbiH/ORxHzUSLnPX7FZQG/4U41tpAXj/qIn+3N2P7d3/2zraS9YFp2hvn5d0KiCPHG2X+T+P23a/E5X1eRyD01NOzY4/q/FDIDTxxQve3Fby4H4k9aGRhAezlb3dKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TK6MSRNm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733916821; x=1765452821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qhqHdcl3NWiibbFCCVo7iHKiCJ4FrrhBPjDsMw3+SP8=;
  b=TK6MSRNmuqMHhR8O77y9Hs4rRildwtNruDXwOIrdEybZDiJb0SyclqI+
   DjhdfrO0X1DSvnXBJLPeWbicGK1fo1JrJ2jc2AWwnbtfwGmbYP02cveog
   1g6ie08MuZr68+SexZNEB/kcQNQSWD+gSab3wQUR9bKmSv8NogfRzU1qW
   DSYTKZSqKeXf9RldUz/LKYBB3iEnHivsekQWVw1jq0C6TJddQ8cBvgO1L
   pi3pot0I/Ruq/LOwyRJmwjeQOI24rsLVzcYpnTqrv2YarsCjBUsaij+YZ
   oGPldWEZWQtpzSHlVx2GLair+dJhThQXwCN3ArPFwTt1BC+Nke670ro9d
   A==;
X-CSE-ConnectionGUID: mpQxOgmyRz6b5jE2NluCBg==
X-CSE-MsgGUID: wxuMO7PNR1qeaotU0MBgfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33611996"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="33611996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:33:40 -0800
X-CSE-ConnectionGUID: 8Rhw2/RdR+ulZ4/NevpnVQ==
X-CSE-MsgGUID: VnkPecRGTl6/r3U7hhQmtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100829475"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:33:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLKyE-00000006Vf3-0wzd;
	Wed, 11 Dec 2024 13:33:34 +0200
Date: Wed, 11 Dec 2024 13:33:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] spi: Unify and simplify fwnode related checks
Message-ID: <Z1l4jTtm-BterK5D@smile.fi.intel.com>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
 <fc015f10-9780-4e2a-9dcf-de7e4b253be2@quicinc.com>
 <Z1lwnqGZsO_x8h0k@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1lwnqGZsO_x8h0k@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 11, 2024 at 12:59:42PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 11, 2024 at 09:42:33AM +0530, Mukesh Kumar Savaliya wrote:
> > On 12/8/2024 9:33 PM, Andy Shevchenko wrote:
> > > couple of cleanups on top of recently added change.
> > please add what exactly cleanups done ? Recently added change is not that
> > something someone would check as part of this patch.
> > Description would be helpful.
> 
> But each patch has its description. Or I didn't get the request, sorry.

FWIW, the change induced this mini-series is this one: d24cfee7f63d ("spi: Fix
acpi deferred irq probe").


-- 
With Best Regards,
Andy Shevchenko



