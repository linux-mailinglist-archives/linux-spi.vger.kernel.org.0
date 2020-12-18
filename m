Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E42DE8EF
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 19:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgLRSas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 13:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgLRSar (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Dec 2020 13:30:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608316207;
        bh=c0JziN092zELgSAKguPJZHXXfeQvtXswTLtR01bk1PE=;
        h=Subject:From:Date:To:From;
        b=YLBUA9ijHUcoxOXmR0YgvBaDb/0GbDwHNi+7CQFHyB1seMcVKc/R9xfopOLVjCimL
         2AiOJrtfVz0wAnfgEqFKdTYZFMBpmQ6dYeN6AKAuM1tsDVgK3cIRsBVHajpGkUIUQZ
         tV7pkfh4sLPsGGD3DhWh1A+bSw58bF9XqGvkBm6epc8VP83Z8Yh5r1Kq7lnhleaPRu
         nz2Yar+x0YsnCLx9WqX6Hdone5ysr8FLwSkAxq8vknelFqxhm5yvA9kJMIH8lCgYCI
         GE2nzIH7QuweCDeYMekCd7c7+z9jpyo0cns8g+F5Il1JAy/a2EtznokQQX9GofyVpG
         y0JvsoV6+tFQQ==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160831620721.20028.16461320549204924285.git-patchwork-summary@kernel.org>
Date:   Fri, 18 Dec 2020 18:30:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v3,1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
  Submitter: Douglas Anderson <dianders@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=403853
  Lore link: https://lore.kernel.org/r/20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid
    Patches: [v3,1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
             [v3,2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
             [v3,3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
             [v3,4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


