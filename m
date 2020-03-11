Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C355A181376
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 09:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgCKIkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 04:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgCKIkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Mar 2020 04:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583916015;
        bh=FHzt6KnydgZvotg9vva/91QWFg+6JHNE4ZAAX2NI3Qs=;
        h=Subject:From:Date:To:From;
        b=1GUgrDOkGfl6xLUFfKrSfkeg+u7RtHfFdqjh9+094RomZeJdfSpohcD/J1EJAySv1
         6Rde7rB/D3Bav2/D0kFamcxV+j96RLDWgRreEKkD/3u+b4JIZQws/Sg477k9axNKHM
         N59X/bUlxFiAYlVp6+3UOcugNqrwA9uRbCVjuYDI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158391601548.31045.16504667718446370234.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 11 Mar 2020 08:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] add ecspi ERR009165 for i.mx6/7 soc family (2020-03-11T16:36:23)
  Superseding: [v6] add ecspi ERR009165 for i.mx6/7 soc family (2020-03-10T11:31:49):
    [RESEND,v6,01/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [RESEND,v6,02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [RESEND,v6,03/13] Revert "dmaengine: imx-sdma: refine to load context only once"
    [RESEND,v6,04/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
    [RESEND,v6,05/13] dmaengine: imx-sdma: add mcu_2_ecspi script
    [RESEND,v6,06/13] spi: imx: fix ERR009165
    [RESEND,v6,07/13] spi: imx: remove ERR009165 workaround on i.mx6ul
    [RESEND,v6,08/13] spi: imx: add new i.mx6ul compatible name in binding doc
    [RESEND,v6,09/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [RESEND,v6,10/13] dma: imx-sdma: add i.mx6ul/6sx compatible name
    [RESEND,v6,11/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [RESEND,v6,12/13] dmaengine: imx-sdma: add uart rom script
    [RESEND,v6,13/13] Revert "dmaengine: imx-sdma: fix context cache"


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
