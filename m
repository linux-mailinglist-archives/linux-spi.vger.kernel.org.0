Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602E8184BE4
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 17:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMQAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 12:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgCMQAP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Mar 2020 12:00:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584115215;
        bh=eKmSW2w6/PNXsrj/J9aLIXUcZNKsKJy08vA6BQ+DDjQ=;
        h=Subject:From:Date:To:From;
        b=YTPk5p2asNTh4D3ZYv8KLZF5oxNO1u+7lijIA+zTn8Yjg9S2ckMhrjOrGcG0yEPIp
         XKKZPCGsNveJ5q7JkiOAf/urTL3QwsipHa3UFqeq44D670/JQ/KcRw6W3PdO43y4Fh
         OzLT7aVLDbkwC8qq7NnMGJNVRVJBCu5qTlsjBJKs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158411521497.4382.15706475138133789417.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 13 Mar 2020 16:00:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spi-nor: add xSPI Octal DTR support (2020-03-13T15:46:33)
  Superseding: [v2] mtd: spi-nor: add xSPI Octal DTR support (2020-02-26T09:36:52):
    [v2,01/11] dt-bindings: spi: allow expressing DTR capability
    [v2,02/11] spi: set mode bits for "spi-rx-dtr" and "spi-tx-dtr"
    [v2,03/11] spi: spi-mem: allow specifying whether an op is DTR or not
    [v2,04/11] spi: spi-mem: allow specifying a command's extension
    [v2,05/11] spi: cadence-quadspi: Add support for octal DTR flashes
    [v2,06/11] mtd: spi-nor: add support for DTR protocol
    [v2,07/11] mtd: spi-nor: get command opcode extension type from BFPT
    [v2,08/11] mtd: spi-nor: parse xSPI Profile 1.0 table
    [v2,09/11] mtd: spi-nor: use dummy cycle and address width info from SFDP
    [v2,10/11] mtd: spi-nor: enable octal DTR mode when possible
    [v2,11/11] mtd: spi-nor: add support for Cypress Semper flash


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
