Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FB791D7D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Sep 2023 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbjIDTJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Sep 2023 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjIDTJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Sep 2023 15:09:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF6189
        for <linux-spi@vger.kernel.org>; Mon,  4 Sep 2023 12:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55DF9CE0FA6
        for <linux-spi@vger.kernel.org>; Mon,  4 Sep 2023 19:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BAEAC433C7;
        Mon,  4 Sep 2023 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693854565;
        bh=2TykzwUToxzql8C1Xs6Vrw5iJm5VLfJz3G3KkJ3lUu8=;
        h=Subject:From:Date:To:From;
        b=bm/fUuJAkW8ZLgdY5IDygtWW7LX9G+o3SPMgC0Y5IHmtfzNtKOalE6KwMgPjXHNLN
         E+jJY3IKtD9l/k+XE+hFEvjUxkRD4k2BqodM8yp5N8ar0Nh5q2Q/r65NQnMx4VVCKx
         ngAcHLVNDDQpUZ5ENdlODsiznzMMWv7JjCSNE7SBh3c0jEoQqFaTmYzCxGjZ14Tqmj
         TykP+LvmdohCfk3/h38ne3vuHCZHiC3hRbwJfS75s9Pxs+fqtYc3TsPEX4NkSZWUCs
         SWqvBwRE7XHJ2gncf94jRwhBBXYCtZ4/XhOUYnpZg4+m7r7ysSIcc/obs066zgIEhp
         bvZf0PyWX2BwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6583EC04DD9;
        Mon,  4 Sep 2023 19:09:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169385456529.29220.379404423812436252.git-patchwork-summary@kernel.org>
Date:   Mon, 04 Sep 2023 19:09:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sun6i: fix RX data corruption in DMA mode
  Submitter: Tobias Schramm <t.schramm@manjaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=779748
  Lore link: https://lore.kernel.org/r/20230827152558.5368-1-t.schramm@manjaro.org
    Patches: [1/2] spi: sun6i: reduce DMA RX transfer width to single byte
             [2/2] spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


