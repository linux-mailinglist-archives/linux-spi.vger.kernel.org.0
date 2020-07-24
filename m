Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8583322C375
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGXKkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 06:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgGXKkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Jul 2020 06:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595587220;
        bh=nBdGSSe2b8lcV+iiKj9H/HXLYvJL4VImDFZU3VkLuMI=;
        h=Subject:From:Date:To:From;
        b=fl6ExDw7hoyvduo/qWCaVtB1BTFzD12rXXp0ieX2sYo4UrPJV1PBPFNnuH/MEbSvV
         D4wwtRIWzWxyuc7g1TDJl/YYcuIP7MweZJczpNgAorgdxNUTuGZj1y1HKFbW2mk4q1
         +DOQ+CMcl3dNlYIxhkaFTi0NwXW344MzGJ6XzA/Y=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159558722008.11119.15050769672193525532.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Jul 2020 10:40:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] add ecspi ERR009165 for i.mx6/7 soc family (2020-07-24T18:51:13)
  Superseding: [v10] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-30T13:31:04):
    [v10,01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v10,02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v10,03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v10,04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v10,05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
    [v10,06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v10,07/12] spi: imx: fix ERR009165
    [v10,08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v10,09/12] spi: imx: add new i.mx6ul compatible name in binding doc
    [v10,10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v10,11/12] dma: imx-sdma: add i.mx6ul compatible name
    [v10,12/12] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
