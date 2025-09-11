Return-Path: <linux-spi+bounces-9987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB8B52A74
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483A01BC8DD6
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F529BD9E;
	Thu, 11 Sep 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9m7gMgN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0629B8E8;
	Thu, 11 Sep 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576936; cv=none; b=RZrmpwf2IolLEfayW7ZWQNie/A5ovFjjtHj/aDj0iGA9oG/TrZK9dTBl7N45GBjyXhUg1QM3UuiL2VmLnVFqvD8s3jjIIC120Cqu5VrtZslf46qpFP02mB+X/Rz5WJLh/MihJcoLQp/KU8UxW8zmJKPGK9uNV+pgyj5eCJa5DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576936; c=relaxed/simple;
	bh=GVFo1kkBKEsPHJOvbjim7jezaF6LjLLFPCd7At02oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbHimQRyXBLWoHr+GOHQM2lU6vvEykba3AqtzNn8KfIB6ZNS/nNtl7pdoj9eIaidhB6g5sWk3Y4SD/55BHGOdMEedfWV55W5FpGBDlsSt4UmL+K4mCFolIQj6S8cn+la0dQEp9bz9+q5594zLZQeRB8Bxzi92JkB7N+RmthBZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9m7gMgN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757576935; x=1789112935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GVFo1kkBKEsPHJOvbjim7jezaF6LjLLFPCd7At02oz8=;
  b=X9m7gMgNkx8liCnhyVV5lThNeLQ//2wjzLmXbRQBbMO4nUgGc2v3RVCb
   ESsa1x5Go9PWeXUg6bQ4wD221hB0ZwY+NjI2Hef+SOQ54GoWlTvdsjcIv
   0+oA8GZEvuoLq0+dYyEi6U1GKBJr6pCZnwTx8TY2MPD7IvoniEmHGOqME
   KWHUY0K2drlkm/WR3H/J2vkns3BlT1hU5f2Wp78jCIoAiSIFr2bbBGLgp
   N3FpHaNHmhIH1+S3Ty6IwL+mCHO7Ywu9gyPFiPYQ0vEpPzYBZ6RlEHOO6
   Ms/XPUUQteBGwP3KS23uwsKckcw4l8ax6j7Yo8jJ2eZtO/KWynbegT1rJ
   Q==;
X-CSE-ConnectionGUID: IOgEOkyRRO67DAlpw9s+tg==
X-CSE-MsgGUID: f+iqVX6PQMCtzfuBIbZPiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59974622"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59974622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:48:53 -0700
X-CSE-ConnectionGUID: J9Nv+4YtTNSxO55M48ZoVQ==
X-CSE-MsgGUID: 9MixVzbQQjW7yZnMLMRJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="204612371"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:48:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uwc2x-000000022PY-3Jay;
	Thu, 11 Sep 2025 10:48:47 +0300
Date: Thu, 11 Sep 2025 10:48:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <aMJ-32RkzRuUQ_CP@smile.fi.intel.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
 <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
 <aLgYLS6Lr5O2cIhK@smile.fi.intel.com>
 <b9e9b4e5-7004-471b-a067-b6bacda2a0ca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9e9b4e5-7004-471b-a067-b6bacda2a0ca@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 10, 2025 at 11:51:03AM +0800, Haixu Cui wrote:
> On 9/3/2025 6:27 PM, Andy Shevchenko wrote:
> > On Wed, Sep 03, 2025 at 05:04:46PM +0800, Haixu Cui wrote:
> > > On 9/1/2025 8:07 PM, Andy Shevchenko wrote:
> > > > On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
> > > > > This is the virtio SPI Linux kernel driver.

...

> > > > > +#include <linux/completion.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/spi/spi.h>
> > > > > +#include <linux/stddef.h>
> > > > 
> > > > A lot of headers are still missing. See below.
> > > 
> > > This driver compiles successfully, and I believe all required definitions
> > > are resolved through indirect inclusion. For example, since I included
> > > virtio.h, there is no need to explicitly include device.h, scatterlist.h or
> > > types.h.
> > > 
> > > I avoided redundant #includes to keep the code clean and minimal.
> > > 
> > > If there are any essential headers I’ve overlooked, please feel free to
> > > highlight them—I’ll gladly include them in the next revision.
> > 
> > The rationale is described on https://include-what-you-use.org/.
> 
> Thanks for your feedback and for pointing me to the iwyu guidelines.
> 
> I've experimented with the iwyu tool, and while for spi-virtio.c I noticed
> that it recommends header that is not directly to the code - such as
> vdso/cache.h - and occasionally suggests re-include header like
> linux/spi/spi.h that is already present.

> iwyu is a power tool expecially in application-level development for C++
> projects where header dependencies are more straightforward. However it
> seems iwyu may not yet be fully suited for analyzing Linux kernel due to its
> complexity and conditional inclusions.

I was not talking about the tool, yes, this tool is not ready for Linux kernel.
Jonathan Cameron played with it to make it useful for the Linux kernel project,
but it seems the work is stalled.

> Additionally, I’ve verified that the driver compiles successfully with both
> gcc and clang, which indicates that all required definitions are either
> directly or indirectly resolved.

The IWYU principle is against the includes that indirectly resolve types and
APIs. The problem that some headers are included in others and that relation
is guaranteed, but we do not have an official list of the guarantees, so this
is a tribal knowledge.

Basically the developer should know a bit more about the Linux kernel header
organisation to fulfill IWYU. And this is currently problematic.

> I appreciate your guidance and will continue to refine the patch with
> clarity and maintainability in mind.

-- 
With Best Regards,
Andy Shevchenko



