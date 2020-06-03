Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4AE1ECBA8
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCIio (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 04:38:44 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:47224 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgFCIin (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 04:38:43 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 04:38:42 EDT
IronPort-SDR: z/jVJADfiYlbf7L1cZfhZDLJYTsZdqdrEhARY8Zwl9Zt8UABFKp0YBhYgOUaarv2jfPvXD0bwn
 VIjnvxsnifb0L0qTRgt+YK5Llm7Lx2qF+Nn/bf1xUNj42djbQgnapmHJY1FdRktvvZn+bEWRnq
 lhRfG+tjXWdjUfqCr/44w2rCH12iEfNzjQr0pHpslZ1hKrP+fc7nJSZKnIT1baqTK9GWTjt8F4
 7N/gAKK5MqBoPckRcgDYE0/3gTFx3NdilWrvNNIG6XGNWSiSJB5W+CaQp2Q5WCBtpYdxF8UEdw
 6g0=
X-IronPort-AV: E=Sophos;i="5.73,467,1583190000"; 
   d="scan'208";a="12527402"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Jun 2020 10:31:28 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Jun 2020 10:31:28 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Jun 2020 10:31:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591173088; x=1622709088;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12gaEvPgejwcTMiFel9idGDiiN7NGsxeA5qn0WYphWw=;
  b=filiwAvws7LXaZiT4GBJMTkU/hytB/dJ4lR9GjrnkZEm+mmumWOAja1+
   fMzAY4mHLN9OMJI2CUPgaTLI1T+6m+mWCVn3QRd55shqryA8mYfMkNnZb
   Z11TsW+rD7NO/Doe4QUVFN3v4xUsrdfxjRDNVcmoSDGlIAz/1ml/ftJ0w
   MBM3SWwQe2mjY/TsOuA475AykQcjVerjGZS0lLsIz6eK3LOqJ98RDFPkE
   wG6NbipJCPbHxiEWPMvxnJQ9u+RJAPLGldX5CtUUEUaxPeAd8XinERFTI
   bG9O/ZVqkx6Z3oPpYjci8F+3kSIcFWuZlx6NiAvgxI+EIbCw+XqV/LQqs
   w==;
IronPort-SDR: 7SR6DAMyb5S1Vz+MGSbLoaghwF70s+wW8DJfdKEqs6u6ZE0Bk2Lk79NG2budY+lJKGBcaIuWaW
 ad1xdJiPq55IemDxCIe4tE53xZwD8SrIwqPq9+12XNMmmH87RAdA/AukcBoV9zcLbv6LvOXl2F
 y5H5WZzk4HPS88vS1ACernz5ZxMYTBOzZCoG+n4Ju3Ns6tjafbLOTKpK7UFKPYG8KXeImJCCz2
 W/gzLW3YWC8uybCRxxOhOT2tRjQ0QEMkf+iUd40Hwa8G1aPqrVmqf/uUTpJblMvit+Yzqbs9h5
 RnA=
X-IronPort-AV: E=Sophos;i="5.73,467,1583190000"; 
   d="scan'208";a="12527401"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Jun 2020 10:31:28 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B9AA3280065;
        Wed,  3 Jun 2020 10:31:28 +0200 (CEST)
Message-ID: <5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com>
Subject: Re: (EXT) [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc
 family
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com,
        Markus Niebel <Markus.Niebel@tq-group.com>
Date:   Wed, 03 Jun 2020 10:31:25 +0200
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2020-05-21 at 04:34 +0800, Robin Gong wrote:
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information
> from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is
> adding
> new sdma ram script which works in XCH  mode as PIO inside sdma
> instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should
> be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including
> i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8
> chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need
> errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
> 
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to
> your
> local rootfs /lib/firmware/imx/sdma.


Hello Robin,

we have tried out this series, and there seems to be an issue with the
PIO fallback. We are testing on an i.MX6Q board, and our kernel is a
mostly-unmodified 5.4, on which we backported all SDMA patches from
next-20200602 (imx-sdma.c is identical to next-20200602 version), and 
then applied this whole series.

We build the SDMA driver as a kernel module, which is loaded by udev,
so the root filesystem is ready and the SDMA firmware can be loaded.
The behaviour we're seeing is the following:

1. As long as the SDMA driver is not loaded, initializing spi_imx will
be deferred
2. imx_sdma is loaded. The SDMA firmware is not yet loaded at this
point
3. spi_imx is initialized and an SPI-NOR flash is probed. To load the
BFPT, the driver will attempt to use DMA; this will fail with EINVAL as
long as the SDMA firmware is not ready, so the fallback to PIO happens
(4. SDMA firmware is ready, subsequent SPI transfers use DMA)

The problem happens in step 3: Whenever the driver falls back to PIO,
the received data is corrupt. The behaviour is specific to the
fallback: When I disable DMA completely via spi_imx.use_dma, or when
the timing is lucky and the SDMA firmware gets loaded before the flash
is probed, no corruption can be observed.

Kind regards,
Matthias



> 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma
> 
> v2:
>   1.Add commit log for reverted patches.
>   2.Add comment for 'ecspi_fixed' in sdma driver.
>   3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>     rather than remove.
> v3:
>   1.Confirm with design team make sure ERR009165 fixed on
> i.mx6ul/i.mx6ull
>     /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy
> chips.
>     Correct dts related dts patch in v2.
>   2.Clean eratta information in binding doc and new 'tx_glitch_fixed'
> flag
>     in spi-imx driver to state ERR009165 fixed or not.
>   3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in
> the
>     errata workaroud, thus improve performance as possible.
> v4:
>   1.Add Ack tag from Mark and Vinod
>   2.Remove checking 'event_id1' zero as 'event_id0'.
> v5:
>   1.Add the last patch for compatible with the current uart driver
> which
>     using rom script, so both uart ram script and rom script
> supported
>     in latest firmware, by default uart rom script used. UART driver
>     will be broken without this patch.
> v6:
>   1.Resend after rebase the latest next branch.
>   2.Remove below No.13~No.15 patches of v5 because they were
> mergered.
>   	ARM: dts: imx6ul: add dma support on ecspi
>   	ARM: dts: imx6sll: correct sdma compatible
>   	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
>   3.Revert "dmaengine: imx-sdma: fix context cache" since
>     'context_loaded' removed.
> v7:
>   1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix
> context
>     cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma:
> refine
>     to load context only once" so that no building waring during
> comes out
>     during bisect.
>   2.Address Sascha's comments, including eliminating any i.mx6sx in
> this
>     series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and
> taking
>     care SMC bit for PIO.
>   3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
>    'spi: imx: add new i.mx6ul compatible name in binding doc'
> v8:
>   1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and
> merge
>     it into 04/13 of v7
>   2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for
> no any
>     ecspi function broken even if sdma firmware not updated.
>   3.merge 'tx.dst_maxburst' changes in the two continous patches into
> one
>     patch to avoid confusion.
>   4.fix typo 'duplicated'.
> 
> Robin Gong (13):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove duplicated sdma_load_context
>   spi: imx: fallback to PIO if dma setup failure
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   spi: imx: add new i.mx6ul compatible name in binding doc
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dma: imx-sdma: add i.mx6ul compatible name
>   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
>   dmaengine: imx-sdma: add uart rom script
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
>  drivers/dma/imx-sdma.c                             | 67 ++++++++++
> ------
>  drivers/spi/spi-imx.c                              | 92
> +++++++++++++++++++---
>  include/linux/platform_data/dma-imx-sdma.h         |  8 +-
>  7 files changed, 135 insertions(+), 44 deletions(-)
> 

