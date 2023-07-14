Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A375450C
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jul 2023 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGNWkd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jul 2023 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGNWkd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jul 2023 18:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8D3A8C
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 15:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C56161E0A
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69A61C433C8;
        Fri, 14 Jul 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689374423;
        bh=XtslSNq5WXJPHk0x/2dosahtE0cv+XVBhVAQp/rLUPw=;
        h=Subject:From:Date:To:From;
        b=f5+hu7Qn9eslnUU09pQW4gRt+omWNbU54XxCT+jl5NaP9O1KtpKzAr+dzAvLYpKpe
         QTW0HKf7ch/Tv5FQ4m3ZphIEmQ788lq6ju7M4FBa5AJoCsE5T58KdZIPCuE5Xl1J5t
         OzWNmcRLZ7JHy6hJM0yPdFi8SgjcF4RQRVuN9qd+BhWTwvkmHboUZ7tWQGtv5hLAYa
         P3uo+NBN6mu+xm6hevEGXBn0/hPPRuq+kwg8JFgLgf2egnvM6iPAk8+TGuFkNUeQmd
         k+K3KwsbTK50oSGe1Kv+/Jv8Q6OnG4T77DhJCJXAZwKTiFx2vG0tr2RZ0vwMESp9Ax
         aJeH7hZVjcdFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38EAEE1B4D6;
        Fri, 14 Jul 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168937442315.14591.9517902765326993980.git-patchwork-summary@kernel.org>
Date:   Fri, 14 Jul 2023 22:40:23 +0000
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

Patch: spi: Explicitly include correct DT includes
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=765998
  Lore link: https://lore.kernel.org/r/20230714174955.4064174-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


