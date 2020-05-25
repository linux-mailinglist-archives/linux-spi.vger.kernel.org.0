Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564C1E0A29
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbgEYJUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 05:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbgEYJUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 05:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590398419;
        bh=sraMLAOmgALiiHwRkUwrHF2eR/MGb0iAYIa798RhtbA=;
        h=Subject:From:Date:To:From;
        b=YiVbnMEkhQpeSDnjCX48ZOqIRYIYeddOc5jTdKH05szT+4V3Ko0rzv7tLLAdkhf8p
         ANHeeYatxAGPqIDe81Ys+Na4WoyZ4W3iVPFqgIsvtWXiNq/S5QhSSVNIcXUzohSHJV
         OlCTsGGpRilI+WNr1Xg0m6BlbR7+7uDhdXnl2HkQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159039841908.11849.251053226826224881.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 25 May 2020 09:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] mtd: spi-nor: add xSPI Octal DTR support (2020-05-25T09:15:26)
  Superseding: [v8] mtd: spi-nor: add xSPI Octal DTR support (2020-05-22T22:40:24):
    [v8,01/19] spi: spi-mem: allow specifying whether an op is DTR or not
    [v8,02/19] spi: spi-mem: allow specifying a command's extension
    [v8,03/19] spi: atmel-quadspi: reject DTR ops
    [v8,04/19] spi: spi-mtk-nor: reject DTR ops
    [v8,05/19] mtd: spi-nor: add support for DTR protocol
    [v8,06/19] mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
    [v8,07/19] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
    [v8,08/19] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
    [v8,09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
    [v8,10/19] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
    [v8,11/19] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
    [v8,12/19] mtd: spi-nor: core: enable octal DTR mode when possible
    [v8,13/19] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
    [v8,14/19] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
    [v8,15/19] mtd: spi-nor: core: perform a Soft Reset on shutdown
    [v8,16/19] mtd: spi-nor: core: disable Octal DTR mode on suspend.
    [v8,17/19] mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
    [v8,18/19] mtd: spi-nor: spansion: add support for Cypress Semper flash
    [v8,19/19] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
