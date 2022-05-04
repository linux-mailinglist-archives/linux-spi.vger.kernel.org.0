Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766151AFF9
	for <lists+linux-spi@lfdr.de>; Wed,  4 May 2022 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356715AbiEDVEX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 May 2022 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbiEDVDw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 May 2022 17:03:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF70115D
        for <linux-spi@vger.kernel.org>; Wed,  4 May 2022 14:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4873EB829A2
        for <linux-spi@vger.kernel.org>; Wed,  4 May 2022 21:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0CC3C385A4;
        Wed,  4 May 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651698013;
        bh=k4834h0FsG8s3qr2zmAWl6Uqz0Rj722QprnPKiSISKY=;
        h=Subject:From:Date:To:From;
        b=LimdlkPm7I+jjGTRT0+8eXAYOEMKtoZNeggO6eFH3fqCvDGzf7p+lObibbEcCpcJS
         mfgH7O0YGBP6uf9ZEsTlHF0w+2fNHYg7KcPZhkurfRN2Q0nf1NME3V3/bq73BMKocV
         o4jVhKq+HZ0WiwlbvCKpn/ATsnKUjLvgq89MNZOUB1SnaSJOoKc3aY/ueXBhRPeCVc
         antqZnAn8n9JUn7MdFgjYYohwgI+/OBzt2MOecdm1fvVrkhdPANkPncQE9/ZRm3vnn
         zlpQc1aWXJuUvSXrvCpZ8tosbL4uPEmOP9g5fu5oBb8PAZ7OVkjBUsXccPmZuywSFu
         LlxkeWFMhzeJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD0B7E5D087;
        Wed,  4 May 2022 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165169801277.5688.6880358706649504912.git-patchwork-summary@kernel.org>
Date:   Wed, 04 May 2022 21:00:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: spi: omap2-mcspi: add support for interword delay
  Submitter: Andrea Zanotti <andreazanottifo@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=637551
  Lore link: https://lore.kernel.org/r/20220502111300.24754-1-andreazanottifo@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


