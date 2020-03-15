Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232CC185984
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCODAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 23:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCODAO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 14 Mar 2020 23:00:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584241214;
        bh=ugDvYOt4tDKMdAUVnobQjAr6FyIHUaWBwZ4gcpzahLw=;
        h=Subject:From:Date:To:From;
        b=DG+aXlndT9eluoWbSUymlCGkcpj8uUS93+59UdYt9sjQPBrluNzUuS/9tNiKX8KIL
         kVeDv3OeHa3N9AS//gNFw58UsfBQOwCKEbj3jmjqbwoo4dlyv3mn7BiVxUTcV6hzw9
         MsYw1z5wbHlQQDVky0vyv/0ALMXVMgmgtCn8M04o=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158424121418.16197.10554870167974805258.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 15 Mar 2020 03:00:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] NXP DSPI bugfixes and support for LS1028A (2020-03-14T22:43:28)
  Superseding: [v3] NXP DSPI bugfixes and support for LS1028A (2020-03-10T12:55:42):
    [v3,1/7] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
    [v3,2/7] spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
    [v3,3/7] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
    [v3,4/7] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
    [v3,5/7] spi: spi-fsl-dspi: Add support for LS1028A
    [v3,6/7] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
    [v3,7/7] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
