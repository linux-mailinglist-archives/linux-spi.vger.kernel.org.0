Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641CC1F079E
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFFPkT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Jun 2020 11:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFFPkS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 6 Jun 2020 11:40:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591458018;
        bh=6+QgMQPin2vbcXhhyxtT8U7e1UIC2NxG03T535OIVX0=;
        h=Subject:From:Date:To:From;
        b=u7/CmKX5H5agq+F7EQipNAgm3DSIdnSAavufs0Q+GnmMW9CxYezmtE627zZhuKbqp
         m/s+jsYlehsC3ZGuwkQ6S1C8EyXFdh5v0gGAt6Hxpy0L6OmabDWlGRdg86AbWm31qO
         uKm+ZY9abslgfoXfsjbLbdevozEiEiYnErwOKl1Y=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159145801875.22785.18328257549395611358.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 06 Jun 2020 15:40:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-06T23:21:04)
  Superseding: [v9] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-05T21:32:21):
    [v9,01/14] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v9,02/14] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v9,03/14] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v9,04/14] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v9,05/14] spi: imx: fallback to PIO if dma setup failure
    [v9,06/14] spi: imx: add dma_sync_sg_for_device after fallback from dma
    [v9,07/14] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v9,08/14] spi: imx: fix ERR009165
    [v9,09/14] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v9,10/14] spi: imx: add new i.mx6ul compatible name in binding doc
    [v9,11/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v9,12/14] dma: imx-sdma: add i.mx6ul compatible name
    [v9,13/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v9,14/14] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
