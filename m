Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC187B7C8
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2019 03:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGaBuu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jul 2019 21:50:50 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:30272 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGaBuu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Jul 2019 21:50:50 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x6V1o3PT061827;
        Wed, 31 Jul 2019 09:50:03 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        Mason Yang <masonccyang@mxic.com.tw>, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
Subject: [PATCH v16 0/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver
Date:   Wed, 31 Jul 2019 10:14:16 +0800
Message-Id: <1564539258-16313-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x6V1o3PT061827
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

v16 patch including:
1) fixed typo and spi-tx/rx-bus-width in DTS.
2) v14 dt-binding file has reviewed by Rob Herring.

v15 patch including:
1) A typo in dt-bindings and add flash subnode description
2) v14 dt-binding file has reviewed by Rob Herring.

v14 patch including:
1) Patch RPC-IF back to SPI mode only instead of MFD & SPI 
   by MFD maintainer, Lee Jones comments.
2) Patch pm_runtime control in spi transfer.

v13 patch including:
1) rename mfd to ddata for SPI driver.
2) Patch RPC-IF devicetree for SPI and HyperFlash.

v12 patch including:
1) add back "wbuf" in dts example.
2) RPC-IF replace rpc-if in dts.

v11 patch including:
1) Patch mfd include header file.
2) mfd coding style.
3) add back wbuf description in dts.

v10 patch including:
1) Address range for > 64M byte flash.
2) Removed dirmap_write due to WBUF 256 bytes transfer issue.
3) Dummy bytes setting according to spi-nor.c layer.

v9 patch is for RPC MFD driver and RPC SPI driver.

v8 patch including:
1) Supported SoC-specific values in DTS.
2) Rename device node name as flash.

v7 patch is according to Geert and Sergei's comments:
1) Add all R-Car Gen3 model in dts.
2) patch rpc-if child node search.
3) minror coding style.

v6 patch is accroding to Geert, Marek and Sergei's comments:
1) spi_controller for new code.
2) "renesas,rcar-gen3-rpc" instead of "renesas,r8a77995-rpc."
3) patch external address read mode w/o u64 readq().
4) patch dts for write buffer & drop "renesas,rpc-mode".
5) coding style and so on.

v5 patch is accroding to Sergei's comments:
1) Read 6 bytes ID from Sergei's patch.
2) regmap_update_bits().
3) C++ style comment.

v4 patch is according to Sergei's comments including:
1) Drop soc_device_match().
2) Drop unused RPC registers.
3) Use ilog2() instead of fls().
4) Patch read 6 bytes ID w/ one command.
5) Coding style and so on.

v3 patch is according to Marek and Geert's comments including:
1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
2) get_unaligned().
3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
4) coding style and so on.

v2 patch including:
1) remove RPC clock enable/dis-able control,
2) patch run time PM.
3) add RPC module software reset,
4) add regmap.
5) other coding style and so on.

thanks for your review.

best regards,
Mason


Mason Yang (2):
  spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
  dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller
    bindings

 .../devicetree/bindings/spi/spi-renesas-rpc.txt    |  45 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 754 +++++++++++++++++++++
 4 files changed, 806 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
 create mode 100644 drivers/spi/spi-renesas-rpc.c

-- 
1.9.1

