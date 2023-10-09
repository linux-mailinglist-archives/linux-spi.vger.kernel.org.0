Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5CF7BE6F8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Oct 2023 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbjJIQum (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377760AbjJIQuc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 12:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6EAF
        for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 09:50:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C32C7C433C8;
        Mon,  9 Oct 2023 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870229;
        bh=39FQ8fvpTBlwzPMQ/zu0UfmP6NCtdWrXEHtQ4dHremU=;
        h=Subject:From:Date:To:From;
        b=SegVNAsABFQ9lUkVr7Tt0YwrdueB1QNWNHmAjDj30VGgYCKqVq1Bq6fhBsnleG21h
         rjb34ZC2LuO5ycBPaTqIIDho1BIbEzoV+qYlFHNo/N5cQJlZok2hm2MvXxxenUqYjw
         UfB5ARFyXSs62McAePADpGSSJseI7+8oVYxejz2TO8ujQA5x3oaB6oWCpslLKgyKcz
         r6llZWpJZC1mahWB+otghp/NlBHf7GuCcv/vZ94Y1eu9BZfD0CRchFefZi/VYbEenU
         tb8NWpqEmwDqbtQhAIKHtUkY3NeQMVWaI2qz9KMGXosvRlsXY0dwOTnSJE5HQFWtNX
         FcjfbMu+BOAOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99C9FE0009C;
        Mon,  9 Oct 2023 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169687022954.4743.4628725041532714482.git-patchwork-summary@kernel.org>
Date:   Mon, 09 Oct 2023 16:50:29 +0000
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

Patch: spi: spi-geni-qcom: Rename the label unmap_if_dma
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=790719
  Lore link: https://lore.kernel.org/r/1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


