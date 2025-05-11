Return-Path: <linux-spi+bounces-8064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA579AB2823
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74596188FBE4
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C362571A7;
	Sun, 11 May 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOFIpSRT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF02566EB;
	Sun, 11 May 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746965805; cv=none; b=Cw8SEQjEIggBkiCSOktuefa10iADIy1XRIVKy4h51CVutSJ+x6ndRpE1Cqjc//jjLaPDLgfC+JeHRe3+GsmQWwkXGaNVuAC4+NEf2+F3VxdgeD4GaKRSPS4dnl6iJhROpoDKnlM1r4PCB54AcZZ/0U4AZprduGrL7+wWbbRQ+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746965805; c=relaxed/simple;
	bh=tYA1/HJP9Miv416bUCNmKbgIuyi/j81KBKdK8q3ObEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuUlNqqncXrWByGbmYm1PGlypCK9UCjgwNjYNXt9aPRQ51tCkF5q+yJAgaFFFXlHw3bgT7HcIv8Q6O+16WyK1TvEADRA9dwJJUo4fMr4/pQ/vS5j84MQHiwXtb4o6ZNefIYxx1Z0sjzJbzCyQVoFJDHLGb7cuR5Q7d2pCGBA2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOFIpSRT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746965803; x=1778501803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tYA1/HJP9Miv416bUCNmKbgIuyi/j81KBKdK8q3ObEo=;
  b=IOFIpSRT5FYHLr8RwSjog7NFvmEXWYstNwMLQa1U6CdXT3i5IbBcPrH9
   JhrHO25WUD5BXDzGyw1qX9ZNuA7EKLk3DeY41Bpe3eGRDsRVO1h71+yq7
   Imz0fhBOv4r9W+tNQoGLS30MoX6Ih4eLPeg/k2/k7gyQv1lJZOWAp1hkm
   ABgHJePBXBwffJNt5JMA6JzjvjDFzQm5ar4vilXPG2WWk36b2s4jA0YHy
   4rhXTK3+BDtck2BJPBPOUT5186Xy48HqMvNBavOi1MoTdMZoZmStjL699
   7u5JMRD3pMSuzavRxsnXsmtyctG1klmEClzWwTgV9EodHoKddm9RNq5Y5
   w==;
X-CSE-ConnectionGUID: iBzn61+STOujZCNtwHj1AQ==
X-CSE-MsgGUID: Phg72PTdTJiqUPQuANpySA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="74151050"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="74151050"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 05:16:41 -0700
X-CSE-ConnectionGUID: soMIDzCnRi2V7Erg5rnfxA==
X-CSE-MsgGUID: XOwqzh2ySuGNMkVyrkckng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="142223777"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 May 2025 05:16:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uE5be-000Dkd-1u;
	Sun, 11 May 2025 12:16:34 +0000
Date: Sun, 11 May 2025 20:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Charkov <alchark@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
Message-ID: <202505112028.FOL7oTti-lkp@intel.com>
References: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ed61cb3d78d585209ec775933078e268544fe9a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Charkov/dt-bindings-spi-Add-VIA-WonderMedia-serial-flash-controller/20250511-034459
base:   ed61cb3d78d585209ec775933078e268544fe9a4
patch link:    https://lore.kernel.org/r/20250510-wmt-sflash-v1-2-02a1ac6adf12%40gmail.com
patch subject: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia serial flash controller
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250511/202505112028.FOL7oTti-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250511/202505112028.FOL7oTti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505112028.FOL7oTti-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/mtd/mtd.h:13,
                    from drivers/mtd/spi-nor/controllers/wmt-sflash.c:14:
   drivers/mtd/spi-nor/controllers/wmt-sflash.c: In function 'wmt_sflash_read_reg':
