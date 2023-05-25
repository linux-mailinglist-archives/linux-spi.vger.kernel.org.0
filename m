Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E374871102B
	for <lists+linux-spi@lfdr.de>; Thu, 25 May 2023 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjEYP6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 May 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbjEYP6o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 May 2023 11:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F6919A
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 08:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B375264736
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 15:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24A3CC433EF;
        Thu, 25 May 2023 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685030321;
        bh=Y6r5cdXpZZWz7JWr4j6KSUt4+O1GJUQuzoGn2hB6dG0=;
        h=Subject:From:Date:To:From;
        b=dQLkT43QDgc0kU93jfroT6dl15nBqmcR/GGZr3jBFCvuFsN3j26j+LWfxV/ZF/wpN
         xY7egAiX28F3CWpGvj/D9bamYmnnhaWt0mxZaa/NHL0bB0j6QNp6GDhVoFPCgMrPam
         3fgcQjiZqH+XCDMkcgXF87YuCKFI17kblyDN0KSjZ/7yZOBVNrxpFsn0NqqOiwbWwp
         NrTKebp53RwquzzoHH0UkqUBTrsHTiLgxHNQjfmeW7bfMNIbtgKQXfiyUQXvRn5W2T
         iYRDADiRfZcYgn9cxTCjEtIqyirI1W3VzxVHGRB8cvZYjJcHfERwBix0wLX6zMWWOY
         w/bfrQZLZcAAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1294FC4166F;
        Thu, 25 May 2023 15:58:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168503032107.27102.12018086057930785943.git-patchwork-summary@kernel.org>
Date:   Thu, 25 May 2023 15:58:41 +0000
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

Patch: spi: mediatek: advertise the availability of Dual and Quad mode
  Submitter: Qii Wang (王琪) <qii.wang@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=750207
  Lore link: https://lore.kernel.org/r/20230523112608.10298-1-qii.wang@mediatek.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


