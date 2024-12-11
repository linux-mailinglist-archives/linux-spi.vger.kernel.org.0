Return-Path: <linux-spi+bounces-6002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFF9ECAC9
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40241188762E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97E1FF1B0;
	Wed, 11 Dec 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgRdTJpx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A18239BC5;
	Wed, 11 Dec 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914788; cv=none; b=PSjnuKbSPRy25f0oAM8wevKss3R3E1Q7ukt6AdmuFV+yU8V3m8nRKikjPQKRCZQEphG0vkKH/HZvCrLmvQ/w0bDg/fbJ28bGiu0DgoDLyP6MzNrGDCUBan96fmD0oEQPvpnFHQ19BngqTsrkbBKTKOOQIoACWy7Idc24b4YyEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914788; c=relaxed/simple;
	bh=Pe4oCHbl1yzjp86WYi9eKFyVzUBDM0RjNx5Xc5LRh/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAufaA0gyFkls24zyHptiDk0WTYSCfAe7Jx0gclKlWLAhdQBBqQ2E3zmtUEZKDOXDecJJXvJkG8FUGdNAO/V37K8esSSRQbdSRxQoAsSAfFqNHwZdxZBPz+Umwwn7UIAMiy9rMMOy38vO2VvXlxjVHfCTCV8JKGUZCWsucCU8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgRdTJpx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733914787; x=1765450787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pe4oCHbl1yzjp86WYi9eKFyVzUBDM0RjNx5Xc5LRh/w=;
  b=OgRdTJpx8kIj7Ebnwetm1JC0CxpnOA7Gb0puxiOZtZuRJdGr44GSsGCi
   xwXMV+8+JILrnmeLANPRR/VmQxpPlztz2DrxkWdog99SG8GLRRfT7Tk3X
   h0oC+83mU6mfj7ZF4+wzm+VI4OJopYxOwx2eVW2METmV36KqMXAESspi8
   fD1f92CllbzDcMi7SYhIBcBW5f/3VdcHCDKFnQpfpWYa//SyFxJB2DcgD
   w4Ge1i3wsWFavrG0fs7mstSSmo1CNcYIMpJLcWZQEl6pnVAKjH7JD8v8d
   VkgEXe5RCVPOyiAimhj0XBy8/DH3IlwwnQ6YZ0Bka0pTrKffdLEDhjfip
   Q==;
X-CSE-ConnectionGUID: hYDIrpyrThqz2N0m29uI5Q==
X-CSE-MsgGUID: fM5/TddST9CZHvQHUu3cEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34428971"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34428971"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 02:59:46 -0800
X-CSE-ConnectionGUID: PsvhwuFIRWq8wuSSlyeMTw==
X-CSE-MsgGUID: pUA8euRQTKqnOgF94p6CiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95582073"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 02:59:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLKRS-00000006V7T-1HsB;
	Wed, 11 Dec 2024 12:59:42 +0200
Date: Wed, 11 Dec 2024 12:59:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] spi: Unify and simplify fwnode related checks
Message-ID: <Z1lwnqGZsO_x8h0k@smile.fi.intel.com>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
 <fc015f10-9780-4e2a-9dcf-de7e4b253be2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc015f10-9780-4e2a-9dcf-de7e4b253be2@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 11, 2024 at 09:42:33AM +0530, Mukesh Kumar Savaliya wrote:
> On 12/8/2024 9:33 PM, Andy Shevchenko wrote:
> > couple of cleanups on top of recently added change.
> please add what exactly cleanups done ? Recently added change is not that
> something someone would check as part of this patch.
> Description would be helpful.

But each patch has its description. Or I didn't get the request, sorry.

-- 
With Best Regards,
Andy Shevchenko



