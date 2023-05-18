Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A570708B9A
	for <lists+linux-spi@lfdr.de>; Fri, 19 May 2023 00:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjERWa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 May 2023 18:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjERWaY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 May 2023 18:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE4E57
        for <linux-spi@vger.kernel.org>; Thu, 18 May 2023 15:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3484065184
        for <linux-spi@vger.kernel.org>; Thu, 18 May 2023 22:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98EE6C433EF;
        Thu, 18 May 2023 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449022;
        bh=B+GBkhS/Gh2MVYV/nET9cn9g+whdSQJzlMvdq6BYc64=;
        h=Subject:From:Date:To:From;
        b=u+bW0xdvEF+XsRDYFs5+PIrERsl0L4cXd/tgSmHvX4vWH0e4IRJy8hgoDVeXyASvF
         UpCovYOLgbOavKvFxSaisMD4W+aodwxrBjXITW+ecDpL4BJhbqW5OFK81FnJ7jBHD7
         n8WgceBFA+e1dOPnGk9HJzOQGnP3nSPPpXfxv++MWIX4lwpeURrza9C4pKhxWI7/7j
         CI/b6VECFKzR8tv06/9yNL/2lJQFYY7FTdLRLWmsZtS1fPcGIsJVJjh2CuBAjP9Z8V
         A5Ea516POObZPgcPbm5iD0K0fcYL00kk+rksVnK8jF/sdHqYk8fi8PueiEqQ0zsUPZ
         Rd10JCuv8PZQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 724F1C41672;
        Thu, 18 May 2023 22:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168444902238.30953.9714695068045457217.git-patchwork-summary@kernel.org>
Date:   Thu, 18 May 2023 22:30:22 +0000
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

Patch: spi: hisi-kunpeng: Fix error checking
  Submitter: Yeqi Fu <asuk4.q@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748753
  Lore link: https://lore.kernel.org/r/20230518052515.368978-1-asuk4.q@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


