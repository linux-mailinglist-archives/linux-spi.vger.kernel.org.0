Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09C3E2044
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHFAuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhHFAuW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:50:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F405160F14;
        Fri,  6 Aug 2021 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628211008;
        bh=kW82xdiAd0AB5VYV8pTqYsL3xMHt4TAs6OR5+eXOiLc=;
        h=Subject:From:Date:To:From;
        b=M4WCfOgquOJegzCQXLGG1bJNGjVZxApid1ikWAkq4wX/62RS9sZFAVHw61OeMJ9f9
         BfJwh/jKztuaAlZ+AfxxHNERBWXmkByRjTKJp2fId84H/+24Z7uhOi1S4XXoSbdRD6
         AcAITUMVQzSl4Sx+sLqF3/6FZO1fhBk/6XWO+oaql1l/wuk6UG0eImg5GYDg27ujTk
         phyVZySXHZvxXNAjSFl3nVwntC/Uv2+CbOs5z10PpjB1/BCghqvIsYug2shX6Fgk3L
         Q74WOJIpjWj9KE+88SLh1hSl7BbrO++RnAO+LWZHLilK1KhKHxTzrNvskIR6ewfcNe
         3Ygn8nzYISRgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DF9CD60A48;
        Fri,  6 Aug 2021 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162821100785.31818.3373519278582576441.git-patchwork-summary@kernel.org>
Date:   Fri, 06 Aug 2021 00:50:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi cs_timing restructure
  Submitter: Mason Zhang <Mason.Zhang@mediatek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=526311
  Lore link: https://lore.kernel.org/r/20210804133630.18519-1-Mason.Zhang@mediatek.com
    Patches: [v3,1/2] spi: move cs spi_delay to spi_device
             [v3,2/2] spi: modify set_cs_timing parameter

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


