Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FB7ABAE7
	for <lists+linux-spi@lfdr.de>; Fri, 22 Sep 2023 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjIVVKa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Sep 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjIVVK3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Sep 2023 17:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC39AC
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 14:10:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 956F3C433C7;
        Fri, 22 Sep 2023 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695417023;
        bh=qh38RNr3e6gRWcP/s8U1ks76TXAcEcSAU1nBqdCL9W0=;
        h=Subject:From:Date:To:From;
        b=L+10hxZy5BZeFT8v14gp+MWBp0v3vU3dA46L+ElgsxqiT536rbmWSPwi3ODPIV99S
         5LztujK6ND+VMwzB+2OqV/NTSWym0RfBg6b9OyyC4Zgw+uhBl9mu5bNaZ1jS4xY8xJ
         l/WjbFYSyaeYUULzkD9VEV8Zs6BOAcKsgc6CVVnP1vgF8UDHHxF5qjqIbA/O3m8cVo
         cJ6lQ4f+zDnT6RCt1OaxwCqtdpRjZxClZ9r6VL4SSbpg/cdhr2YQ35UlQiQ2vZUU3b
         DT7bQ6qYkz9316x4TjfcNbmnZyIC9X5Br7HYMcn2uURZZ21P+T30il5bk7oKjxbDk7
         veIxhrBPwH6nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CA63C04DD9;
        Fri, 22 Sep 2023 21:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169541702336.2881.6625011610567332031.git-patchwork-summary@kernel.org>
Date:   Fri, 22 Sep 2023 21:10:23 +0000
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

Patch: spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with __counted_by
  Submitter: Kees Cook <keescook@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=786873
  Lore link: https://lore.kernel.org/r/20230922175322.work.170-kees@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


