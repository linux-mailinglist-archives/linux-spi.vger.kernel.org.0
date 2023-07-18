Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC7757AE7
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jul 2023 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGRLu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jul 2023 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGRLuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 07:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE621B3
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 04:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638286153A
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAB23C433C8;
        Tue, 18 Jul 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689681023;
        bh=IghDZnG96E9BjMVbt1pHsSYRknCFBUumfJcnZ1oTDWE=;
        h=Subject:From:Date:To:From;
        b=RrrM/rNTILIq0c7kKEZCnXzbA2kyxtOzqwTVzJZJ6355VXnM/2qMAMp8pPb7VtrQe
         lAw88zHSGx21yhmlGnnfZ7r+Hdk8hZDqyuwUYPbdoMJtAoEXHuXrL7DoAXa2rZXO8A
         PZ9B3uPfYjenuMlYE+9kmGdXLLLGhOc5XEZ2zeM1RL9KWLbrn+PjsGARgG2fuRI9Ib
         qRIwEQr4PI1mGaxmxZ5cIkFBOYGNofVOiT6OCRc5UomSmFMgSiEVsQrc4I5VuklJQh
         GYMKp7nLLfUVV0oFecwCOjMPg2uSBMpCTm6WmaM5fNJMxWmMqZRvrFmTlZcLfDPe6G
         Llod1DwcFgmQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97A33E22AE0;
        Tue, 18 Jul 2023 11:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168968102352.11806.14674034600974536030.git-patchwork-summary@kernel.org>
Date:   Tue, 18 Jul 2023 11:50:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=766395
  Lore link: https://lore.kernel.org/r/20230717085934.409476-1-alexander.stein@ew.tq-group.com
    Patches: [v2,1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


