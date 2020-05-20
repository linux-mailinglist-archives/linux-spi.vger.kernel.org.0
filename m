Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF59D1DB3D1
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETMkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgETMkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589978417;
        bh=PWAoRxwCm2aEdygptF5qvl7m89GUf6W93CfAUUjZwek=;
        h=Subject:From:Date:To:From;
        b=MT02Na/kiZ9i7PqSrLUajpjZYQdWLVYg/OKV/o4xjnLYQUdclYHKnhn57l71SfPNO
         66D/uLm/gj8uVYWMJ2NZcto2M9SC2el0TrxwPLTL/czUb64lRIDV50t8bJDFXVzmbh
         jUPxX+eJEIUzJphgtbeYOCOMGKEB++k4QdtPPSz4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158997841764.20514.3565591183853919241.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 May 2020 12:40:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver (2020-05-20T12:36:12)
  Superseding: [v1] dt-bindings: spi: Add schema for Cadence QSPI Controller driver (2020-05-12T00:49:19):
    [v1] dt-bindings: spi: Add schema for Cadence QSPI Controller driver

Latest series: [v8] add ecspi ERR009165 for i.mx6/7 soc family (2020-05-20T20:34:12)
  Superseding: [v7] add ecspi ERR009165 for i.mx6/7 soc family (2020-05-11T17:32:23):
    [v7,RESEND,01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v7,RESEND,02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v7,RESEND,03/13] Revert "dmaengine: imx-sdma: fix context cache"
    [v7,RESEND,04/13] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v7,RESEND,05/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [v7,RESEND,06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v7,RESEND,07/13] spi: imx: fix ERR009165
    [v7,RESEND,08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v7,RESEND,09/13] spi: imx: add new i.mx6ul compatible name in binding doc
    [v7,RESEND,10/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v7,RESEND,11/13] dma: imx-sdma: add i.mx6ul compatible name
    [v7,RESEND,12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v7,RESEND,13/13] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
