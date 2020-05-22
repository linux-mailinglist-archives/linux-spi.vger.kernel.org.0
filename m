Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B576E1DF29C
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgEVXAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 19:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVXAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 19:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590188417;
        bh=+zlqPxTDD7GpGNM0d8Giged+6/1AXTXepU4NG3K9zdQ=;
        h=Subject:From:Date:To:From;
        b=1SQsOf7ySs/dT0wK1vXuCyCp01B6MUqCdkj8TfEmVKjnInJwxB9/K7zPovHhnGmJf
         pLp5Sun5GgTKUsNgEkjEry7TD4iUmRBNeEV7hL/VQZjcMvVraeN7cCRdEqt3pJQvvy
         FcFtkO+YPjPwiwNRWs8nJBqTgoUkOExM+iI1UJIw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159018841742.26276.9583303308031603643.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 22 May 2020 23:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] mtd: spi-nor: add xSPI Octal DTR support (2020-05-22T22:40:24)
  Superseding: [v7] mtd: spi-nor: add xSPI Octal DTR support (2020-05-22T10:12:43):
    [v7,01/20] spi: spi-mem: allow specifying whether an op is DTR or not
    [v7,02/20] spi: spi-mem: allow specifying a command's extension
    [v7,03/20] spi: atmel-quadspi: reject DTR ops
    [v7,04/20] spi: spi-mtk-nor: reject DTR ops
    [v7,05/20] spi: mxic: Avoid endianness problems with 2-byte opcodes
    [v7,06/20] mtd: spi-nor: add support for DTR protocol
    [v7,07/20] mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
    [v7,08/20] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
    [v7,09/20] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
    [v7,10/20] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
    [v7,11/20] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
    [v7,12/20] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
    [v7,13/20] mtd: spi-nor: core: enable octal DTR mode when possible
    [v7,14/20] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
    [v7,15/20] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
    [v7,16/20] mtd: spi-nor: core: perform a Soft Reset on shutdown
    [v7,17/20] mtd: spi-nor: core: disable Octal DTR mode on suspend.
    [v7,18/20] mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
    [v7,19/20] mtd: spi-nor: spansion: add support for Cypress Semper flash
    [v7,20/20] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
