Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5E7E2342
	for <lists+linux-spi@lfdr.de>; Mon,  6 Nov 2023 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjKFNKa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Nov 2023 08:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjKFNK3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Nov 2023 08:10:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B061A9
        for <linux-spi@vger.kernel.org>; Mon,  6 Nov 2023 05:10:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249F6C433C7;
        Mon,  6 Nov 2023 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699276226;
        bh=nKkQNDZcZOLViZGQepg5x+qyzUs2mfKU9+uIeIDSE6I=;
        h=Subject:From:Date:To:From;
        b=OA8NXPKV8jK0/3FlYHqIwYnFIElMgnjqbTRF3dCW1m+hVDCSlPiVcjrjMAuVO1NSQ
         yvHzqcxyixkmw0xoYzgKJ2IWq3vLraxyMJwkqECMuFCfnTCYgOCtRYYwu8TTgn9xLZ
         IjAbfgx8s2x9dZqs7U6xGhQvajq8SL81LZNKeCj1IPC2I94qftacoA5nc5T0TGxxIU
         CfnSMWjvI4KKIsJoespfM0x5DwleWaoO0kNKioKhDp2tMDOsT0Y4L7GJFs4u+S/ku4
         HC+2wvf1rUEmOvxxWWgujGXOBnWPV0a5Mi/lgT+ax2zMGFZPzGnlWZfYnR44No3jo+
         IIN5nJ5BRI4dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C436C00446;
        Mon,  6 Nov 2023 13:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169927622598.12898.2860200396052309490.git-patchwork-summary@kernel.org>
Date:   Mon, 06 Nov 2023 13:10:25 +0000
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

Patch: spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies
  Submitter: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=798719
  Lore link: https://lore.kernel.org/r/1699037031-702858-1-git-send-email-radhey.shyam.pandey@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


