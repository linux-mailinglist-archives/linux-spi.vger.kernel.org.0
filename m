Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71322E684D
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgL1QfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 11:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgL1QfD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 11:35:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D060E207B7;
        Mon, 28 Dec 2020 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609173262;
        bh=7AFcWj/e8Ax8jiGac/DUlawI2dU4E9bHvKG/Sp1oAsw=;
        h=Subject:From:Date:To:From;
        b=XNfXhOjPHyLf9UzlhlPqAkYOBQINDMIu6W/wIatlMI95Rg1kBPBgBDNtexanhLTT3
         0zAtZpLlxtfeGsajkNEN/mCKTtcFqU6XCSMXtTVAX3DazqVQ+pbD61QUf2O84wU3/z
         WnkFWmgmGPmOFWmkME5dyyTpTrzGJ5hk5sF/a/MwPxFAtjMfdRcj1m7ZJC4uBRSwlU
         3YBzZ2S26KiH7NZ4FfGyCyaDjwdlQ9atxKizJXEuxuCmPq5E0ibDISz/3tUSt7rqUn
         lkl2HuSiNper761jvXmEnjD0IocLLJKcEkZPCTdhHe89AQ2yIBcmIQ+UUxCCkfgjMb
         EJMK2tBt5W64Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id BD543600D9;
        Mon, 28 Dec 2020 16:34:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160917326270.16062.3204042541308103137.git-patchwork-summary@kernel.org>
Date:   Mon, 28 Dec 2020 16:34:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v1] Input: touchscreen: ads7846.c: fix integer overflow on Rt calculation
  Submitter: Oleksij Rempel <o.rempel@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=383551
  Lore link: https://lore.kernel.org/r/20201113112240.1360-1-o.rempel@pengutronix.de
Series: [v6,1/3] spi: uapi: unify SPI modes into a single spi.h header
  Submitter: Alexandru Ardelean <alexandru.ardelean@analog.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=404879
  Lore link: https://lore.kernel.org/r/20201221152936.53873-1-alexandru.ardelean@analog.com
    Patches: [v6,1/3] spi: uapi: unify SPI modes into a single spi.h header
             [v6,2/3] spi: Add SPI_NO_TX/RX support
             [v6,3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


