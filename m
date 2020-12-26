Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E132E2DDC
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLZJ50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Dec 2020 04:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgLZJ50 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 26 Dec 2020 04:57:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E0623206DB;
        Sat, 26 Dec 2020 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608976605;
        bh=8CFJDSNc/JF2VJ+3+tt56gDsJyJqgLf8aDNQcoj2xow=;
        h=Subject:From:Date:To:From;
        b=CbE8ffXZYRak7CXXbex3/v14TpuJKPkDBFGCszvuDqbSQJmwqcpzuLCBU4KycVhah
         d4Ib1UcioUZyY0OSEMLudqsC1YcW65eUmF4pxSSEpzxSBEBBH5u+HnSpEBz43UzB1q
         Zc7hAF5CzXmNJsqRbaZ4LFpf3i8yjIvm54ku7QYmulLG7nnOlLmLsFNC2X8nzXTa6m
         28UMlvFtWd+1uKOYTwGxtW2nSjdSqdJQwx8lGMmchGCP9sG81ZouGsHBdiA//3PBIk
         mqefdK2Z+02nqQswpuE4koAF6dH0Gt9aOWvC//azrQ8sUm3cHkPgUCBlpRIt2n63k+
         O8kNDd8lv6ZUw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id CD1FB600AE;
        Sat, 26 Dec 2020 09:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160897660577.9817.13570831154669995608.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 26 Dec 2020 09:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-26T09:12:00)
  Superseding: [v4] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-25T10:35:51):
    [v4,1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
    [v4,2/4] spi: ls7a: Add YAML schemas
    [v4,3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
    [v4,4/4] MIPS: Loongson: Enable Loongson LS7A SPI in loongson3_defconfig


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

