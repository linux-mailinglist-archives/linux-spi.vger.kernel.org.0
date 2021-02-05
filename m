Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4829E31124A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhBESit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 13:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233282AbhBESiZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 13:38:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DB5064FBB;
        Fri,  5 Feb 2021 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612556409;
        bh=snrp1mO3Ut30lAMus1qLgOBuJdb2+ZmdVIx0qOdVudE=;
        h=Subject:From:Date:To:From;
        b=JgNow/lsMK22D06itcKq7p1++4/GiYHngN0i6QML6goPZvR0aGuayYjvvOg68jvVp
         bxWl1YPm+XZEFGWiiietNS3A8b/ZFJFcBYP0Iddfg4v1Pu/7u6zspD8uKn6KIBPllM
         bcnptUinWfdPCFbZ80gYQzmUiGdddduaNuC3SF1Y2sARCuHvy6EzJq04GLpIJgWPv4
         aSq1aJUpNs6AgWwCqrY3Rthx5+O5z0bZeYRRtUcK3SNIlweivIDd0V7ff7RxkFiokD
         5WqjpO5WyrxN+iSjTnYqzjZj7Pbynv7gAW8HPqxG3zis2GZvuFuUAnvStIMzQWZZx8
         vBsQt9LJEbW/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 42C44609F2;
        Fri,  5 Feb 2021 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161255640921.8766.5533021941290187644.git-patchwork-summary@kernel.org>
Date:   Fri, 05 Feb 2021 20:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: stm32: fix and enhancements for spi-stm32
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=428915
  Lore link: https://lore.kernel.org/r/1612551572-495-1-git-send-email-alain.volmat@foss.st.com
    Patches: [v2,1/8] spi: stm32: properly handle 0 byte transfer
             [v2,2/8] spi: stm32: do not mandate cs_gpio
             [v2,3/8] spi: stm32: use bitfield macros
             [v2,4/8] spi: stm32h7: ensure message are smaller than max size
             [v2,5/8] spi: stm32: driver uses reset controller only at init
             [v2,6/8] spi: stm32: defer probe for reset
             [v2,7/8] spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC
             [v2,8/8] spi: stm32: make spurious and overrun interrupts visible

Total patches: 8

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


