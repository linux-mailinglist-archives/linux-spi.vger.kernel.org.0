Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18269160AD
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEGJUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 05:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEGJUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 May 2019 05:20:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557220810;
        bh=oLlfNi+ZKgtsbVq/Q5bvDob8kRIMZBXqoMDas5P/280=;
        h=Subject:From:Date:To:From;
        b=etiT6sTuGcdkt314lDCjCscj/srccBh//CB4nvLHOl5AhEBl/xlJRk4XpqxM4xQaX
         jE9kpp9FaIlAxbpNP/2ytXWpaQZXBjCV3tJwSFdE9WUJAhqPA1FAoKAC3gd5SF1XBL
         sOHyal6lRlkqMt2YrvE7wd2T+Lh16nyI+fFkVjMA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155722081008.3095.6157171849604030711.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 07 May 2019 09:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] add ecspi ERR009165 for i.mx6/7 soc family (2019-05-07T09:15:41)
  Superseding: [v2] add ecspi ERR009165 for i.mx6/7 soc family (2019-04-26T08:05:04):
    [v2,01/15] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v2,02/15] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v2,03/15] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v2,04/15] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [v2,05/15] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v2,06/15] spi: imx: fix ERR009165
    [v2,07/15] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v2,08/15] dt-bindings: spi: imx: add i.mx6ul to state errata fixed
    [v2,09/15] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v2,10/15] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx compatible name
    [v2,11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v2,12/15] ARM64: dts: freescale: imx8mm/8mq: update new compatible name for ecspi and sdma
    [v2,13/15] ARM: dts: imx6ul: add dma support on ecspi
    [v2,14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
    [v2,15/15] arm64: defconfig: Enable SDMA on i.mx8mq/8mm


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
