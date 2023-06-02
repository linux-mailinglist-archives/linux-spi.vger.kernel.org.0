Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A77205D1
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjFBPUZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjFBPUY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 11:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895D1B6
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 08:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC156176E
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 15:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12922C433D2;
        Fri,  2 Jun 2023 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719219;
        bh=M2Yk2ZY+6y+CHYKCrWmIL9IFu5EqDIvavm3O/L9C3d0=;
        h=Subject:From:Date:To:From;
        b=jK9v5vJp924UkeS3io1rVo98wieZLgdoADdoUwDE765wwV9IKVL5eGFRKAbUmrand
         H990Y0hhKxnNzLTDpNb8KjdBUDZ/IoYLDk3vqW8Kq15nEJnYNSk/TEaOKKqQrw/r0S
         UijIAocNVfCSbwd14MnpqmI0gZ6RNXTXY9/z7edRUABaBwxhmw1+vUYpzgc3Oo1iqG
         7b+x2sJQsrQqHHiIubWoQ8cdA2TfsG4h0T7nV0i5y5aQwCc4L5RhJDtNmeMfM8lYHP
         7ZJzYdNFKZrF+Rx56lGh8iHj7YZTZA7Vb/bCn1akTLpSuye6TpA4ou8wZbsa40JPnD
         3eImKnccAjBZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E077FE52BF5;
        Fri,  2 Jun 2023 15:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168571921886.24140.5535071707889073527.git-patchwork-summary@kernel.org>
Date:   Fri, 02 Jun 2023 15:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] spi: spi-imx: fix mixing of native and gpio chipselects for imx51/imx53/imx6 variants
  Submitter: Rasmus Villemoes <linux@rasmusvillemoes.dk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=753515
  Lore link: https://lore.kernel.org/r/20230602115731.708883-1-linux@rasmusvillemoes.dk


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


