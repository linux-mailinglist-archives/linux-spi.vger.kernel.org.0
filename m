Return-Path: <linux-spi+bounces-3206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4338D8A86
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C3A286398
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09330137748;
	Mon,  3 Jun 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ju9AruhJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D920ED;
	Mon,  3 Jun 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444424; cv=none; b=TsQGENIepWTbAfq+5HYrsuOYaqO/8vD37D9GXRosZG4QXIJg0wSvEmp4FW8FbG5GEqnKTNyqpavRuNcLicCVo7j5URmNlUnEYpQHLZxjoVCC8vJ4LU7hIorIvYRfftrrWY2+q0/fmcucoxQIOg/ZgNTZTL1GKoajxLcO/Hm/o84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444424; c=relaxed/simple;
	bh=Orq+SyElfsbYvHcrO7XyS2T+sd6zoBkyydwM/TlmYmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRbz0hSeX4kPbar/7XbFIffjaVTwaqvyHA4CZFYVR9P4+EmwFUeK75zmaa7oZgv/k486dAyhZp1FjLsom/476yyixPBVQAD/hJV+EBepqAdWymETmfIpUF+8n8JMXAU9YFOmTrqaeIZ7MQYr8qmY8e/sISMVTwhSE+b7GWHfctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ju9AruhJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717444424; x=1748980424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Orq+SyElfsbYvHcrO7XyS2T+sd6zoBkyydwM/TlmYmM=;
  b=ju9AruhJbx2zIQ45NRv+wtYVY9fwXd02zPuXJ5+B/vsxKkfbLY1ufgLe
   qiOCBKwIbzbdvI/iKe3iOuL1wzMeOE/WW13oNiKj84dlfC/wWALgIikqv
   pXEEd+htLuYm0Lp+yQJ2fAEI5B0aj8vJlsUUL58FboUNgUGPm0criJds9
   5wsjLB2LbTMjlqFOCXtAjEKIFD2jSG1QGw25EBaca53R20ezXhEZLEyUV
   kdnAr6/8ZJbRycEhqbScpTWvKA09Yy7x890M3DtOsxmVNcPGvuY3wiTOE
   rJm6WNoX2IQBVJF78dbhsGnVF+IoEN9YvInDdfUmqAhETdc9luLjSn4Kr
   Q==;
X-CSE-ConnectionGUID: evtM6oD3QSaeXKZ829+lQw==
X-CSE-MsgGUID: vc92k8mhRD+OE192FTW+Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39362986"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="39362986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:53:43 -0700
X-CSE-ConnectionGUID: ki/+eLWPSsKFTFuiPTAY8Q==
X-CSE-MsgGUID: JzQLYm4VRqCidLoh2MmWAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36917327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:53:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEDkN-0000000DNMT-2sGD;
	Mon, 03 Jun 2024 22:53:35 +0300
Date: Mon, 3 Jun 2024 22:53:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/8] spi: Rework DMA mapped flag
Message-ID: <Zl4fP8Jl4PXqNbBG@smile.fi.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <e9f6e8fe-7147-4caf-a7fc-e612069c2eaf@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f6e8fe-7147-4caf-a7fc-e612069c2eaf@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 03:49:04PM -0400, Nícolas F. R. A. Prado wrote:
> On Fri, May 31, 2024 at 10:42:32PM +0300, Andy Shevchenko wrote:

...

> Tested on next-20240603. No issue noticed on sc7180-trogdor-kingoftown and
> sc7180-trogdor-lazor-limozeen. So,
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thank you!

> Although patch 5 (pxa2xx) didn't apply, so I skipped it (but it's not used on
> my platforms).

Yeah, I just commented on that, it appears that I have based this on the
previous driver cleanups (it was published a week ago).

-- 
With Best Regards,
Andy Shevchenko



