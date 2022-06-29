Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833FA56039D
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiF2OuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiF2OuQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3B1D0FB
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9FC61F92
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 14:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36198C34114;
        Wed, 29 Jun 2022 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656514215;
        bh=WcBcoXCzZba+DYnwAczg3KVv3I8n/McXMQmv1mPww+A=;
        h=Subject:From:Date:To:From;
        b=kiPKjMY+pXOPD6dzyXEoF5Cy8u58uzm7hR4QuN/UogrYqm2scwIj14An+x4twP1p+
         fqevN4/A0GWuGnhnKlaa/37OkhRkKP13P9sJFVJ6fvT/1aSoYCqNUzvtsrxvoP137o
         63EMwtX/V9kgYcHIfRvatY9leNx5F5R0+t4k0EnhqjQDOdbqcOJQATKgIa3Al7oa4/
         7FJ2XMQeBENGN/570GJF0UXVWEReh6YyEpxMfpwwaAmQBBrKB5dCS/zuNQNwUeNdkE
         1o17jreLIY/DATeG16WaKLwbCqxh5j4GbYnwWUh75xcjZJpes/MT2XNcvrWuVRv7Bp
         vPV7qQ/Ts6nGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1493EE49BBA;
        Wed, 29 Jun 2022 14:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165651421502.11049.12047061713123559540.git-patchwork-summary@kernel.org>
Date:   Wed, 29 Jun 2022 14:50:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: [1/5] spi: spi-s3c64xx: increase MAX_SPI_PORTS to 12
  Submitter: Chanho Park <chanho61.park@samsung.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=654051
  Lore link: https://lore.kernel.org/r/20220627064707.138883-2-chanho61.park@samsung.com
    Patches: [1/5] spi: spi-s3c64xx: increase MAX_SPI_PORTS to 12
             [2/5] spi: s3c64xx: support loopback mode

Series: [v3,1/4] spi: s3c64xx: support loopback mode
  Submitter: Chanho Park <chanho61.park@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=654957
  Lore link: https://lore.kernel.org/r/20220629102304.65712-2-chanho61.park@samsung.com
    Patches: [v3,1/4] spi: s3c64xx: support loopback mode


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