>> drivers/mtd/spi-nor/controllers/wmt-sflash.c:154:17: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     154 |                 "Cannot read %d bytes from registers\n", len);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:153:17: note: in expansion of macro 'dev_err'
     153 |                 dev_err(host->dev,
         |                 ^~~~~~~
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:154:31: note: format string is defined here
     154 |                 "Cannot read %d bytes from registers\n", len);
         |                              ~^
         |                               |
         |                               int
         |                              %ld
   drivers/mtd/spi-nor/controllers/wmt-sflash.c: In function 'wmt_sflash_write_reg':
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:187:17: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     187 |                 "Cannot write %d bytes to registers\n", len);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:186:17: note: in expansion of macro 'dev_err'
     186 |                 dev_err(host->dev,
         |                 ^~~~~~~
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:187:32: note: format string is defined here
     187 |                 "Cannot write %d bytes to registers\n", len);
         |                               ~^
         |                                |
         |                                int
         |                               %ld
   drivers/mtd/spi-nor/controllers/wmt-sflash.c: In function 'wmt_sflash_register':
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:365:47: error: passing argument 3 of 'of_property_read_u32' from incompatible pointer type [-Wincompatible-pointer-types]
     365 |         ret = of_property_read_u32(np, "reg", &priv->cs);
         |                                               ^~~~~~~~~
         |                                               |
         |                                               size_t * {aka long unsigned int *}
   In file included from include/linux/mtd/mtd.h:14:
   include/linux/of.h:1419:45: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'size_t *' {aka 'long unsigned int *'}
    1419 |                                        u32 *out_value)
         |                                        ~~~~~^~~~~~~~~
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:373:52: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     373 |                                      "Chip select %d is out of bounds\n",
         |                                                   ~^
         |                                                    |
         |                                                    int
         |                                                   %ld
     374 |                                      priv->cs);
         |                                      ~~~~~~~~       
         |                                          |
         |                                          size_t {aka long unsigned int}
   drivers/mtd/spi-nor/controllers/wmt-sflash.c:394:46: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     394 |                         "Failed to map chip %d at address 0x%x size 0x%llx\n",
         |                                             ~^
         |                                              |
         |                                              int
         |                                             %ld
     395 |                         priv->cs, priv->mmap_phys, mtd->size);
         |                         ~~~~~~~~              
         |                             |
         |                             size_t {aka long unsigned int}
>> drivers/mtd/spi-nor/controllers/wmt-sflash.c:394:62: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     394 |                         "Failed to map chip %d at address 0x%x size 0x%llx\n",
         |                                                             ~^
         |                                                              |
         |                                                              unsigned int
         |                                                             %llx
     395 |                         priv->cs, priv->mmap_phys, mtd->size);
         |                                   ~~~~~~~~~~~~~~~             
         |                                       |
         |                                       resource_size_t {aka long long unsigned int}


