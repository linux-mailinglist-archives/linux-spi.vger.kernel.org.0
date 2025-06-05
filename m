Return-Path: <linux-spi+bounces-8368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117AACEC1C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jun 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21EF3AAFDA
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jun 2025 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50380202C30;
	Thu,  5 Jun 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Syzq8ifA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB741E7C03;
	Thu,  5 Jun 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112886; cv=none; b=tNUNlAH1XQS9p6irj5L6ZgziRTB4lOf/2ja7Cs3EypVI34EOfBm12ZI/R7ybGV1xegKjjeZwlspxVqZJNJ/FTlXU2Ziq7PWJbFYpYffBFzkL+SMS5nA1pa0hwkcLKEtkIiDdqdkVnH0JzghiwWqZm39WGgY3yhJa9g/AFjAyH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112886; c=relaxed/simple;
	bh=/44C5CqYHFZ86mXVCKDNXa2qbNMRYDPJOqnauhNVz5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQEksJpEaIldbDCI4k4hCN0Gqkg7O0R9nHZEX/3KjIvup6lNSSlI7wrNvfeA9pITNJLlxsn2Zt0HW/2GdcyFYtKJGjPxJqtS7U5q3+Ic0SDP0Jf9obl48glmrKM3rSEffhQmDKi1b5q5jHtwg+6E6Um8+DrgomsG6vytvihUu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Syzq8ifA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749112885; x=1780648885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/44C5CqYHFZ86mXVCKDNXa2qbNMRYDPJOqnauhNVz5U=;
  b=Syzq8ifAZ/bvu3kA5V8wYppIT57Z9QE6NQx7e1LKulIi7YOPBcY+m7kg
   2XGoD5FNE5qLbz7OJxlvf8ZDMj0yRnrGl/MRGtPiwwIl8BzLrkthWzsIg
   PlRk3UqER+I9ZWnDMVUmDldpktN51kBhW234knwC+xu7dl4pWdVVjwID4
   /9+2KQJVCkEbZc4woZUK+/5T06HW0XyD+/AA57zAa/5hFx8qgDLkWBd+x
   EvNTvP1BpN8N6Vfe7NBhhE1wBE3o51iH0Xt/yQaxVcyyDM6NUvwAu7BX8
   NdKP5zno27tY7QElVzqyNORWo2HPd1/N3Xouf/NQYG/vAD2PDsQoMhgW3
   A==;
X-CSE-ConnectionGUID: NCewpJY3QMWEZoIt1EXlHQ==
X-CSE-MsgGUID: 7x7ai13YQu+A7+WPafXbsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62576316"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="62576316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 01:41:24 -0700
X-CSE-ConnectionGUID: 981nQ/Z4S8CqG8gZXQhDKA==
X-CSE-MsgGUID: Gq/ntPpHRQaRWTfUoYYq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="168621842"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jun 2025 01:41:21 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uN6A3-0003v3-0Y;
	Thu, 05 Jun 2025 08:41:19 +0000
Date: Thu, 5 Jun 2025 16:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH 2/3] spi: Add Amlogic SPISG driver
Message-ID: <202506051609.8GLrHoaR-lkp@intel.com>
References: <20250604-spisg-v1-2-5893dbe9d953@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604-spisg-v1-2-5893dbe9d953@amlogic.com>

Hi Xianwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 57cf46cd1fe351846e1b065ca9546eef66675ecd]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-spi-Add-binding-document-of-Amlogic-SPISG-controller/20250604-154302
base:   57cf46cd1fe351846e1b065ca9546eef66675ecd
patch link:    https://lore.kernel.org/r/20250604-spisg-v1-2-5893dbe9d953%40amlogic.com
patch subject: [PATCH 2/3] spi: Add Amlogic SPISG driver
config: microblaze-randconfig-r123-20250605 (https://download.01.org/0day-ci/archive/20250605/202506051609.8GLrHoaR-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250605/202506051609.8GLrHoaR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506051609.8GLrHoaR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-amlogic-spisg.c:929:24: sparse: sparse: symbol 'amlogic_spisg_driver' was not declared. Should it be static?

vim +/amlogic_spisg_driver +929 drivers/spi/spi-amlogic-spisg.c

   928	
 > 929	struct platform_driver amlogic_spisg_driver = {
   930		.probe = aml_spicc_probe,
   931		.remove = aml_spicc_remove,
   932		.shutdown = aml_spicc_shutdown,
   933		.driver  = {
   934			.name = "amlogic-spisg",
   935			.of_match_table = of_match_ptr(amlogic_spisg_of_match),
   936			.pm = &amlogic_spicc_pm_ops,
   937		},
   938	};
   939	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

