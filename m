Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB47ABA19
	for <lists+linux-spi@lfdr.de>; Fri, 22 Sep 2023 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjIVTac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Sep 2023 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjIVTab (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Sep 2023 15:30:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3594
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 12:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A57BC433C7;
        Fri, 22 Sep 2023 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695411025;
        bh=B9QETGcIOfaGdsIkjRApPJ0Tu+DX5rm/ZdxgT6OOG4c=;
        h=Subject:From:Date:To:From;
        b=uZUSqPDX/OLLqYXwj/7xcUdJobdHeNeRQsI3aRRAlgD0AaVt7o0TWv0AiHNFqr6iC
         JC1gGRLaD9ah4UU/DA8EQ20FGSfyFYs2yPuWqgwTDMVf5rbvlJ7hq2isx0a1a6TIb6
         tk6V0VDFIE/HBz0IOLgeOFNrEkm7YYJwpRsMMiiF9JRPwRjsD66i8PVXbGTsjNMNcl
         IpkBfLCk+ZdA2FQVifs2VKraml2N1P2e6ntg03ZJsFYi41BIhNOFsFtPoI7pjd344E
         62uYib2L5/r6x962bv6MooVnZAFQVo5FjuTGCsK0ShblkEA17GDlkaBceWT9axHgsN
         8htAIPLrJGv/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59AE4C561EE;
        Fri, 22 Sep 2023 19:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169541102529.16776.13490606201578688739.git-patchwork-summary@kernel.org>
Date:   Fri, 22 Sep 2023 19:30:25 +0000
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

Patch: spi: cs42l43: Remove spurious pm_runtime_disable
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=786576
  Lore link: https://lore.kernel.org/r/20230922090829.1467594-1-ckeepax@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


