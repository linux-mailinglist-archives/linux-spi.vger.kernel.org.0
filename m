Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDE763F42
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jul 2023 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGZTK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jul 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTKZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jul 2023 15:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB41FF0
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 12:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5517C617DB
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB412C433C7;
        Wed, 26 Jul 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690398623;
        bh=jOkRbqzsaeqf5NKSPNV1OsFi/h86Sxo3EcaPihw+KJI=;
        h=Subject:From:Date:To:From;
        b=edKsaFVJ9No5rsKuuxukGRl2S//6DllPA+1gn2oOXSeBqCaMWvIT0CwEXOcrL6FPD
         pqZXxYaYmYv5N6Ysb1SmJIWstGe1Qj3eBYwh9bbSI/x6PWlXaSVO97dE8W21eUNuxV
         nO5icO9mSpXTOI/FwEzoScgC7xVSYxOTCKrY9cfjRqUgKYTeL2uhWJ0JUU98XuGVwE
         efeneA4JD2P87m89wmMv9Xwjv+69pXfPtIytAnsnbe1pyQDxp3hTx8eEh3Cl5Hnw1X
         7p63WwUsbAJp+8pZu/mJDC7z2Cfaks954njgdkZeWAeO6qqkcHa5xnAnum/aAV1wDc
         xZfdtghezPGYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 952ADC41672;
        Wed, 26 Jul 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169039862355.16406.16087739274627835762.git-patchwork-summary@kernel.org>
Date:   Wed, 26 Jul 2023 19:10:23 +0000
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

Patch: [v2] spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
  Submitter: Zhang Shurong <zhang_shurong@foxmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=768552
  Lore link: https://lore.kernel.org/r/tencent_71FC162D589E4788C2152AAC84CD8D5C6D06@qq.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


