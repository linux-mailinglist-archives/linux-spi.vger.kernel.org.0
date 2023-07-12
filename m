Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B541C750BEF
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGLPKp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jul 2023 11:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGLPKo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jul 2023 11:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE71FFC
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE19661843
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FF9DC433C8;
        Wed, 12 Jul 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174622;
        bh=RNEqupq32A14jnJiizT9fsKgq8xP7vwaGzpOGYdqlOM=;
        h=Subject:From:Date:To:From;
        b=rBx13qYUi7euekx9cpzXxI/OQBwbg8lc8c20wcJkg/GMVrT2WcD/DMfSzrwteZE5J
         m+RHPgKSmB/qBi5Z5xmEi+S1mbyISK5F56UCimw6uXE9SLSAQYR53C3t0OA1aZQ2Jk
         QWMT4gWdJe/XQD4ELstXJjviB1lJasGt3co53s4XgRLb2eEPUE5Mv29vkyH2F8lGto
         4HMOSfAwi4/wUbWXA22Gq/fLhp8QZDRgSg32vRbcyL/mQedHbO5MF6gkImFZ4/CDjL
         V8RnBq1tkQi9WUjb1wM0LagBj1MRqzwf1dxDg/XwNetzLDVy4l24OzYErde0hiXD6c
         x/t4dDSJp7tTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B9AC4167B;
        Wed, 12 Jul 2023 15:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168917462186.27088.2388740645520977817.git-patchwork-summary@kernel.org>
Date:   Wed, 12 Jul 2023 15:10:21 +0000
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

Patch: spi: spi-cadence: Delete unmatched comments
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=764671
  Lore link: https://lore.kernel.org/r/20230712064832.67091-1-frank.li@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


