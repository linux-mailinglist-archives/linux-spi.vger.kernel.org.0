Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77B6FEB91
	for <lists+linux-spi@lfdr.de>; Thu, 11 May 2023 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjEKGKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 May 2023 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjEKGKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 May 2023 02:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57633C00
        for <linux-spi@vger.kernel.org>; Wed, 10 May 2023 23:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2B3615D4
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 06:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96035C433D2;
        Thu, 11 May 2023 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683785422;
        bh=wfS8JvJn8V4CZFNzSJwNslIs15MzH3X/jc+DWwU8VFU=;
        h=Subject:From:Date:To:From;
        b=JgkQwBvDY8AVqj8NWaO1/HpNnxzuY/xphA5AqjUUS6sXuKpoLHjQT9PAa+YSulWMp
         4nr8fLBtIHKzAlUZ8lo4G74nzBwQv+1se21UHiPq4p9c/qD5Gj7D+L11fWXJEk//U7
         k3Hq5avkdhqvLYHu+iSeFBsqANn7DuC62FR9I/m0F14+gFjCAAuyo0c0ygzw+ORpF7
         qICzSbpGdnMzUQUBugmUAmEz40qbGq5qjJ5F8C1Q5fl/Zji5AxRhEghHvqWTRf4bQN
         wXqgE57TSowN4q0ESM0DfyDAW/q6d+tAsN73kI1JgSOfu7IQfJuYFCcY2fpsV7MGcU
         A6ILPwGaDcLuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71BB6E450BA;
        Thu, 11 May 2023 06:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168378542238.29329.18421015953290013021.git-patchwork-summary@kernel.org>
Date:   Thu, 11 May 2023 06:10:22 +0000
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

Patch: spi: spi-geni-qcom: Select FIFO mode for chip select
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=746067
  Lore link: https://lore.kernel.org/r/1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


