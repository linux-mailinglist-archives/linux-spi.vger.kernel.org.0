Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CAF17EB0C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgCIVUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgCIVUO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 17:20:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583788814;
        bh=6C6cP9XqHTuK3/nIAdGzopxEuRYdQCVlWlDeRg9qUjw=;
        h=Subject:From:Date:To:From;
        b=mclmGZEoZ8zV4TsCUq9LGStVEp9hLHITMrV0eDNe3aEepjZwJ+o4k+HOC8GdT16N5
         +gUbXzIPq35+tTHrjMOfQKVR5T6mcw7ogcTI4dHSB/VB2+tTprUczuLZkipESawju2
         wCRg/JQcQWL/AN7LwTigd2v8KPsXLDKWaSaf1Sjg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158378881434.15796.13751522925264385935.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Mar 2020 21:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] NXP DSPI bugfixes and support for LS1028A (2020-03-09T21:07:49)
  Superseding: [v1] NXP DSPI bugfixes and support for LS1028A (2020-03-09T14:56:18):
    [1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
    [2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
    [3/6] spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
    [4/6] spi: spi-fsl-dspi: Add support for LS1028A
    [5/6] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
    [6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
