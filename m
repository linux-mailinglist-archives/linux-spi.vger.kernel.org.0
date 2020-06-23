Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390F0205AF1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgFWSkW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 14:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733193AbgFWSkV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 14:40:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592937621;
        bh=jY+F3hHgkItoUhJBCyJc7b3uxptE3jF1A4FmnVCt48Y=;
        h=Subject:From:Date:To:From;
        b=2fPrjvbhkc5nHqZ3kPT9LDHpvx9sa+4COlpISvezJmBNen82eGbgqdpcdYx6/XwLL
         B3m9b8jMFLB+DIZK6DIRPge3HUNVaedU9rXedh6rD9PpbBx3f6yG8Q/Qbq85Dwyr1b
         sucJO70179/zyWpB3bjU9Gt85Xn1kIwgWXM9xeeI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159293762160.8733.9084361964941071506.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 23 Jun 2020 18:40:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] mtd: spi-nor: add xSPI Octal DTR support (2020-06-23T18:30:13)
  Superseding: [v9] mtd: spi-nor: add xSPI Octal DTR support (2020-05-25T09:15:26):
    [v9,01/19] spi: spi-mem: allow specifying whether an op is DTR or not
    [v9,02/19] spi: spi-mem: allow specifying a command's extension
    [v9,03/19] spi: atmel-quadspi: reject DTR ops
    [v9,04/19] spi: spi-mtk-nor: reject DTR ops
    [v9,05/19] mtd: spi-nor: add support for DTR protocol
    [v9,06/19] mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
    [v9,07/19] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
    [v9,08/19] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
    [v9,09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
    [v9,10/19] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
    [v9,11/19] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
    [v9,12/19] mtd: spi-nor: core: enable octal DTR mode when possible
    [v9,13/19] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
    [v9,14/19] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
    [v9,15/19] mtd: spi-nor: core: perform a Soft Reset on shutdown
    [v9,16/19] mtd: spi-nor: core: disable Octal DTR mode on suspend.
    [v9,17/19] mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
    [v9,18/19] mtd: spi-nor: spansion: add support for Cypress Semper flash
    [v9,19/19] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
