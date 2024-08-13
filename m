Return-Path: <linux-spi+bounces-4179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC24950C4D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D161C22A06
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EB01A38EA;
	Tue, 13 Aug 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTSi6luC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0E19D8AC;
	Tue, 13 Aug 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573758; cv=none; b=C74oENQGUbjRXnnWOk+ZhSBW7wWmvMyAYSjxNs53zzgLSkKgVSWJjbgEBUJ/StYnSwkrnU2ssP9FKoJDAA5SUedGpXNtoL1p/EFNC9Y5FFo3G2AUZnj4u7eNTjLU93a9yrBWc4Uu/qtqm1KEuAZtEmoTgeV+mekwHx2oKZPnzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573758; c=relaxed/simple;
	bh=7auds1cADml3EgTlOMSvp2UKdkYARksA969CZ+JXqW4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osFSvy6bj4ArYUWPw/s7O1QEeBwGBOH/5AtHa2BQgoSRt8jBT/xduGF/Ov6tJUyKBDftuRev9S/aVNb6fzFGVwoPCjRaAjNgzA5vnMoYmgwFavznltONzyOpPy8iH8I+DWezx8fmEIVF7/dZEEmz9XdRWRck8Iz0NkW2OiQ3ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTSi6luC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723573757; x=1755109757;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=7auds1cADml3EgTlOMSvp2UKdkYARksA969CZ+JXqW4=;
  b=aTSi6luC04c/DHiu2wSzg1Ob9UNz+0XTfq4335tL5sOJRe3FG6zcW4Yq
   d9N/MRk9Ho4ltDJqau/OQoD2Hv603Bz3ImG8xvZjtt8q3FfO2OpLokSEI
   b+tGhDtCBq26t5ivnjrx1pRkcCOOvzkkoUKxgWdBobpT//bbMJJKyuonl
   ksQEFAuNMz9g6MXE0QWtso6VMLPw+zxqMTOa1kFUgLJJDgO9Xhn5pgT5C
   Hv8rVi4bBZEwRhkuVYo9bTB2b6vImoDfpG/jScO8w7SmhE0woOCIChHBV
   pu7GCyTTTjBwkDNge6Zcm/Ax1tH2yVDteWgErxQpHXJ+rh4jfm8uOCr/S
   g==;
X-CSE-ConnectionGUID: iqQsqVMiStm0g6QE/Ab8PQ==
X-CSE-MsgGUID: yKV4MckjQra3BgKqWHnjRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25549194"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25549194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:29:16 -0700
X-CSE-ConnectionGUID: jeudTc1KTxyWleXHm4L0aQ==
X-CSE-MsgGUID: pF8W2tlCQdKJCrZgl0Xp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63601984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 11:29:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdwGd-0000000EwRM-3xGd;
	Tue, 13 Aug 2024 21:29:11 +0300
Date: Tue, 13 Aug 2024 21:29:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: ppc4xx: Avoid returning 0 when failed to
 parse and map IRQ
Message-ID: <Zrul97x0dAt6xsWB@smile.fi.intel.com>
References: <20240813160220.2357338-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813160220.2357338-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 07:02:20PM +0300, Andy Shevchenko wrote:
> 0 is incorrect error code when failed to parse and map IRQ.
> Replace OF specific old API for IRQ retrieval with a generic
> one to fix this issue.

Scratch it, it has the same issue and it seems it predates the mentioned patch
as we need to return a real error code.

-- 
With Best Regards,
Andy Shevchenko



