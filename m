Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD531DE41E
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgEVKUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 06:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgEVKUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 06:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590142818;
        bh=gNwERGYJk5xqVKpKLgWmBy9SJ/bj2nY8RWZ0z/PV72g=;
        h=Subject:From:Date:To:From;
        b=Kn19EAmKQFUZVOjj250xg319465GjpJXIBnZySH+9OyJaqo15lPxZ0fDbFuzcmhDs
         Fj/49iCsra+RzkkoUZmZbNL+leh1tXHeZk/rVFWrnGeJDGM5kv9tN9XuCRXtlruECu
         lvCyJqAnjT2TqtKYrQ33FJ78BDxMAnXpTK7G5X9A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159014281868.30303.10619442208222678338.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 22 May 2020 10:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] mtd: spi-nor: add xSPI Octal DTR support (2020-05-22T10:12:43)
  Superseding: [v6] mtd: spi-nor: add xSPI Octal DTR support (2020-05-20T16:30:35):
    [v6,01/19] spi: spi-mem: allow specifying whether an op is DTR or not
    [v6,02/19] spi: atmel-quadspi: reject DTR ops
    [v6,03/19] spi: spi-mtk-nor: reject DTR ops
    [v6,04/19] spi: spi-mem: allow specifying a command's extension
    [v6,05/19] mtd: spi-nor: add support for DTR protocol
    [v6,06/19] mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
    [v6,07/19] mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D
    [v6,08/19] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
    [v6,09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
    [v6,10/19] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
    [v6,11/19] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
    [v6,12/19] mtd: spi-nor: core: enable octal DTR mode when possible
    [v6,13/19] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
    [v6,14/19] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
    [v6,15/19] mtd: spi-nor: core: perform a Soft Reset on shutdown
    [v6,16/19] mtd: spi-nor: core: disable Octal DTR mode on suspend.
    [v6,17/19] mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
    [v6,18/19] mtd: spi-nor: spansion: add support for Cypress Semper flash
    [v6,19/19] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
