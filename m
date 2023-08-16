Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A277E63F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbjHPQVH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbjHPQUz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 12:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC62710
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 09:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1046232F
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 16:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22D36C433C9;
        Wed, 16 Aug 2023 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202851;
        bh=tV27j88vmAWLJke/8IoIkn7PJAJ2hCmbm6d+0ZoDamE=;
        h=Subject:From:Date:To:From;
        b=ANCUJfaLWWFwwppm44vtzav1T5ROqdlRcFda2zV9xjBfUkjN2vySSoSmj2Zw3XbSQ
         KYSV+FOrgRBPP+bVH5x/Um8+uOESOcqtqR2d+7svc9JjPTsIEVQEwqiYmgSJzDo1fg
         kyA4ZF2Ot1LKly9VrNQGtkthAjW1P7lTPwUuu9WTAtZ8BVTK4KTpC+bhIx3GBUEprP
         NJcgq5UY7GER3S7EBr4DrXXLaQOkTAeIj2eatBHhTE8LA5XjzIATpHYzTvlPaLX3Vv
         yiNoLjRpAMAxeMtVuhYqSKCfq6OmK9DJkFDCT5ImdJEEk2gVHzL7sfjv9cQBxnCoOJ
         QxM5z52A5U+SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2EF2E93B30;
        Wed, 16 Aug 2023 16:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169220285094.377.7117112920070569460.git-patchwork-summary@kernel.org>
Date:   Wed, 16 Aug 2023 16:20:50 +0000
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

Series: spi: switch to use modern name (part4)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=776570
  Lore link: https://lore.kernel.org/r/20230816094013.1275068-1-yangyingliang@huawei.com
    Patches: [-next,01/24] spi: orion: switch to use modern name
             [-next,14/24] spi: rpc-if: switch to use devm_spi_alloc_host()

Patch: [-next] spi: dw-mmio: keep old name same as documentation
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=776569
  Lore link: https://lore.kernel.org/r/20230816093938.1274806-1-yangyingliang@huawei.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


