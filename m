Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC73B09F
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2019 10:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfFJIUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jun 2019 04:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbfFJIUM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Jun 2019 04:20:12 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560154811;
        bh=2h9dJ5FqNDdITEKDl8o9FWEJiQvsXYHfjYKiTQMaCbw=;
        h=Subject:From:Date:To:From;
        b=vna3FfJP7gdhHzMmP6Axu1Xti9S9pwcWgHXX8XNgTqRYhlvvJk8ZjNrri824gwONK
         v6X/bmZrBSsz820MuWfF8R6BdbU5eOwad6ymLO9NpbSOhQ/hdzN4C7Jb4SFoc2UNFD
         R54yO1Ymb9KrW3iHHmjxJKjRZPMi6CPjmGko5hyA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156015481143.28532.2823116154994344997.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 Jun 2019 08:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] add ecspi ERR009165 for i.mx6/7 soc family (2019-06-10T08:17:53)
  Superseding: [v4] add ecspi ERR009165 for i.mx6/7 soc family (2019-05-22T09:59:45):
    [v4,01/14] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v4,02/14] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v4,03/14] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v4,04/14] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [v4,05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v4,06/14] spi: imx: fix ERR009165
    [v4,07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v4,08/14] spi: imx: add new i.mx6ul compatible name in binding doc
    [v4,09/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v4,10/14] dma: imx-sdma: add i.mx6ul/6sx compatible name
    [v4,11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v4,12/14] ARM: dts: imx6ul: add dma support on ecspi
    [v4,13/14] ARM: dts: imx6sll: correct sdma compatible
    [v4,14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
