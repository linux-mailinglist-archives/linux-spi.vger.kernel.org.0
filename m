Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A902F252B
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 02:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbhALA5X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 19:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbhALA5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 19:57:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A7ACA22510;
        Tue, 12 Jan 2021 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610413002;
        bh=5fslk7pCVIU1YCdQKGH2pt3ol3IapqWzyPxHkPgJVAk=;
        h=Subject:From:Date:To:From;
        b=pRSqQF5Xm/JXGX6b5O3JxXalVmu7MZvyeDL5UnfQHHGwKWolZNz42ikSeG/pTf5eI
         SUuIzFnoy/hBkblHPO9ECYVF/S/4ghvxDY/IAWQiU9eS7b7Y2yYknZsj7HG04ycWkQ
         jPWgmHtuvM/2zk+ETIuaLSDa+IeXRuCOtd6jysGM0Nz3Nn3x8ige3Qkl5Oud88RinZ
         DArmXrOnpW+RT0VKrgyZKaOrk2vk81uQBGpTELcdzlmBy8P20kC6ruojQ5Yr0j59mn
         u4t7HfzXwWXzuBkghT/JekRGfhikv+cbo5Kg9PZ/2dek6YhyFeoGNUuj5RjeSa9Kzc
         fhLX8sGxc23Xw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id A2F5F6013D;
        Tue, 12 Jan 2021 00:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161041300265.11911.10478261077035037099.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 12 Jan 2021 00:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-qcom-qspi: Use irq trigger flags from firmware (2021-01-12T00:13:01)
  Superseding: [v1] spi: spi-qcom-qspi: Use irq trigger flags from firmware (2020-12-13T05:29:48):
    spi: spi-qcom-qspi: Use irq trigger flags from firmware


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