vim +154 drivers/mtd/spi-nor/controllers/wmt-sflash.c

  > 14	#include <linux/mtd/mtd.h>
    15	#include <linux/mtd/spi-nor.h>
    16	#include <linux/of.h>
    17	#include <linux/platform_device.h>
    18	#include <linux/slab.h>
    19	
    20	#define SF_CHIP_SEL_0_CFG	0x000		/* chip select 0 config */
    21	#define SF_CHIP_SEL_1_CFG	0x008		/* chip select 0 config */
    22	#define SF_CHIP_SEL_CFG(x)	(8 * (x))
    23	#define SF_CHIP_SEL_ADDR	GENMASK(31, 16) /* 64kb aligned address */
    24	#define SF_CHIP_SEL_SIZE	GENMASK(11, 8)	/* log2(size/32kb) */
    25	
    26	#define SF_SPI_INTF_CFG		0x040	/* SPI interface config */
    27	#define SF_ADDR_WIDTH_32	BIT(0)	/* 0: 24 bit, 1: 32 bit addr */
    28	#define SF_USR_RD_CMD_MOD	BIT(4)	/* 0: normal, 1: user cmd read */
    29	#define SF_USR_WR_CMD_MOD	BIT(5)	/* 0: normal, 1: user cmd write */
    30	#define SF_PROG_CMD_MOD		BIT(6)	/* 0: normal, 1: prog cmd */
    31	#define SF_CS_DELAY		GENMASK(18, 16)	/* chip select delay */
    32	#define SF_RES_DELAY		GENMASK(27, 24) /* reset delay */
    33	#define SF_PDWN_DELAY		GENMASK(31, 28) /* power down delay */
    34	
    35	#define SF_SPI_RD_WR_CTR	0x050	/* read/write control */
    36	#define SF_RD_FAST		BIT(0)	/* 0: normal read, 1: fast read */
    37	#define SF_RD_ID		BIT(4)	/* 0: read status, 1: read ID */
    38	
    39	#define SF_SPI_WR_EN_CTR	0x060	/* write enable control */
    40	#define SF_CS0_WR_EN		BIT(0)
    41	#define SF_CS1_WR_EN		BIT(1)
    42	#define SF_CS_WR_EN(x)		BIT(x)
    43	
    44	#define SF_SPI_ER_CTR		0x070	/* erase control */
    45	#define SF_CHIP_ERASE		BIT(0)	/* full chip erase */
    46	#define SF_SEC_ERASE		BIT(15)	/* sector erase */
    47	
    48	#define SF_SPI_ER_START_ADDR	0x074	/* erase start address */
    49	#define SF_CHIP_ER_CS0		BIT(0)	/* erase chip 0 */
    50	#define SF_CHIP_ER_CS1		BIT(1)	/* erase chip 1 */
    51	#define SF_CHIP_ER_CS(x)	BIT(x)
    52	#define SF_ER_START_ADDR	GENMASK(31, 16)
    53	
    54	#define SF_SPI_ERROR_STATUS	0x080
    55	#define SF_MASLOCK_ERR		BIT(0)	/* master lock */
    56	#define SF_PCMD_ACC_ERR		BIT(1)	/* programmable cmd access */
    57	#define SF_PCMD_OP_ERR		BIT(2)	/* programmable cmd opcode */
    58	#define SF_PWR_DWN_ACC_ERR	BIT(3)	/* power down access */
    59	#define SF_MEM_REGION_ERR	BIT(4)	/* memory region */
    60	#define SF_WR_PROT_ERR		BIT(5)	/* write protection */
    61	#define SF_SPI_ERROR_CLEARALL	(SF_MASLOCK_ERR | \
    62					 SF_PCMD_ACC_ERR | \
    63					 SF_PCMD_OP_ERR | \
    64					 SF_PWR_DWN_ACC_ERR | \
    65					 SF_MEM_REGION_ERR | \
    66					 SF_WR_PROT_ERR)
    67	
    68	#define SF_SPI_MEM_0_SR_ACC	0x100	/* status read from chip 0 */
    69	#define SF_SPI_MEM_1_SR_ACC	0x110	/* status read from chip 1 */
    70	#define SF_SPI_MEM_SR_ACC(x)	(0x100 + 0x10 * (x))
    71	
    72	#define SF_SPI_PDWN_CTR_0	0x180	/* power down chip 0 */
    73	#define SF_SPI_PDWN_CTR_1	0x190	/* power down chip 1 */
    74	#define SF_SPI_PDWN_CTR_(x)	(0x180 + 0x10 * (x))
    75	#define SF_PWR_DOWN		BIT(0)
    76	
    77	#define SF_SPI_PROG_CMD_CTR	0x200	/* programmable cmd control */
    78	#define SF_PROG_CMD_EN		BIT(0)	/* enable programmable cmd */
    79	#define SF_PROG_CMD_CS		GENMASK(1, 1)	/* chip select for cmd */
    80	#define SF_RX_DATA_SIZE		GENMASK(22, 16)	/* receive data size */
    81	#define SF_TX_DATA_SIZE		GENMASK(30, 24)	/* transmit data size */
    82	
    83	#define SF_SPI_USER_CMD_VAL	0x210
    84	#define SF_USR_RD_CMD		GENMASK(7, 0)	/* user read command */
    85	#define SF_USR_WR_CMD		GENMASK(23, 16)	/* user write command */
    86	
    87	#define SF_SPI_PROG_CMD_WBF	0x300	/* 64 bytes pcmd write buffer */
    88	#define SF_SPI_PROG_CMD_RBF	0x380	/* 64 bytes pcmd read buffer */
    89	
    90	#define SF_WAIT_TIMEOUT		1000000
    91	
    92	struct wmt_sflash_priv {
    93		size_t			cs;
    94		struct wmt_sflash_host	*host;
    95		void __iomem		*mmap_base;
    96		resource_size_t		mmap_phys;
    97	};
    98	
    99	#define SF_MAX_CHIP_NUM		2
   100	struct wmt_sflash_host {
   101		struct device		*dev;
   102		struct clk		*clk;
   103	
   104		void __iomem		*regbase;
   105		struct resource		*mmap_res[SF_MAX_CHIP_NUM];
   106	
   107		struct spi_nor		*nor[SF_MAX_CHIP_NUM];
   108		size_t			num_chips;
   109	};
   110	
   111	static int wmt_sflash_prep(struct spi_nor *nor)
   112	{
   113		struct wmt_sflash_priv *priv = nor->priv;
   114		struct wmt_sflash_host *host = priv->host;
   115	
   116		return clk_prepare_enable(host->clk);
   117	}
   118	
   119	static void wmt_sflash_unprep(struct spi_nor *nor)
   120	{
   121		struct wmt_sflash_priv *priv = nor->priv;
   122		struct wmt_sflash_host *host = priv->host;
   123	
   124		clk_disable_unprepare(host->clk);
   125	}
   126	
   127	static void wmt_sflash_pcmd_mode(struct wmt_sflash_host *host, bool enable)
   128	{
   129		u32 reg = readl(host->regbase + SF_SPI_INTF_CFG);
   130	
   131		reg &= ~SF_PROG_CMD_MOD;
   132		reg |= FIELD_PREP(SF_PROG_CMD_MOD, enable);
   133		writel(reg, host->regbase + SF_SPI_INTF_CFG);
   134	}
   135	
   136	static inline int wmt_sflash_wait_pcmd(struct wmt_sflash_host *host)
   137	{
   138		u32 reg;
   139	
   140		return readl_poll_timeout(host->regbase + SF_SPI_PROG_CMD_CTR, reg,
   141			!(reg & SF_PROG_CMD_EN), 1, SF_WAIT_TIMEOUT);
   142	}
   143	
   144	static int wmt_sflash_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
   145				       size_t len)
   146	{
   147		struct wmt_sflash_priv *priv = nor->priv;
   148		struct wmt_sflash_host *host = priv->host;
   149		int ret;
   150		u32 reg;
   151	
   152		if (len > 64) {
   153			dev_err(host->dev,
 > 154			"Cannot read %d bytes from registers\n", len);
   155			return -EINVAL;
   156		}
   157	
   158		wmt_sflash_pcmd_mode(host, true);
   159		writeb(opcode, host->regbase + SF_SPI_PROG_CMD_WBF);
   160	
   161		reg = SF_PROG_CMD_EN |
   162		      FIELD_PREP(SF_PROG_CMD_CS, priv->cs) |
   163		      FIELD_PREP(SF_TX_DATA_SIZE, 1) |
   164		      FIELD_PREP(SF_RX_DATA_SIZE, len);
   165		writel(reg, host->regbase + SF_SPI_PROG_CMD_CTR);
   166	
   167		ret = wmt_sflash_wait_pcmd(host);
   168	
   169		if (len)
   170			memcpy_fromio(buf, host->regbase + SF_SPI_PROG_CMD_RBF, len);
   171	
   172		wmt_sflash_pcmd_mode(host, false);
   173	
   174		return ret;
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

