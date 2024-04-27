Return-Path: <linux-spi+bounces-2560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057478B4851
	for <lists+linux-spi@lfdr.de>; Sat, 27 Apr 2024 23:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D07B21522
	for <lists+linux-spi@lfdr.de>; Sat, 27 Apr 2024 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61E7829C;
	Sat, 27 Apr 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFM4aPnH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272944C88;
	Sat, 27 Apr 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252920; cv=none; b=I2CNckrJpZDYEoagzz2mZsLzzJt0ghKmkXeVw1fP/lSCaNUKMArJqL9vbjRGJwjJIGPZQJe3kte1fnRCElzn7BK6vYBEYGPIm551YFBGMfJJD6MRikbJYndxlsgUKa9iADhM2BA6OqOzVH6YrEBK/JHke31EDpNrQpO11F2CYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252920; c=relaxed/simple;
	bh=Ezl9Swg664hzpWpvtY+dYpBr+BE5q5VXZq9LQDanAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCJe7wv5pL9byHnqBiO8AhvFvpqA7HPguHif9zdQ7qK4KlU0l66rtNvkVPk02WU40wcEY3SgE0TjyZ1SNbbnGCLCHSxZXWUGb5dq5gxBdxH+ygMkKIZzDaHq2RIXkLFngeQUWa+WfGdOK4U9Vdwgdh24rXDo1tK3L0VaAysU45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFM4aPnH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714252918; x=1745788918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ezl9Swg664hzpWpvtY+dYpBr+BE5q5VXZq9LQDanAuQ=;
  b=EFM4aPnHJ7cUJI98lTQGvB0CT+2e0QJ00RzObWsIpWwjS5Fz6+XhqGmo
   NAaBPZB2dtki5QGXR+Weru3tbrmI1xAk7b6T02eHFH28BQRw8/IGcP8VB
   SQIAxyPQKSlPKpsXN3fwxk30cYxpaAL/ond51+4SmvfDGKmfrSxne8tUl
   TJlMJ+Dnan8jzLVRwuIq1jmk+d1bvthgF1TP4oQsCIH1C9nkP16mUzY+F
   sQVLkWCowHjGORhOvnDDVeLPIN7JDXrIRcjx8PBdFpQzZM48mC1ZRQw0W
   F3GgMix8CuQJhfcTNakkL1tO9sY83rsiSobq+S2leXXD6+jcLRBmLrpMy
   A==;
X-CSE-ConnectionGUID: lWbUZTU8QkiXbF7lPuJlBg==
X-CSE-MsgGUID: jq0tTkt/TUq5or2BkgUqKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10175080"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="10175080"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 14:21:58 -0700
X-CSE-ConnectionGUID: 8XMMka/ITnuBRZJMLmKujA==
X-CSE-MsgGUID: P0x56TpiRn+L7nokncEcPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="26152199"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2024 14:21:53 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0pUU-0005VW-0i;
	Sat, 27 Apr 2024 21:21:50 +0000
Date: Sun, 28 Apr 2024 05:20:52 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, conor@kernel.org,
	broonie@kernel.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
	dd@embedd.com, catalin.marinas@arm.com, will@kernel.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: Re: [PATCH v4 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <202404280541.VkXyenQ3-lkp@intel.com>
References: <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240424]
[cannot apply to broonie-spi/for-next robh/for-next linus/master v6.9-rc5 v6.9-rc4 v6.9-rc3 v6.9-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-spi-airoha-Add-YAML-schema-for-SNFI-controller/20240426-164345
base:   next-20240424
patch link:    https://lore.kernel.org/r/2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo%40kernel.org
patch subject: [PATCH v4 3/3] spi: airoha: add SPI-NAND Flash controller driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240428/202404280541.VkXyenQ3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5ef5eb66fb428aaf61fb51b709f065c069c11242)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240428/202404280541.VkXyenQ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404280541.VkXyenQ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-airoha-snfi.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2254:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/spi/spi-airoha-snfi.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/spi/spi-airoha-snfi.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/spi/spi-airoha-snfi.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/spi/spi-airoha-snfi.c:581:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     581 |         default:
         |         ^
   drivers/spi/spi-airoha-snfi.c:581:2: note: insert 'break;' to avoid fall-through
     581 |         default:
         |         ^
         |         break; 
   8 warnings generated.


vim +581 drivers/spi/spi-airoha-snfi.c

   539	
   540	static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
   541	{
   542		if (op->addr.nbytes != 2)
   543			return false;
   544	
   545		if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
   546		    op->addr.buswidth != 4)
   547			return false;
   548	
   549		switch (op->data.dir) {
   550		case SPI_MEM_DATA_IN:
   551			/* check dummy cycle first */
   552			if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth > 0xf)
   553				return false;
   554	
   555			/* quad io / quad out */
   556			if ((op->addr.buswidth == 4 || op->addr.buswidth == 1) &&
   557			    op->data.buswidth == 4)
   558				return true;
   559	
   560			/* dual io / dual out */
   561			if ((op->addr.buswidth == 2 || op->addr.buswidth == 1) &&
   562			    op->data.buswidth == 2)
   563				return true;
   564	
   565			/* standard spi */
   566			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
   567				return true;
   568			break;
   569		case SPI_MEM_DATA_OUT:
   570			/* check dummy cycle first */
   571			if (op->dummy.nbytes)
   572				return false;
   573	
   574			/* program load quad out */
   575			if (op->addr.buswidth == 1 && op->data.buswidth == 4)
   576				return true;
   577	
   578			/* standard spi */
   579			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
   580				return true;
 > 581		default:
   582			break;
   583		}
   584	
   585		return false;
   586	}
   587	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

