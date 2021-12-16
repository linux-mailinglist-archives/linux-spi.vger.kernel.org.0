Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A347712D
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLPL5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhLPL5Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:57:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E133C061574
        for <linux-spi@vger.kernel.org>; Thu, 16 Dec 2021 03:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60216B823B1
        for <linux-spi@vger.kernel.org>; Thu, 16 Dec 2021 11:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B3CDC36AE3;
        Thu, 16 Dec 2021 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639655834;
        bh=ghYOuXIKu/nZpLwlBXKe+04RmsxIPTSk9IoD3Si7gto=;
        h=Subject:From:Date:To:From;
        b=gH5c6ySitMXpvocz7+Ug7heUKI6E9nMLBZxr7w1+KaSqQ2486YJVFVcVL2SmCKCvg
         U+IrqyNwW7VayfT5oyTZFJcmLujSS/NkaHGTVJ8Pb7+W5wKSY1/fta3tsUU3XuJIFK
         T1axVLu8iPe9GIG5W2q/ftthmSp+44kWu2DPQunPGSaAM07mjOtSRBTGTxTGITQ5Ug
         IOMYiTDKQnacRsOgKk47oicgLlu1MB1vfrtH4b/kU8b6FLsMuQXD0jxt/t3Nd/ZExT
         Ch9E3DnIh6IshSHPHhA5EvRgsE6jDooxj97mkQFy3oHn9CPsS7V1/ZDIVXRdNEPcRi
         oxrK3qRgUHNOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E194B60A12;
        Thu, 16 Dec 2021 11:57:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163965583386.27276.10785208623741762436.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 16 Dec 2021 11:57:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] External ECC engines & Macronix support (2021-12-16T11:16:26)
  Superseding: [v4] External ECC engines & Macronix support (2021-12-09T17:40:34):
    [v4,01/12] mtd: nand: mxic-ecc: Support SPI pipelined mode
    [v4,02/12] mtd: spinand: Delay a little bit the dirmap creation
    [v4,03/12] spi: spi-mem: Create a helper to gather all the supports_op checks
    [v4,04/12] spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
    [v4,05/12] spi: spi-mem: Export the spi_mem_generic_supports_op() helper
    [v4,06/12] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v4,07/12] spi: mxic: Fix the transmit path
    [v4,08/12] spi: mxic: Create a helper to configure the controller before an operation
    [v4,09/12] spi: mxic: Create a helper to ease the start of an operation
    [v4,10/12] spi: mxic: Add support for direct mapping
    [v4,11/12] spi: mxic: Use spi_mem_generic_supports_op()
    [v4,12/12] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

