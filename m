Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8D750CC3
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjGLPkg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jul 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjGLPk3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jul 2023 11:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A301FC7
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 08:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC10E6187C
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 15:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CB3AC433B9;
        Wed, 12 Jul 2023 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176425;
        bh=3Mo3/4xBtc1TtCgqmRnALrbKALd7kqLtYuUCa6Q/rck=;
        h=Subject:From:Date:To:From;
        b=jOHtt0xnpvQV5GHOsR6aCzC2mohp14mtOGdT4e2iRVp8vSD2N6rtY1FfenoUSLgu4
         e2hllr6zRfaxHdlD96Djkm4+9f6BbEWOHt6azqBA0h2LFWkEJUh/ABWCCe4P9qfOaW
         YdPTwMgB49yN41c/hVlpFLo3xXy8F0OFOyW1b/vR31Smo8b+ftwTU3gKjDIaoiKrEM
         M08UQP9YYKakvaoOlLJGr+o2yRij4Do2P18ByIP8O1A227w3A60s2btqQLMMgnrq5y
         Rgl2I4jjEETQoIWEGfQ0a6/Nch8X8NgCp5wuuFFaOLnTY31tbXVJoBpGeX1MlWOpkZ
         RhU5DWKq5pw5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE6F8C4167B;
        Wed, 12 Jul 2023 15:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168917642474.14200.9905524493000842342.git-patchwork-summary@kernel.org>
Date:   Wed, 12 Jul 2023 15:40:24 +0000
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

Series: [v2,1/2] MAINTAINERS: add myself for spi-bcm63xx
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=763660
  Lore link: https://lore.kernel.org/r/20230708195309.72767-1-jonas.gorski@gmail.com
    Patches: [v2,1/2] MAINTAINERS: add myself for spi-bcm63xx
             [v2,2/2] mailmap: add entry for Jonas Gorski

Patch: spi: s3c64xx: clear loopback bit after loopback test
  Submitter: Jaewon Kim <jaewon02.kim@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=764314
  Lore link: https://lore.kernel.org/r/20230711082020.138165-1-jaewon02.kim@samsung.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


