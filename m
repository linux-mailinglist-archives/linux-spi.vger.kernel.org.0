Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B547B3C7C29
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhGNC72 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 22:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhGNC72 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 22:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 633CB61380;
        Wed, 14 Jul 2021 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626231397;
        bh=c+ifyPPxWhccAcxrquopryXaT7KQUhPPbFn6SlxJADU=;
        h=Subject:From:Date:To:From;
        b=Lha5lwJ3dC9txlyXMfxJWJeicZy4cFaAE2qHRPZX/+K82UBcF2xpGl9X3P09/Bkhk
         H8H9y7cNRFRHmbHgZHFqwIQRB2ZBDxP7DSU9YNo1EIeZKFRCnp/9oNJ0uXviGfZ+tc
         4mvMCclGWguRXdgp3AGIjG1rg9pYl9GksTim46ES6Ao0aLCKO+cYiOPSlCQMGvaldP
         yPxu7Qfka4BuJ8bkAACQ7ee5QyeaaI6I5pE7vH1KMaqX/vITHF5QI3aKkQCpx49ANb
         RpHWU1mOnrwmiNlKJDRer6WKObkS40DI0DCpCCGzApNxPGHpAlSzBPVOb/8J5aENy1
         Y+VFQ95RCP14w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4EBA6609DA;
        Wed, 14 Jul 2021 02:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162623139726.22603.6264836047215214220.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 14 Jul 2021 02:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v16] add ecspi ERR009165 for i.mx6/7 soc family (2021-07-14T10:20:40)
  Superseding: [v15] add ecspi ERR009165 for i.mx6/7 soc family (2021-07-13T18:41:37):
    [v15,01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v15,02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v15,03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v15,04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v15,05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
    [v15,06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v15,07/12] spi: imx: fix ERR009165
    [v15,08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v15,09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v15,10/12] dma: imx-sdma: add i.mx6ul compatible name
    [v15,11/12] dmaengine: imx-sdma: add uart rom script
    [v15,12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

