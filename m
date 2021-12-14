Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B460474382
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhLNNaK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 08:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhLNNaK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 08:30:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D96C061574
        for <linux-spi@vger.kernel.org>; Tue, 14 Dec 2021 05:30:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B37614DD
        for <linux-spi@vger.kernel.org>; Tue, 14 Dec 2021 13:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83902C34601;
        Tue, 14 Dec 2021 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488609;
        bh=r8UJ9Hb7HsChaOepZzEiLl5QSal6R/0YYz1HWVO3p2M=;
        h=Subject:From:Date:To:From;
        b=gNY1WI4kQeKwuOOicRGLLN/6xo6TKEvV7BJfSz4RtGO43yTURCwvOZYXK53EeVrFe
         QDgQByHFn0WtIYJOURIEBm1IL6anC11mQoW87KClISG75ZnyA6PQKFhGNSgTQuyBVd
         hSc6AUqVR+1wBcfophXSJNEsKZbktj9FqqJUCwXcocsiGjgLcnNHUpF14G0z8PsuAV
         gT2ANZqtm6PelpW9cNFQkqxnjaQoEweYmeeBPJpdvmHChOjWC6dbje/GJL3eYJdnjn
         qS0mTmb66LTaTTRDRrsbHfzNilWiZdaxGnejOB0eW40N1AuVuctkBumcvImHvOGrsX
         dDpbKmkeiW05g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5B48F609F5;
        Tue, 14 Dec 2021 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163948860931.2047.3142132748031208735.git-patchwork-summary@kernel.org>
Date:   Tue, 14 Dec 2021 13:30:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: Fix incorrect cs_setup delay handling
  Submitter: Hector Martin <marcan@marcan.st>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=593813
  Lore link: https://lore.kernel.org/r/20211210170534.177139-1-marcan@marcan.st


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


