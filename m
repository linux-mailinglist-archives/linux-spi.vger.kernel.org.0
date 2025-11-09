Return-Path: <linux-spi+bounces-11131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B332AC441C2
	for <lists+linux-spi@lfdr.de>; Sun, 09 Nov 2025 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6C34E23BB
	for <lists+linux-spi@lfdr.de>; Sun,  9 Nov 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10782FD1B0;
	Sun,  9 Nov 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C05PJvU7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D81CEAC2;
	Sun,  9 Nov 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704190; cv=none; b=XS7LKNqlCROKVnxf+bMjwGx5M5xXa0HzILgehwViAmGuTyxp+n8LD4p96bxOzFIh+Ofaf6YEuhftl8vPJt2hLkfgLYFyrtqB8xCbjqlIG/rTnelJa/sWBwJgD7X7ArdCdWIgs1ZGhQvX46J9Lql3Jri3iP01w8jgBfKvLVHjviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704190; c=relaxed/simple;
	bh=rlVB5XLQ0rbdMPCKcB5gVjZkxx2BEyoaU0NG6agkKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmNyjVv1qGq3F3cB2PYLaosJMmaVst7NXCladFzazC6FYqWwmfVhiTiY64IIakHMd2DM3urxd77FEszr0hqWoScn5jRN1dgPvnFWQ3yGS6U2z71/8zUP1xSuB1xSp25K4L5qkSFxiORb6lVoDgbsN7wAI3qdXaGymzPsaj62aM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C05PJvU7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762704189; x=1794240189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rlVB5XLQ0rbdMPCKcB5gVjZkxx2BEyoaU0NG6agkKrs=;
  b=C05PJvU7sIGge9LOZxQ4bf2ybA42iHsd3sn6ltfFhlwgm7R6nWsHaC4k
   2Nyfazk5HYTlkLll+EkbyzDMOQD/Llv1SjifiZvifwjiImQ3zIvIS3+YU
   QVDP+55FL8IffgbQeenf9Uw9JZAoZQ54Tx5UJDS/UPDkfHJCZXl9GsOT/
   DhJkXUM8iCGLjYGaLKZefGNojXRUh9wUtQQd4X3RKx0/DigoTn39wkNww
   hj+3gcKi34kCWgGc1ORu2bhmqcKzRWZurlaPb6TcGi8RhRoLvTcu/pX9V
   Z5Y3vPruhNcSZRHOOdi6ikuCpOiGM8/yMl7A7zyqWCCWJ/13E/OK308eW
   g==;
X-CSE-ConnectionGUID: ntb40sPVSjCS2UJlOO+Rrw==
X-CSE-MsgGUID: nNTLGYFiQV6WkyD+wGzhMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="90244876"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="90244876"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 08:03:08 -0800
X-CSE-ConnectionGUID: fLfCho4BRh6XuPxq350yqg==
X-CSE-MsgGUID: wKIFVgHiR+abDq0LZz5A9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188119523"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 08:03:07 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vI7se-000000073oI-3pYs;
	Sun, 09 Nov 2025 18:03:04 +0200
Date: Sun, 9 Nov 2025 18:03:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] spi: Add TODO comment about ACPI GPIO setup
Message-ID: <aRC7OIpRS5DXRzYv@smile.fi.intel.com>
References: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 04:53:39PM +0100, Hans de Goede wrote:
> Add a TODO comment that ideally the ACPI/gpiolib core code should take care
> of setting GPIO direction and/or bias according to ACPI GPIO resources.
> 
> If this TODO gets implemented then the acpi_dev_gpio_irq_get() call in
> acpi_register_spi_device() can be dropped.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



