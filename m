Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A436877D5FE
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjHOWax (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Aug 2023 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbjHOWaY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Aug 2023 18:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD941FF3
        for <linux-spi@vger.kernel.org>; Tue, 15 Aug 2023 15:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 023B1637AF
        for <linux-spi@vger.kernel.org>; Tue, 15 Aug 2023 22:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63147C433C7;
        Tue, 15 Aug 2023 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692138622;
        bh=Zon56GiKy+slUX+C5eXoC/8PB839Rpxc1o1rBfC01Gk=;
        h=Subject:From:Date:To:From;
        b=vM0Q+STe0lL+SvgUL3Xmt1NDz8hnMeKi2kiziqXcpK09CRz5DcmjtYWJkNd8VewKV
         nkUyVkIG16qYijzz3hn+KARHmIrVFd9wJ+b0/mG8WC9Jwbbiew6uOYQM8q465eQGWn
         nEw9sKurRmedRAsb7FGrrd4yjdIMfqDl3G8VjP7yADHdFmEmz/R3SbPiQFCBGoD8vt
         tULVT/NxeSBWR10XElmWUItPaSqkG1qdiQGr6f2T04hFBzWVxqn8jWWy0M9zJpBhzN
         7c9mkY8Hd0T7ZXtciB/hxpECjkKD8F7daZr0XvZ3MDAFbRoZics1HRNzAIpYDAI91K
         BaMVuOBhg19xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C695E93B37;
        Tue, 15 Aug 2023 22:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169213862217.7920.17496429613784901474.git-patchwork-summary@kernel.org>
Date:   Tue, 15 Aug 2023 22:30:22 +0000
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

Patch: spi: tegra114: Remove unnecessary NULL-pointer checks
  Submitter: Alexander Danilenko <al.b.danilenko@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=776234
  Lore link: https://lore.kernel.org/r/20230815092058.4083-1-al.b.danilenko@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


