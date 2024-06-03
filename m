Return-Path: <linux-spi+bounces-3207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCD8D8A8D
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 21:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E15289906
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689613A878;
	Mon,  3 Jun 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH1W2WnO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299F20ED;
	Mon,  3 Jun 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444463; cv=none; b=CDs+59+Y+XcQi2FP8wwiwsxGoIa2VPct9uB2uDnTeApbBosWLzh1AbdaMr1P4iAf3qrdz7A3sgjZ+Gpp3X0ny/1kd1ecAY9+olhRtwnpwSTVi4gNlobV4SLj6BF+3QgbCk1l/uR1orn3h0exnMVh5RIhUed7l46MEvfqxWC2ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444463; c=relaxed/simple;
	bh=e5m7Kn4ioMIeYs9Jnk1vXY28Wu0K4/ZqmMFp2F5Q8Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEFgloF33KLFKjYOI5mkG660JMztbmSzZsIzSdOIspP/15Tjchu4usaZR6nPc12rlyzI4g5wL92UgbkYxcp4L+iNn8dWT0VqVVdy20WE/Y+AGrT5sbzlybXp5Hy6bKyZrNBcjGENErkj6TTOCbsmOdfDSJJNyF/lh9fBY/kUXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH1W2WnO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717444462; x=1748980462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e5m7Kn4ioMIeYs9Jnk1vXY28Wu0K4/ZqmMFp2F5Q8Wo=;
  b=ZH1W2WnOiSUG6H8YXRFqChdMKKUf25cBMRxptIhpz2gf8y17TJ72Jq8J
   ozfVyvtRcGIPKHRA3gkHCuqkcPTse3p6lqOiGHDnZuV4NB/70bvTWYTp/
   gIU3y9akbzm69bHDqPwNH/axVJm2rNNO9Sq9dhMaoYytC/QVHv7/1a4Qr
   Vt/0725xjEkAd/Xs0SOMLLz+EQEGXNsKNxna6gckCqkxVM9YUgnKksgWa
   GPuG4UnS+OpITVPYt1PjPxEz5vDeF11p0EZlZUrgx7xLzTpE5Xy3DHOTR
   jD+3tiayM4lTO3jmxdtOquXI8unIDEYFG1vBl387JSE3UsG7+GPwElC8g
   A==;
X-CSE-ConnectionGUID: oiPXffbvR+KlwcYrYjmbtw==
X-CSE-MsgGUID: zL6V4iOfSJ6c/FnZShk71w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13707120"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13707120"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:54:21 -0700
X-CSE-ConnectionGUID: 1go9N50LTaC9DlhD1lLMQw==
X-CSE-MsgGUID: Q2PdtJQET1GkYEqYGUH3Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37612029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:54:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEDl0-0000000DNN9-1Wh1;
	Mon, 03 Jun 2024 22:54:14 +0300
Date: Mon, 3 Jun 2024 22:54:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
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
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v1 0/8] spi: Rework DMA mapped flag
Message-ID: <Zl4fZq-zj5v9EI10@smile.fi.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <7c54ed90-538c-4b32-91f4-85bf6c27cd6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c54ed90-538c-4b32-91f4-85bf6c27cd6c@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 11:10:54AM +0200, Neil Armstrong wrote:
> On 31/05/2024 21:42, Andy Shevchenko wrote:

...

> I applied the serie on next-20240603, it worked fine:
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thank you!

-- 
With Best Regards,
Andy Shevchenko



