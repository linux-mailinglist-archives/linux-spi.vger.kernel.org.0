Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5186F7B1631
	for <lists+linux-spi@lfdr.de>; Thu, 28 Sep 2023 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjI1Ik0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Sep 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IkZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Sep 2023 04:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F53B7
        for <linux-spi@vger.kernel.org>; Thu, 28 Sep 2023 01:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 564ABC433C8;
        Thu, 28 Sep 2023 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695890424;
        bh=FQELy2/uniRChyOqJDNt6VX8yRfQUF4hVI1WtOET/4g=;
        h=Subject:From:Date:To:From;
        b=JCWZv142wEvegyuGihfEze65SkOGdE2eyh1jmTtnU5OhoVY4TkFez/j8OPKv+rlFZ
         uGl5kU542P42DwNCh9ueB9hRE9KsZpKSYsTJPOtL9Bf2IirGPvkIJPGSoQhsEP2eDA
         8toI4/oTCj9tEjz6ywg64vQym51InZqhx4c0sj5WsbUMCEmTOLWQJNAz+64qcWY4I/
         dRcC/4c2Tx+n6qyqE10vQw4Eu26f/OAYomo86tjOq+1Fjpw+IqXheBUYIgaOhZhekJ
         cIv/iLZGoNsVEk7y9U9tFKRfZ3/aZyL796wpeNi0sEfbn4dygCVg9iUBSk8/JkD9hN
         0l8kt4s1p7lkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 320FEE29AFE;
        Thu, 28 Sep 2023 08:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169589042413.27572.15082486138200014042.git-patchwork-summary@kernel.org>
Date:   Thu, 28 Sep 2023 08:40:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-gxp: BUG: Correct spi write return value
  Submitter: None <charles.kearney@hpe.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=786091
  Lore link: https://lore.kernel.org/r/20230920215339.4125856-1-charles.kearney@hpe.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


