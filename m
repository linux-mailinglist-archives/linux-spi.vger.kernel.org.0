Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B97440E6
	for <lists+linux-spi@lfdr.de>; Fri, 30 Jun 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjF3RKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Jun 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjF3RKX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Jun 2023 13:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B17125
        for <linux-spi@vger.kernel.org>; Fri, 30 Jun 2023 10:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C34CD617AC
        for <linux-spi@vger.kernel.org>; Fri, 30 Jun 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFA0C433C0;
        Fri, 30 Jun 2023 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688145021;
        bh=RNlkmummKzUitvFqNCHqBwLsOsUJ9RzDkDae8G3GN5w=;
        h=Subject:From:Date:To:From;
        b=oF2OtHNz13vETEFhbSMmV38nLGv/Jh9CIVs5g/MkpibKy0b6ddeznjG462W76n6h+
         drvoCknlvZwT3yUOeEFhle3G4N1DQwaW6Mwdxqvr4qCLmpZPRxHLzdgpm4KNTJjyUt
         oZfuTceRyWvTu/cREbR6jwVQixD6nAjXA8U2hH5z7EioUbDH5R6T3ISYG/qDw0akP8
         diqpbpw2CqxbVKh3i5aOYq53d1KoK/Tq7I3jwJ5VZtJNQN3NqDWJcE+dNG9dce36s7
         AAG3LpmCKZ1K7mUE63YTHOpxIZJQB4jKjqFWR1zqcAUSGX8Fm+3mzmXV01XzM2Nb52
         jaqsx6OICX7CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A0D7C43158;
        Fri, 30 Jun 2023 17:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168814502096.31669.5149416415281910327.git-patchwork-summary@kernel.org>
Date:   Fri, 30 Jun 2023 17:10:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Patch: spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761242
  Lore link: https://lore.kernel.org/r/20230629134306.95823-1-jonas.gorski@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


