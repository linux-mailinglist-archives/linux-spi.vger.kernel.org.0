Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE57245F9
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjFFOa0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjFFOaZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 10:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2108E47
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 07:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E3662B82
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 14:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D4CCC433EF;
        Tue,  6 Jun 2023 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686061820;
        bh=UxzT8C3wOzDwhzzTGd7Ey2cnel6R5zVrod4j4foaByE=;
        h=Subject:From:Date:To:From;
        b=bzdoM3d2JBFVya6HebOKUhXJSBUPyTPU8KLcnw/YNXDCUXttwces1lSWNlaDZ0IVX
         kNauZYtVv8sLjShA8d4zlvQT2MoGQ4jjtrwYFCPMd/ArF61TcGjH5VmhlAiaDbo7MG
         8p7O7bAaaW2ajyTLmBXO+78TC9ymH0ys2RXk/0CHs2eGClkgNMgGdliUi45EvHNkCG
         EsjahsEKQgX7jD7AP/tRjqTqy1GJCS7WIrvKjbHodS35epf9Qn1AHaCopWuEBMrYgS
         Aoh/izcIzUHdNQkpNBBw9kplOKN4hUb8OdvKxMVR8iiuQHWurMWRD52L4cIGEgU2Pi
         pBonXmLm1NLhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 451B0C4166F;
        Tue,  6 Jun 2023 14:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168606182021.19009.12105786172019357289.git-patchwork-summary@kernel.org>
Date:   Tue, 06 Jun 2023 14:30:20 +0000
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

Patch: spi: cadence-quadspi: Add missing check for dma_set_mask
  Submitter: Jiasheng Jiang <jiasheng@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754367
  Lore link: https://lore.kernel.org/r/20230606093859.27818-1-jiasheng@iscas.ac.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


