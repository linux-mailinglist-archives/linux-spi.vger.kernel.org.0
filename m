Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F8265EDF
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKLha (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 07:37:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:32681 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKLeI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 07:34:08 -0400
IronPort-SDR: xkDIofLTm0ZPl8ajt8pUvm/mZE2B7kFy1P2d1cEPzKoU3S933Fb7sXwmu4yX8oZLDqpcb3nyov
 EXgeDD8C+ieg==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="243560440"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="gz'50?scan'50,208,50";a="243560440"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:32:45 -0700
IronPort-SDR: 4JJ1HbBBqeYTkD6Bs9fNZRTmsYdvgIWo/KLrTZDtqN/rCFVplb/5gNbPYskXsfRpyxBJfeqM4E
 sY2GqsEFDq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="gz'50?scan'50,208,50";a="286871817"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2020 04:32:40 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGhIF-0000C1-Hc; Fri, 11 Sep 2020 11:32:39 +0000
Date:   Fri, 11 Sep 2020 19:31:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ikjoon Jang <ikjn@chromium.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] spi: spi-mtk-nor: support 36bit dma addressing to
 mediatek spi-nor
Message-ID: <202009111935.zJfWEk96%lkp@intel.com>
References: <20200910041101.1695195-3-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20200910041101.1695195-3-ikjn@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ikjoon,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on next-20200910]
[cannot apply to robh/for-next v5.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ikjoon-Jang/Add-36bit-dma-support-to-mediatek-spi-nor-controller/20200910-121600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: arm-randconfig-r035-20200909 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mtk-nor.c:286:19: warning: shift count >= width of type [-Wshift-count-overflow]
                   writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
                                   ^  ~~
   arch/arm/include/asm/io.h:307:51: note: expanded from macro 'writel'
   #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
                                                                ^
   arch/arm/include/asm/io.h:299:68: note: expanded from macro 'writel_relaxed'
   #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
                                                                          ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/spi/spi-mtk-nor.c:287:30: warning: shift count >= width of type [-Wshift-count-overflow]
                   writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
                                              ^  ~~
   arch/arm/include/asm/io.h:307:51: note: expanded from macro 'writel'
   #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
                                                                ^
   arch/arm/include/asm/io.h:299:68: note: expanded from macro 'writel_relaxed'
   #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
                                                                          ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   2 warnings generated.

# https://github.com/0day-ci/linux/commit/d6ccdab2988e8bf7aa66cc57daeac5e1a7e399cc
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Ikjoon-Jang/Add-36bit-dma-support-to-mediatek-spi-nor-controller/20200910-121600
git checkout d6ccdab2988e8bf7aa66cc57daeac5e1a7e399cc
vim +286 drivers/spi/spi-mtk-nor.c

   266	
   267	static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
   268				    u8 *buffer)
   269	{
   270		int ret = 0;
   271		ulong delay;
   272		u32 reg;
   273		dma_addr_t dma_addr;
   274	
   275		dma_addr = dma_map_single(sp->dev, buffer, length, DMA_FROM_DEVICE);
   276		if (dma_mapping_error(sp->dev, dma_addr)) {
   277			dev_err(sp->dev, "failed to map dma buffer.\n");
   278			return -EINVAL;
   279		}
   280	
   281		writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
   282		writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
   283		writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
   284	
   285		if (sp->high_dma) {
 > 286			writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
   287			writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
   288		}
   289	
   290		if (sp->has_irq) {
   291			reinit_completion(&sp->op_done);
   292			mtk_nor_rmw(sp, MTK_NOR_REG_IRQ_EN, MTK_NOR_IRQ_DMA, 0);
   293		}
   294	
   295		mtk_nor_rmw(sp, MTK_NOR_REG_DMA_CTL, MTK_NOR_DMA_START, 0);
   296	
   297		delay = CLK_TO_US(sp, (length + 5) * BITS_PER_BYTE);
   298	
   299		if (sp->has_irq) {
   300			if (!wait_for_completion_timeout(&sp->op_done,
   301							 (delay + 1) * 100))
   302				ret = -ETIMEDOUT;
   303		} else {
   304			ret = readl_poll_timeout(sp->base + MTK_NOR_REG_DMA_CTL, reg,
   305						 !(reg & MTK_NOR_DMA_START), delay / 3,
   306						 (delay + 1) * 100);
   307		}
   308	
   309		dma_unmap_single(sp->dev, dma_addr, length, DMA_FROM_DEVICE);
   310		if (ret < 0)
   311			dev_err(sp->dev, "dma read timeout.\n");
   312	
   313		return ret;
   314	}
   315	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/P+EnDxINjgCAA==

--opJtzjQTFsWo+cga--
