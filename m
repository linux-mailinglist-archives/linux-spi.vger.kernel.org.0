Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A711EF971
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFENkT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 09:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgFENkS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 09:40:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591364418;
        bh=fynk7lIeQE1noX7Jus+nPtyGzGfure7/72TItYyy+8Y=;
        h=Subject:From:Date:To:From;
        b=YG6vwPhX67OEEdD05KR/6amDwQiql47xXQg8H5eJK6gk42DA2shuDN23thDsK8h+L
         BMgLwCuvVjCAcijbKPpF+nOdKAwQEO/kSznuYAnI9eKPn11r4iV+R4PgGZEUG1POG0
         dYua5DdHsMN10kgbULugqgDyIP/6fGaXAI2bm7l8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159136441827.16770.9197406815983617598.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 05 Jun 2020 13:40:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-05T21:32:21)
  Superseding: [v8] add ecspi ERR009165 for i.mx6/7 soc family (2020-05-20T20:34:12):
    [v8,01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v8,02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v8,03/13] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v8,04/13] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v8,05/13] spi: imx: fallback to PIO if dma setup failure
    [v8,06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v8,07/13] spi: imx: fix ERR009165
    [v8,08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v8,09/13] spi: imx: add new i.mx6ul compatible name in binding doc
    [v8,10/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v8,11/13] dma: imx-sdma: add i.mx6ul compatible name
    [v8,12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v8,13/13] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
