Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2312574E2
	for <lists+linux-spi@lfdr.de>; Mon, 31 Aug 2020 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHaIAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 04:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgHaIAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 31 Aug 2020 04:00:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598860816;
        bh=O89w2UkhByBwKqG3Qu8K/D158kv8jD3DxHmMiUKgzLQ=;
        h=Subject:From:Date:To:From;
        b=Yb+wgLPQtnaWbMU+kgYmjU8Hs09eMObo1BOvJ5Q7JseagPjppYapt0gdgHPeplvNl
         z+5ifpEiT0jcAijn5ltYZoms33J6/6Xa66VP13iZzT5q1b9a5hiplS0GdMpNn20r4K
         m+ndrnpU0j/W7lKNdDJ9/TVgihpJ3m0zUTOhAfHA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159886081602.32203.16628700977022440030.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 31 Aug 2020 08:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v13] add ecspi ERR009165 for i.mx6/7 soc family (2020-08-31T16:03:13)
  Superseding: [v12] add ecspi ERR009165 for i.mx6/7 soc family (2020-08-11T15:53:39):
    [v12,01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v12,02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v12,03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v12,04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v12,05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
    [v12,06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v12,07/12] spi: imx: fix ERR009165
    [v12,08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v12,09/12] spi: imx: add new i.mx6ul compatible name in binding doc
    [v12,10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v12,11/12] dma: imx-sdma: add i.mx6ul compatible name
    [v12,12/12] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
