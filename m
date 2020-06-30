Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33120EDA1
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jun 2020 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgF3FkV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jun 2020 01:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgF3FkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Jun 2020 01:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593495620;
        bh=TD7RjTsK+9QdOLo2jYPtDRGkxNfNdvZleYyw+GXJWog=;
        h=Subject:From:Date:To:From;
        b=Decr+yWKA2bs4EOAGQvFxJ7tA6fZjWxpCPMg53gFuT7gHuvxr3ZSbyOK1O2CqroYn
         aDJPgUupMEWq4L2NIkE3ikjlKQK6NU3Bv3bH8fK0/AXLzQuxtvgqMnVU+BgYKKinLi
         FpoEyn8pq0v7Hv+7uESEYWhdw+f8IdtK6sBYonGM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159349562041.23180.1068510465026947229.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 30 Jun 2020 05:40:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-30T13:31:04)
  Superseding: [v9] add ecspi ERR009165 for i.mx6/7 soc family (2020-06-06T23:21:04):
    [v9,RESEND,01/13] spi: imx: add dma_sync_sg_for_device after fallback from dma
    [v9,RESEND,02/13] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v9,RESEND,03/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v9,RESEND,04/13] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v9,RESEND,05/13] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v9,RESEND,06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v9,RESEND,07/13] spi: imx: fix ERR009165
    [v9,RESEND,08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v9,RESEND,09/13] spi: imx: add new i.mx6ul compatible name in binding doc
    [v9,RESEND,10/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v9,RESEND,11/13] dma: imx-sdma: add i.mx6ul compatible name
    [v9,RESEND,12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
    [v9,RESEND,13/13] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
