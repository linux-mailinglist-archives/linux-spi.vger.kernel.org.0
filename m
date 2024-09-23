Return-Path: <linux-spi+bounces-4927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7697E793
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 10:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDB1281967
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F918C1A;
	Mon, 23 Sep 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB87Grra"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAD55E58
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080319; cv=none; b=d58B1v06tiVM+sY1jBZfhZEQ6wYQ/Vy/miAnofoXXPhq8vOA5CdD2bRuXT+w/A4X26uvw2k8M6SMoOjgZ34kXwjA/7reJw2uoYjV9LXWxS05yCyRHDI51in4dD1cWBNqU+x6Wi7QrErHoC6DP/zgorNAjswfJP30gQkjILkd7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080319; c=relaxed/simple;
	bh=sqJPIPcDtwSFk3n3WB0UPJAdfYcKynV4nzk4gp3uHb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BaSJFfMs3iodcZMpu9MR537YjPAsz1gEMu0Obo5qgy9oOAbW8jD7vDdz3J9d36KzQBsK7bn1ibvT9G6GrsE0rBHT7ZMd0c2K9KtXKHlTxLJ6uXzbqg5Vkvbcg7EtbZyK+IuvGd9Q1OYmcilXx4swAiPSrM0YCwAm7+vq6M42kUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GB87Grra; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727080317; x=1758616317;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sqJPIPcDtwSFk3n3WB0UPJAdfYcKynV4nzk4gp3uHb8=;
  b=GB87GrraJX3mhr5pTam241w2dVAEiPUvekPv+iNPvrTvzFQYu0Tf4wNr
   pkQoUW0oC1G0PGkFqfFb6jyZIVWq7SyeAfwaLLRmKuPMjAeq+VWHeQQzL
   QyxpAOJTP9Eb/fwTQFtf3+NudVRm4+uRj3kqXXB5qy6kX6p1AnmHVxOwX
   Dq6Q5zW44MLnEt6DMXMdpQquOkWmdXr3f7N706uSCV9LmzIYfbEqNWgDQ
   XdqSI/9uIjBCceI67LyRrkngozjv9uaaVNjBdIvvxayIrbcZiDAyecNqA
   geZC9aJnUFAiPYbSsyg1uqBitEwqova0dKswL5wFph3OYqiHGY1FnGkY2
   Q==;
X-CSE-ConnectionGUID: m3LbDJcpTmiUbtR9gTazww==
X-CSE-MsgGUID: 3eTQX8VHScW2uoTvjf14rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25495838"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="25495838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:31:55 -0700
X-CSE-ConnectionGUID: kaED5uSYSDyvRVnZf0x5Hg==
X-CSE-MsgGUID: OhZCHVJARfiyPdVktkM6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71269153"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:31:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>, Mark Brown
 <broonie@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, Oded
 Gabbay <ogabbay@kernel.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>, Alexander Usyskin
 <alexander.usyskin@intel.com>, Vitaly Lubart <vitaly.lubart@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v6 08/12] drm/i915/spi: add spi device for discrete
 graphics
In-Reply-To: <20240916134928.3654054-9-alexander.usyskin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-9-alexander.usyskin@intel.com>
Date: Mon, 23 Sep 2024 11:31:45 +0300
Message-ID: <87ldzi7oum.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 16 Sep 2024, Alexander Usyskin <alexander.usyskin@intel.com> wrote:
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 39f6614a0a99..b9d4f9be5355 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -34,6 +34,8 @@
>  
>  #include <linux/pm_qos.h>
>  
> +#include <linux/intel_dg_spi_aux.h>
> +
>  #include <drm/ttm/ttm_device.h>
>  
>  #include "display/intel_display_limits.h"
> @@ -315,6 +317,8 @@ struct drm_i915_private {
>  
>  	struct i915_perf perf;
>  
> +	struct intel_dg_spi_dev spi;
> +

Sorry, late to the party.

Can we make that struct intel_dg_spi_dev *spi, drop the include and use
a forward declaration for the type, and allocate dynamically please?

Ditto for xe driver.

struct drm_i915_private is huge, i915_drv.h gets included everywhere,
and there's no reason everyone should be able to look at the guts of of
that member.


BR,
Jani.


-- 
Jani Nikula, Intel

