Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A461D9A2C
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgESOkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 10:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgESOkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 May 2020 10:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589899216;
        bh=rvi8nrSSuUFebN7iVgwwDMlSXVZAabpKQmbHGI9OwDY=;
        h=Subject:From:Date:To:From;
        b=ST1U4O3hJ4INR05YHtPAOugtOdFW31BktZPRv+NphU71RTogwRB/PNT1BZ3Sr8rAA
         w5gTJ5KlGvwFZEpxhP6aM9rETQVpMgM3brTjouVPRjV9M+XcbkFQtgOWX8+suwUvDI
         6x7i97Nqc3bO5s4LE/AI817VPiXpieCV1Jq0RYR0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158989921646.24901.3680113333276732952.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 May 2020 14:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] mtd: spi-nor: add xSPI Octal DTR support (2020-05-19T14:26:22)
  Superseding: [v4] mtd: spi-nor: add xSPI Octal DTR support (2020-04-24T18:43:55):
    [v4,01/16] spi: spi-mem: allow specifying whether an op is DTR or not
    [v4,02/16] spi: atmel-quadspi: reject DTR ops
    [v4,03/16] spi: spi-mem: allow specifying a command's extension
    [v4,04/16] mtd: spi-nor: add support for DTR protocol
    [v4,05/16] mtd: spi-nor: default to address width of 3 for configurable widths
    [v4,06/16] mtd: spi-nor: prepare BFPT parsing for JESD216 rev D
    [v4,07/16] mtd: spi-nor: get command opcode extension type from BFPT
    [v4,08/16] mtd: spi-nor: parse xSPI Profile 1.0 table
    [v4,09/16] mtd: spi-nor: use dummy cycle and address width info from SFDP
    [v4,10/16] mtd: spi-nor: do 2 byte reads for SR and FSR in DTR mode
    [v4,11/16] mtd: spi-nor: enable octal DTR mode when possible
    [v4,12/16] mtd: spi-nor: perform a Soft Reset on shutdown
    [v4,13/16] mtd: spi-nor: Disable Octal DTR mode on suspend.
    [v4,14/16] mtd: spi-nor: expose spi_nor_default_setup() in core.h
    [v4,15/16] mtd: spi-nor: add support for Cypress Semper flash
    [v4,16/16] mtd: spi-nor: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
