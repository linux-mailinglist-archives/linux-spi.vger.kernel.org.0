Return-Path: <linux-spi+bounces-3264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5708FD81C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0021C2232D
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B8013A897;
	Wed,  5 Jun 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDcTStJ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689173C28;
	Wed,  5 Jun 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621696; cv=none; b=ei8Ej8b8lqDV9sSKuR+R1XPYjlXwhArBczI3fLxH7FJOtwLXRq21lmB1IbhBvahNqEpko1J69qjs+yYTyj6WQL2P5rAECwk5oIWwNmG+yLfooDGWbs95sntxX5yLIKbBICv78SkPXEnMAm7vBm0APwzYDXrdVoFjv7NYmVosz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621696; c=relaxed/simple;
	bh=EuRJsCLwPoNelYVlabKWIXl87KOBUOtFbHaWsPbiAm8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeN8KWqdQJULXDDnBch8NDhK7mh0BIg+WxAIyPXRW4QQmNHEs9YvL/Oy5mMALhC5xVragBOEfDrD6b599JGlF9J5rn6g5ytQiWOPv2NmUhWJbzzwoMOEFZHdhfitxAYxlpWM+uTQ4+qlPqHKOuwbzl0C+iKMXHoCrmPj1SyElkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDcTStJ3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621695; x=1749157695;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=EuRJsCLwPoNelYVlabKWIXl87KOBUOtFbHaWsPbiAm8=;
  b=NDcTStJ3M2EU0NCZPR/MCZ8pBqLI6n8q1NHzWD/m5kacMdvulkkayaZ5
   WXRsNWBZ35ybWI4IodO0udYNhsFDlnX2HHMVR6By00DbTiSc7uxrKr3dH
   AUR+X5uLxR1G9JQQGNs81urPc++WsoKLs11DMC8WEMC6qYoAlFhNtN/gh
   0D+HqAnt25vrEZxbnMZbIrYbIVJi6FDm/KRUQ/80dkpOUdRADkSNS7WRd
   R7J3J1XwRS8ulRB+T+WOkLz60og04jzczDSiLVVHWK3ZdWRpKpA326YHK
   kWtBfxremHds7NcKW20NiW/bajozN1et/8qchJBvz5CGJZmyvYQOTVJ31
   Q==;
X-CSE-ConnectionGUID: ou0SP6bbTMOrELft5+islA==
X-CSE-MsgGUID: cm3/8il+Q2m/zvu3quONJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14003565"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14003565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:08:14 -0700
X-CSE-ConnectionGUID: LnmSXtnTToGE3o9TkT1HqQ==
X-CSE-MsgGUID: ZKDdLtubQbCydMbiQMGujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42649154"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:08:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExrf-0000000Dy52-0xXz;
	Thu, 06 Jun 2024 00:08:11 +0300
Date: Thu, 6 Jun 2024 00:08:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Refactor spi_stop_queue()
Message-ID: <ZmDTuqMTR-KiUyVO@smile.fi.intel.com>
References: <20240510204945.2581944-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510204945.2581944-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 11:49:45PM +0300, Andy Shevchenko wrote:
> The refactoring makes code less verbose and easier to read.
> Besides that the binary size is also reduced, which sounds
> like a win-win case:
> 
>   add/remove: 0/1 grow/shrink: 2/2 up/down: 210/-226 (-16)
>   Function                            old     new   delta
>   spi_destroy_queue                    42     156    +114
>   spi_controller_suspend              101     197     +96
>   spi_unregister_controller           346     319     -27
>   spi_register_controller            1834    1794     -40
>   spi_stop_queue                      159       -    -159
>   Total: Before=49230, After=49214, chg -0.03%

Hmm... Other more recent patches went through, is this lost in cracks?

-- 
With Best Regards,
Andy Shevchenko



