Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B331892CC
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCRAUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCRAUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Mar 2020 20:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584490814;
        bh=ypNw5mT60zwYGkuzwzU03VYGTe+T9/d7QQ5DfPb5gmE=;
        h=Subject:From:Date:To:From;
        b=G1+CYTeMgv4mITCUIssVtwCbE2q/YoMn10o0FWuorvQwlle8lMhU2D6XjsIxTouG6
         UUk8GqV9boeEYgSwOOfLFlxoXLYSofox/AvDfbQyqcC6RIv0e0TcMEMF8yit4fXID8
         JtRziCbie9+NAR0pPpUkRh9P+gerHhtIsbMuC98U=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158449081446.11775.5459057414285589247.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 18 Mar 2020 00:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] NXP DSPI bugfixes and support for LS1028A (2020-03-18T00:15:55)
  Superseding: [v3] NXP DSPI bugfixes and support for LS1028A (2020-03-14T22:43:28):
    [v3,01/12] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
    [v3,02/12] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
    [v3,03/12] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
    [v3,04/12] spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
    [v3,05/12] spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
    [v3,06/12] spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion
    [v3,07/12] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
    [v3,08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
    [v3,09/12] spi: spi-fsl-dspi: Move invariant configs out of dspi_transfer_one_message
    [v3,10/12] spi: spi-fsl-dspi: Add support for LS1028A
    [v3,11/12] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
    [v3,12/12] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
