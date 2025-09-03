Return-Path: <linux-spi+bounces-9875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10684B41BD3
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 12:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBF51BA5A80
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E82F1FC1;
	Wed,  3 Sep 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFrrDGXi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E32EC088;
	Wed,  3 Sep 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895286; cv=none; b=VawYvhWRINV7N8rfcopwzLpqHo350yi9GF0YUcZnWx/SVRQOXk/K6GK1a5yDx0PNNBWhQ3TLte+mBGh0uypjL5NbMpM6f0zbT6V0avBkFhuJzZchs02RIV/dVkpm4sU+TXItjHAjjhSgOBXF9zebZYo+cY/t45gfshgdtsYcOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895286; c=relaxed/simple;
	bh=d0x3JX/+9DiVecJg9Q5If5tZJiuJvMmVamNF3ZJOfzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP2Cyqx+K3pTFJKyUzt65ZMw1tuU5YkJ8dFlA4RvrgSKwNCrB8YRCh9BVZuJtOkO3WW8fZ6Ga+bVauM3P27GJ0tnxHp9pGTVtZ4r3FlhgozCPouUIXPMkVCQ+R+uBouwmjcg+PpLEki065RSwwseqeDGvBBIJV9V9jdJVo9omnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFrrDGXi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756895285; x=1788431285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d0x3JX/+9DiVecJg9Q5If5tZJiuJvMmVamNF3ZJOfzo=;
  b=BFrrDGXigzk12OdWpxxMXL6I77W4SA9RfQ+N069TtpnI5DrLpmXCFt7/
   hRfg2K0QPjUSIyUwdgnEQr0Nh+aSbEJwRGxCMDkZff8UjgMRpeIPlSBaZ
   scfETUWf57Z2zvXu0Z7WCol1HOTfJLdOm+fThF+D3LLj3GXEu2pLmGKmZ
   /V3Xt5FXlhk1rjv3/nOMi7Iw1Ld8gZqucrRh9uTMwM3U1XFvUKJRcplZI
   2jyb2pb5g3vOyXnicMZWkGqHSHTaNSjanaHu2hVwlMe8wKD1WoK+dxble
   +VySLkm3rpWWhJmR9HuG0QRpzdrIKVqcNZQt8w98kR47xf1wNkOVgZ9LL
   w==;
X-CSE-ConnectionGUID: ZfFpFdxfSEm5v5ye3lsC1w==
X-CSE-MsgGUID: KuUZ+0f0SuSTbPva1Qd37g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59153507"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59153507"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:28:04 -0700
X-CSE-ConnectionGUID: TralALkLQU+8hrjAbmNTdw==
X-CSE-MsgGUID: JieKwavoTYOry3mIJvdrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208764839"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:28:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utkib-0000000AxL8-2lXL;
	Wed, 03 Sep 2025 13:27:57 +0300
Date: Wed, 3 Sep 2025 13:27:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <aLgYLS6Lr5O2cIhK@smile.fi.intel.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
 <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 05:04:46PM +0800, Haixu Cui wrote:
> On 9/1/2025 8:07 PM, Andy Shevchenko wrote:
> > On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
> > > This is the virtio SPI Linux kernel driver.

...

> > > +#include <linux/completion.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/stddef.h>
> > 
> > A lot of headers are still missing. See below.
> 
> This driver compiles successfully, and I believe all required definitions
> are resolved through indirect inclusion. For example, since I included
> virtio.h, there is no need to explicitly include device.h, scatterlist.h or
> types.h.
> 
> I avoided redundant #includes to keep the code clean and minimal.
> 
> If there are any essential headers I’ve overlooked, please feel free to
> highlight them—I’ll gladly include them in the next revision.

The rationale is described on https://include-what-you-use.org/.

...

> I plan to update the code as follows:
> 
> struct virtio_spi_req *spi_req __free(kfree) = NULL;
> spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> if(!spi_req)
>     return -ENOMEM;
> 
> This follows the pattern used in
> virtio_net(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/virtio_net.c?h=v6.17-rc4#n3746)
> 
> I'd like to check if this style is acceptable here, thanks.

The style is fine. The potential issue (not now and probably never) is that the
scope of the variable in this case is different which might lead to unexpected
side-effects. That said, You can go with it.

-- 
With Best Regards,
Andy Shevchenko



