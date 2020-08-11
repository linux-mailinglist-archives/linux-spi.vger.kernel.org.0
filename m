Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73292417BF
	for <lists+linux-spi@lfdr.de>; Tue, 11 Aug 2020 10:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHKIAT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Aug 2020 04:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKIAS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Aug 2020 04:00:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597132818;
        bh=qdadmVG3yoz7nZd6g284MkEAXapK8FGjHb3TQalPf7I=;
        h=Subject:From:Date:To:From;
        b=SIjJuLrOcVRmiTJxEWthpswimCfTvn265dUaF15aKjE5J7ch2lJc3Cg5ZDfZglQ5d
         pfEyJlPee0Qya53QjXTk7QjefaQy1M2z4ATiClQQ9QxQRMgPmNdgTciNhgfYLfjGau
         6Vp+qRSD0eduelckE+lu4z/icQ8Lj6osZwXru9CI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159713281827.3710.5087931209150205227.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 11 Aug 2020 08:00:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v12] add ecspi ERR009165 for i.mx6/7 soc family (2020-08-11T15:53:39)
  Superseding: [v11] add ecspi ERR009165 for i.mx6/7 soc family (2020-07-24T18:51:13):
    [v11,01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
    [v11,02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
    [v11,03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
    [v11,04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
    [v11,05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
    [v11,06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
    [v11,07/12] spi: imx: fix ERR009165
    [v11,08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
    [v11,09/12] spi: imx: add new i.mx6ul compatible name in binding doc
    [v11,10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
    [v11,11/12] dma: imx-sdma: add i.mx6ul compatible name
    [v11,12/12] dmaengine: imx-sdma: add uart rom script


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
