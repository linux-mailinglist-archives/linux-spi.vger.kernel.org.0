Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31571DB9D8
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETQkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 12:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETQkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 12:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589992816;
        bh=A5Y0ncyMmVmVV+EpwrSMenB5gyCEBneYSgF/lvl6jqQ=;
        h=Subject:From:Date:To:From;
        b=JW6oaxadgjL0l4EZ38VOVBQBd0x3NXJZsHbpiL7RmPixS7YPiI5ZJTWzRoZx0Yogv
         tOWkQV/gqxi91w/ew63Z+BsMh25Yfi2RtmKAjI4ALVDax9X6+wFoLK2wulD94RTRwG
         hu7Udd6TZgNr0819N5AyWkxg6kARBISs/rp+NzR8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158999281645.7215.15843174379327344931.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 May 2020 16:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] mtd: spi-nor: add xSPI Octal DTR support (2020-05-20T16:30:35)
  Superseding: [v5] mtd: spi-nor: add xSPI Octal DTR support (2020-05-19T14:26:22):
    [v5,01/19] spi: spi-mem: allow specifying whether an op is DTR or not
    [v5,02/19] spi: atmel-quadspi: reject DTR ops
    [v5,03/19] spi: spi-mtk-nor: reject DTR ops
    [v5,04/19] spi: spi-mem: allow specifying a command's extension
    [v5,05/19] mtd: spi-nor: add support for DTR protocol
    [v5,06/19] mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
    [v5,07/19] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
    [v5,08/19] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
    [v5,09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
    [v5,10/19] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
    [v5,11/19] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
    [v5,12/19] mtd: spi-nor: core: enable octal DTR mode when possible
    [v5,13/19] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
    [v5,14/19] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
    [v5,15/19] mtd: spi-nor: core: perform a Soft Reset on shutdown
    [v5,16/19] mtd: spi-nor: core: disable Octal DTR mode on suspend.
    [v5,17/19] mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
    [v5,18/19] mtd: spi-nor: spansion: add support for Cypress Semper flash
    [v5,19/19] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
