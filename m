Return-Path: <linux-spi+bounces-5220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB799BD1F
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E5B281603
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CB4A24;
	Mon, 14 Oct 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PassxRw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7E4A2F;
	Mon, 14 Oct 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866427; cv=none; b=NSn4h1b9rMZ0KOLJ0/Gzq8+IJ61qzcE7I9aT3yIqKUEl3NNDCt05zqdCHyLlN7JPBnVVB/Wm3/AOcrX1t+A5qoWC1H/JmSCN9kmfI7kg7Za5D7iCFFkT/PTpM5RFbkcN19djnd0z+QKu8WEzzIm3730qk6UbokR1IbnMVSNcTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866427; c=relaxed/simple;
	bh=Dvpf7uGb45guqEjttgIF5nEh7hFJwy6SPLIRx7aPrJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEYv6LZqkNmjG79p/adDwdAkbUSgylQ0fnvnOQ4cFFPY7VEEhswwsFOnjNcwJN5BXV97sFeVQ+PzKs3sVDNyrCtlk7DKU+B/HZ8P7/7NRFWYF1hrhHun9Xzg7VWU8HdAxPHrNGpNNJG8eutifYC24Gbzt0qUnx1E/GOfRHYvl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PassxRw+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728866425; x=1760402425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dvpf7uGb45guqEjttgIF5nEh7hFJwy6SPLIRx7aPrJE=;
  b=PassxRw+IeDH0Q3o4SNRWm536EJfI7AuHhc+KZoGZWi2wjwUP0q+qewk
   WCelS8pbzUIgDNhvWSUXP64OAAYAKJh64kMB/Wz3AH2oEN65nW+Yzw0/V
   i5g9GCKcrZI7rrxb5oI0vGvdv2KzDQmwFjt3W74jvghvuWSyvpzxlFVsj
   jVAshkO8slipcRgSdEdgX7eU3NxM++awe2Eo9IhPn3L33ILLcMJYsEafE
   yJ6FM0QIZGe3B2WKURJN4iwxRmKOZdry0ZXT7b6g/PlgVHFIdPT+c1soP
   +5Yvwh160hrunJy1bfatnBhubYz1CHev/PMrOSDdAphvWTnTrXp6fl2TB
   w==;
X-CSE-ConnectionGUID: PZEM4B5LSdGF4Ujvdn+kqA==
X-CSE-MsgGUID: jnmwu6V1QAyGOTe1gMNd0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45677351"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45677351"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:40:24 -0700
X-CSE-ConnectionGUID: GhojqkraTBuCXQBp+uJ35g==
X-CSE-MsgGUID: TtZcJkDhS162jIvKGBQPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82207412"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Oct 2024 17:40:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t098F-000EnP-1o;
	Mon, 14 Oct 2024 00:40:19 +0000
Date: Mon, 14 Oct 2024 08:40:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	tsbogend@alpha.franken.de
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 3/3] spi: spi-mem: Add Realtek SPI-NAND controller
Message-ID: <202410140710.qz1xiOo0-lkp@intel.com>
References: <20241013223907.2459099-4-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013223907.2459099-4-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next linus/master v6.12-rc3 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/dt-bindings-spi-Add-realtek-rtl9300-snand/20241014-064017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241013223907.2459099-4-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v3 3/3] spi: spi-mem: Add Realtek SPI-NAND controller
reproduce: (https://download.01.org/0day-ci/archive/20241014/202410140710.qz1xiOo0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410140710.qz1xiOo0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

