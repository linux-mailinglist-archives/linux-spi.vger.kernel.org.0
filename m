Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678AB745FAA
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGCPUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCPUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 11:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AAAFD
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AB360F7B
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 864E3C433C7;
        Mon,  3 Jul 2023 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397621;
        bh=15h7oVoInkClOkOLbxYnzFrevs7p6VzrWlod5AbtRvU=;
        h=Subject:From:Date:To:From;
        b=FzYqfNfxSaOL/3m0TFwVH45aNVSi01EK8NimQEG9grC+ZHbZqfifWgd/c/8/H1qOW
         E7sUZqCjCXAiWA2HZe1nB1Zkkf66YfyWuUlydtvKgK9BRwp4OktT7kLAjouZ4tllQi
         zLfDGt1HAmSuYiEYLBGtFbqYghFNzg063mW85ejgm1LOXS76SDZwGZdnKWR7stXP+2
         ruJ9PW4exzG5bFJsCiPDX4cepKkdRnZVkJFOGs6KOGgPqKLAq8/9RAtldNSOwy0T3X
         XqVFAlSAibqP6mIWh7nZuiYS+7B6wjW+1N9C9IHU2m1+gXn6HTfYdcLQw3l4sVT2l4
         i4uiaci9c4pzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E1BC64457;
        Mon,  3 Jul 2023 15:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168839762133.16555.17785465385781186413.git-patchwork-summary@kernel.org>
Date:   Mon, 03 Jul 2023 15:20:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rzv2m-csi: Fix SoC product name
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761951
  Lore link: https://lore.kernel.org/r/89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


