Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5A286BE1
	for <lists+linux-spi@lfdr.de>; Thu,  8 Oct 2020 01:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJGX5d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Oct 2020 19:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgJGX5d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Oct 2020 19:57:33 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602115053;
        bh=H9JrjGRQUIS+IyMJI4boGfJvO4kKVWrxSkrQkk1gR3E=;
        h=Subject:From:Date:To:From;
        b=N+hTZcAqhDa+60nHmWtC+crILyitb8D9HnLQOuXcJwJcGoH8EzLMyBplx2hMycz9x
         oxOyXs0Ts0M+HHvGT0t10OfT8XDtLZPo3Tj/f6b/I9lodvOspx2NPl4qp4Lq8Iz7Zd
         r/OrcAPhrd/Gmy7yckIvRdq3/ZzzLG+AzMcEIfP0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160211505318.20335.5726699008406953003.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 07 Oct 2020 23:57:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-10-07T23:54:55)
  Superseding: [v3] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-10-01T22:28:09):
    [v3,01/21] spi: dw: Use an explicit set_cs assignment
    [v3,02/21] spi: dw: Add DWC SSI capability
    [v3,03/21] spi: dw: Detach SPI device specific CR0 config method
    [v3,04/21] spi: dw: Update SPI bus speed in a config function
    [v3,05/21] spi: dw: Simplify the SPI bus speed config procedure
    [v3,06/21] spi: dw: Update Rx sample delay in the config function
    [v3,07/21] spi: dw: Add DW SPI controller config structure
    [v3,08/21] spi: dw: Refactor data IO procedure
    [v3,09/21] spi: dw: Refactor IRQ-based SPI transfer procedure
    [v3,10/21] spi: dw: Perform IRQ setup in a dedicated function
    [v3,11/21] spi: dw: Unmask IRQs after enabling the chip
    [v3,12/21] spi: dw: Discard chip enabling on DMA setup error
    [v3,13/21] spi: dw: De-assert chip-select on reset
    [v3,14/21] spi: dw: Explicitly de-assert CS on SPI transfer completion
    [v3,15/21] spi: dw: Move num-of retries parameter to the header file
    [v3,16/21] spi: dw: Add generic DW SSI status-check method
    [v3,17/21] spi: dw: Add memory operations support
    [v3,18/21] spi: dw: Introduce max mem-ops SPI bus frequency setting
    [v3,19/21] spi: dw: Add poll-based SPI transfers support
    [v3,20/21] dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
    [v3,21/21] spi: dw: Add Baikal-T1 SPI Controller glue driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

