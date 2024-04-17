Return-Path: <linux-spi+bounces-2395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE78A8045
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF91B21F48
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD313A87C;
	Wed, 17 Apr 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8Vengu4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20753535D0;
	Wed, 17 Apr 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348131; cv=none; b=CtjvCJLyVZoDDFHyl8vyvUn6DtlDmtLSTGEhBoMvJjprH+9OzoDR/f+J3ct9t5tf9AN9xXCS/3H7mLqqZx4b8ZFTVAWvruGH5lkvlKCtjGZiySSmM3lZLzv0SG2dZJXmNV/UueRuXAm9Eo1d8l6A6jaf8xtd7b6hbV2UDlDpM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348131; c=relaxed/simple;
	bh=j5QapwJgxI2kAVpWJ86KsfIFve70wOAB94QAKWyo+8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6dPTt0IF//5duRGvLwheivSoGcvXQLJwGsy/YeATQFqmjTqlEtVTQTJbcsl9ldVtyF8MkXk1q5VUVHmC/A5W+STZZFKimDfLm4zVbedBHLlo+RZuHNetBXnCPUb7MMc3ECC4tQW6BAUZiCK55yMfB1dzo5Vccu0mQGDl2Y5cV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8Vengu4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713348126; x=1744884126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j5QapwJgxI2kAVpWJ86KsfIFve70wOAB94QAKWyo+8s=;
  b=L8Vengu4njo3rMylwMbbH3DvZMilMiZ2UVhCC8iIMg48nLrfYAPxVEXk
   UoTTfZ6DOv+3slCnHvSURc1co1cD2n1kaQuJk8cYKDyOsQVKyBeo70bHV
   vf3K0lDQyctecZNDdhwNMEIF0JKys//1xl975f38B4SGXEfswQQMr8hel
   /8mlYpRY2/IVhtY0CWm8SXNhvDw7O8pCi1YJqJlFEh0ftceOPYqArksTX
   9DyV5fDmJrJA37YQYP2tQQihA560RRR9V6BSjl98Dge58ZXRMd46OKkk2
   Wvm8EhssaL5+kmjstTXrND01RyN3USo5zsN7qQTy+VPpNRfAfC45KtZ4y
   w==;
X-CSE-ConnectionGUID: HOThHCXpR5W9lGJUpmFQVA==
X-CSE-MsgGUID: 0BjlTZ80RDuzEMGz6eul5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19977848"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="19977848"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:02:05 -0700
X-CSE-ConnectionGUID: SXGPqkptROK03BOFiHKbJw==
X-CSE-MsgGUID: V5WWlJZXTUq+1eW/WdLPQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="27013466"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 17 Apr 2024 03:02:01 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx275-0006SX-15;
	Wed, 17 Apr 2024 10:01:59 +0000
Date: Wed, 17 Apr 2024 18:01:48 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <202404171712.GiwLsZEI-lkp@intel.com>
References: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240416]
[cannot apply to broonie-spi/for-next robh/for-next arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.9-rc4 v6.9-rc3 v6.9-rc2 v6.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-spi-airoha-Add-YAML-schema-for-SNFI-controller/20240417-144847
base:   next-20240416
patch link:    https://lore.kernel.org/r/25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo%40kernel.org
patch subject: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
reproduce: (https://download.01.org/0day-ci/archive/20240417/202404171712.GiwLsZEI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171712.GiwLsZEI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

