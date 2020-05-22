Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127701DE547
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 13:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgEVLXU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 07:23:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:60407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEVLXT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 07:23:19 -0400
IronPort-SDR: jeoUg05hnrP5pRtC8tvE22CFpGzas80u91ogFwke/mTFy8mV9okxGCM4lr1xbjHZAlRbxwzely
 1YnDJ9KyxT7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 04:23:19 -0700
IronPort-SDR: /1EluzxdWxvRz9OVl1c+0AFoPfa2xg9Ydb2tD2uwM0iLl54v3whnXu6cCItjPSBCPTKbx47S1I
 rFe9/RmbCiOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="412731372"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2020 04:23:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc5ln-008Dgk-8p; Fri, 22 May 2020 14:23:19 +0300
Date:   Fri, 22 May 2020 14:23:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200522112319.GZ1634618@smile.fi.intel.com>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522112200.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522112200.GY1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 02:22:00PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 03:07:49AM +0300, Serge Semin wrote:
> > Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
> > Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> > APB SSI devices embedded into the SoC. Currently the DMA-based transfers
> > are supported by the DW APB SPI driver only as a middle layer code for
> > Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
> > platform DMAC device we introduced a set of patches to fix it within this
> > series.
> > 
> > First of all we need to add the Tx and Rx DMA channels support into the DW
> > APB SSI binding. Then there are several fixes and cleanups provided as a
> > initial preparation for the Generic DMA support integration: add Tx/Rx
> > finish wait methods, clear DMAC register when done or stopped, Fix native
> > CS being unset, enable interrupts in accordance with DMA xfer mode,
> > discard static DW DMA slave structures, discard unused void priv pointer
> > and dma_width member of the dw_spi structure, provide the DMA Tx/Rx burst
> > length parametrisation and make sure it's optionally set in accordance
> > with the DMA max-burst capability.
> > 
> > In order to have the DW APB SSI MMIO driver working with DMA we need to
> > initialize the paddr field with the physical base address of the DW APB SSI
> > registers space. Then we unpin the Intel MID specific code from the
> > generic DMA one and placed it into the spi-dw-pci.c driver, which is a
> > better place for it anyway. After that the naming cleanups are performed
> > since the code is going to be used for a generic DMAC device. Finally the
> > Generic DMA initialization can be added to the generic version of the
> > DW APB SSI IP.
> > 
> > Last but not least we traditionally convert the legacy plain text-based
> > dt-binding file with yaml-based one and as a cherry on a cake replace
> > the manually written DebugFS registers read method with a ready-to-use
> > for the same purpose regset32 DebugFS interface usage.
> > 
> > This patchset is rebased and tested on the spi/for-next (5.7-rc5):
> > base-commit: fe9fce6b2cf3 ("Merge remote-tracking branch 'spi/for-5.8' into spi-next")
> 
> I have got two bounces because of enormous Cc list in your patches.
> I highly recommend to reconsider your approach how you derive Cc lists.

And a hint for huge amount addresses @baikalelectronics.ru. Setup mailing list
there and subscribe people there, no need to show this all here.

-- 
With Best Regards,
Andy Shevchenko


