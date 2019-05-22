Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546FC2619A
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfEVKUY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 06:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfEVKUX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 May 2019 06:20:23 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558520423;
        bh=M66alM2DhPyk6iDCl24yjg7OSxDV6WRcC07HvKwioDg=;
        h=Subject:From:Date:To:From;
        b=eYqSppxMfa+jPQ2DCoeBHBZgSxu4/TeaZfEX8ibIDpW2v+kPfVuugD8g3lfV4z/MS
         9s5VLhuRlStf0IEPgWRLHksgM8IJhfdyabK5hxQHLwwrXF8WQ6oMTtt7G6igVVhdNe
         emTo3Xjp3+OtwIfJ9aaeCRWmnUWsQnBRmbNLNVVQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155852042339.18684.12445671437681206407.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 May 2019 10:20:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] add ecspi ERR009165 for i.mx6/7 soc family (2019-05-22T09:59:45)
  Superseding: [v3] add ecspi ERR009165 for i.mx6/7 soc family (2019-05-07T09:15:41):
    [v3,01/14] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v3,02/14] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v3,03/14] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v3,04/14] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [v3,05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v3,06/14] spi: imx: fix ERR009165
    [v3,07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v3,08/14] dt-bindings: spi: imx: add new i.mx6ul compatible name
    [v3,09/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v3,10/14] dt-bindings: dma: imx-sdma: add i.mx6ul/6sx compatible name
    [v3,11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v3,12/14] ARM: dts: imx6ul: add dma support on ecspi
    [v3,13/14] ARM: dts: imx6sll: correct sdma compatible
    [v3,14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
