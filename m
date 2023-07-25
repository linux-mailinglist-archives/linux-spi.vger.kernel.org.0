Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ABB761F88
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjGYQvT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjGYQvP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 12:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFB2139
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 09:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50A6617F3
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41039C433C7;
        Tue, 25 Jul 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690303823;
        bh=VJycqMPD19LLyWCZibydZHHjFBcNZXty9h+WO6a3xxM=;
        h=Subject:From:Date:To:From;
        b=qgERC0lk7oVr4wU+EnrmRKMUQpDjA/JF10BptKe7KUHEM9DRb5XkKCAm42MC4gQv3
         cdpnRvUfnc+D4aRtJEnw6U24+baEUM5/3GScS8f/TokPIUBZbVzl8ZQ7ZVmf75SG0I
         +TC1xoa5YE56SmIU0U4ADkb9VYFJzQTOZpFx1pHSirJuyo/tKhWOmh3aHyKacYEjR0
         WM1ti5NexnhBMjkzGJ3I46bpzCnZswFLOjcqQeT+1ZZiwIFZcGWZzWVTI202u4JLfB
         fxTA1/QwrrMiqKqXMaOkec70tMg8wbie7gsjhUjx4fCXTVtRrZXMcKX6+v/AJCT4bE
         koMF6ZMcQW6fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DE59C595D0;
        Tue, 25 Jul 2023 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169030382306.16446.17090495133524592714.git-patchwork-summary@kernel.org>
Date:   Tue, 25 Jul 2023 16:50:23 +0000
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

Patch: [v2] spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()
  Submitter: Minjie Du <duminjie@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769109
  Lore link: https://lore.kernel.org/r/20230725035038.1702-1-duminjie@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


