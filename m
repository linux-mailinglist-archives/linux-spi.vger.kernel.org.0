Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FA47F03B6
	for <lists+linux-spi@lfdr.de>; Sun, 19 Nov 2023 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKSAA1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 18 Nov 2023 19:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSAA0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 18 Nov 2023 19:00:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC921A1
        for <linux-spi@vger.kernel.org>; Sat, 18 Nov 2023 16:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE317C433C8;
        Sun, 19 Nov 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700352023;
        bh=j0Urvxw/LpgOBohX+zXV/0mXIFt3XJH+cKHaSuKxZXU=;
        h=Subject:From:Date:To:From;
        b=W2JWSwFrvADmtyw0Xh86oljzOB0EC6G7mhxuZgTBB75hb3N63MZ8G00e9cS8cur1u
         DiSD/wzxTmPhBzI1NpJIrjWq1Ul8mnANX3WrZSbQQOhjvou8cJNAEWRAckKPnc8zNW
         btWqK5TIaqodqtF+w7BlTJ8P2O8ZZPlBKvTgHnHuGiCAAYiEutmmd0Jzug0Zr6BDqW
         aIygCaCQV1P4fzCG98vrj6aoegOEbbta/27+stq2WJQCJ/VCARFDM4S7r06a3uUDYW
         y55wELdKALN5VcUyzPBWkYZ2+4ChHWTQ3u033pSnxbebg8txNclqPiEfIqnED+luRe
         UvvpZcc6t8C/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D6BDEA6303;
        Sun, 19 Nov 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170035202352.4127.1030089551864722471.git-patchwork-summary@kernel.org>
Date:   Sun, 19 Nov 2023 00:00:23 +0000
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

Patch: [v1] spi: intel: make mem_ops comparison unique to opcode match
  Submitter: Raag Jadav <raag.jadav@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=801961
  Lore link: https://lore.kernel.org/r/20231117144053.24005-1-raag.jadav@intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


