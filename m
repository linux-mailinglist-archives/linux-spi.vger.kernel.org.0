Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511771E5C73
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgE1Jyr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 05:54:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbgE1Jyr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 05:54:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04S9sKep073014;
        Thu, 28 May 2020 04:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590659660;
        bh=fFt+EvSvDnHIYU/mdgaQndevTVzx/3/nPmaY5O3YS8Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QdLpXxfHddhehXDQFmZjHc3vxdZOL1M+cG5mEV72ev2HFoDsuqSVDTAOyMuF2DAyt
         OlZQvFwghFf/ZGZRUWTQmaEOyN+js9oDwHSx6oC59XUfkyIvYzwDV3CMxD+tH8U0F/
         w+lyEThhkiBlHPZ5b+bQkaBpT0VKUh9LSEYgmzlw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04S9sKMb073639;
        Thu, 28 May 2020 04:54:20 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 04:54:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 04:54:19 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04S9sFgS019886;
        Thu, 28 May 2020 04:54:15 -0500
Subject: Re: [PATCH v2 6/6] spi: Move cadence-quadspi driver to drivers/spi/
To:     kbuild test robot <lkp@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     <kbuild-all@lists.01.org>, Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
References: <20200526093604.11846-7-vigneshr@ti.com>
 <202005280400.IgqKbGTF%lkp@intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3fd21609-cb9a-cbe9-f40f-a8a8a00491a2@ti.com>
Date:   Thu, 28 May 2020 15:24:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202005280400.IgqKbGTF%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 28/05/20 2:28 am, kbuild test robot wrote:
> Hi Vignesh,
> 
[...]
> 
> In file included from include/linux/err.h:5,
> from include/linux/clk.h:12,
> from drivers/spi/spi-cadence-quadspi.c:9:
> include/linux/scatterlist.h: In function 'sg_set_buf':
> arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
> 78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> |                                          ^
> include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |  ^~~~~~
> arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
> 201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> |                                ^~~~~~~~~
> include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |          ^~~~~~~~~~~~~~~
> In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
> from include/linux/bug.h:5,
> from include/linux/thread_info.h:12,
> from arch/xtensa/include/asm/current.h:18,
> from include/linux/mutex.h:14,
> from include/linux/notifier.h:14,
> from include/linux/clk.h:14,
> from drivers/spi/spi-cadence-quadspi.c:9:
> include/linux/dma-mapping.h: In function 'dma_map_resource':
> arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> include/asm-generic/bug.h:139:27: note: in definition of macro 'WARN_ON_ONCE'
> 139 |  int __ret_warn_once = !!(condition);            |                           ^~~~~~~~~
> include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
> 352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> |                   ^~~~~~~~~
> In file included from include/linux/shm.h:6,
> from include/linux/sched.h:16,
> from include/linux/ratelimit.h:6,
> from include/linux/dev_printk.h:16,
> from include/linux/device.h:15,
> from include/linux/dma-mapping.h:7,
> from drivers/spi/spi-cadence-quadspi.c:12:
> drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_direct_read_execute':
> arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
> 201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> |                                ^~~~~~~~~
>>> drivers/spi/spi-cadence-quadspi.c:911:26: note: in expansion of macro 'virt_addr_valid'
> 911 |  if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
> |                          ^~~~~~~~~~~~~~~


Thanks for the report! But it seems with ARCH=xtensa and config that was
attached, I see above warning for every file in the kernel that uses
virt_addr_valid(), So, the fix for this warning is really in xtensa arch
code and therefore should not block this series from being merged.


Regards
Vignesh
