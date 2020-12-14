Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92B2D9367
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 07:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438813AbgLNG5v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 01:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438805AbgLNG5l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 01:57:41 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607929019;
        bh=E+ixzZ5GTgn5ayWdXZISjO8L2xqCBUJoRQ8yqDPEdOU=;
        h=Subject:From:Date:To:From;
        b=ZW+4MF5ccHRdAEzsuTxLkl4mySpunwwA5Vk116lpjhMCb8sF7dSM/smuKKu3BIsRt
         8qicDuiOkr41pyPvuk8Rjs8suMsbAOUDC1+X25n2k1ZAYgkqH+yLdpdWxCSEfJ9Bub
         QSK1X7e7eUs9ankpNXtR1pWVBOTd6pSQcfjY613mCpdC4VD9U39dm/QqAQNJ6qPbyX
         rGoMnqVqIlMTj7D2Zr0CO3DozwNHVxbNFjyx1ZzPfKqcVI4dG2MEt5VvzmoG+yNahd
         OfBLsr5u55BM/h7edhftOcuW0BZXynNu0nr/37Yiak06BhzSwGswgwTJ6U+DgAIF5R
         2WA2AFjJyD2kg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160792901885.6795.14591365977687579475.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 14 Dec 2020 06:56:58 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-14T05:58:51)
  Superseding: [v2] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-08T07:44:25):
    [v2,1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
    [v2,2/4] spi: Add devicetree bindings documentation for Loongson SPI
    [v2,3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
    [v2,4/4] MIPS: Loongson: Enable Loongson LS7A SPI in loongson3_defconfig


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

