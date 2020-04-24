Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2D1B7E75
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgDXTAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 15:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXTAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 15:00:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587754816;
        bh=gCdkO4dsfzc67MLfvVbuq7Tg5l0+rbtqM9T4F8feKPs=;
        h=Subject:From:Date:To:From;
        b=hohOgoSQrawySSONnyBCtmS2BJ2PaBilEdl5U6uU60myoEfVGB8ZQ14+UD34maYuy
         77btvDCraO8wMzCjbtnkFf45u3UHs5garlXiJ6YcptvwoHH5Rrv34tgSHTvSBIgeuo
         7aAvuDjGbyQLaaoCqiytNcTZrm7c1pjKcGL4YlnI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158775481655.18320.11315524796504827195.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Apr 2020 19:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] mtd: spi-nor: add xSPI Octal DTR support (2020-04-24T18:43:55)
  Superseding: [v3] mtd: spi-nor: add xSPI Octal DTR support (2020-03-13T15:46:33):
    [v3,01/12] spi: spi-mem: allow specifying whether an op is DTR or not
    [v3,02/12] spi: atmel-quadspi: reject DTR ops
    [v3,03/12] spi: spi-mem: allow specifying a command's extension
    [v3,04/12] mtd: spi-nor: add support for DTR protocol
    [v3,05/12] mtd: spi-nor: default to address width of 3 for configurable widths
    [v3,06/12] mtd: spi-nor: get command opcode extension type from BFPT
    [v3,07/12] mtd: spi-nor: parse xSPI Profile 1.0 table
    [v3,08/12] mtd: spi-nor: use dummy cycle and address width info from SFDP
    [v3,09/12] mtd: spi-nor: enable octal DTR mode when possible
    [v3,10/12] mtd: spi-nor: perform a Soft Reset on shutdown
    [v3,11/12] mtd: spi-nor: Disable Octal DTR mode on suspend.
    [v3,12/12] mtd: spi-nor: add support for Cypress Semper flash


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
