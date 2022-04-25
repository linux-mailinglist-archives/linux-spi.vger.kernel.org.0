Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E850E754
	for <lists+linux-spi@lfdr.de>; Mon, 25 Apr 2022 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiDYRd0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Apr 2022 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiDYRdY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Apr 2022 13:33:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D04BB97
        for <linux-spi@vger.kernel.org>; Mon, 25 Apr 2022 10:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E81DB8197F
        for <linux-spi@vger.kernel.org>; Mon, 25 Apr 2022 17:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43035C385A4;
        Mon, 25 Apr 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907816;
        bh=3fpxX1DYDXJdtwoGlwx3RNi4lys/huRhXqpztQIOz0g=;
        h=Subject:From:Date:To:From;
        b=OAdAU1/YzSAuiqoABlS1R4MDzKsUj9vv/oBTXi2m0htM3gK7vhLevlH+xXa6h1U7P
         7h2qxc7F2Y3BCWCmp4qp0Z33tmn1pwxATKealyJYoICCsDhiohfkdK8oR+Umh90sHi
         PQ1xYwJJEEVF+jHmAU3EWNQ7utE9hf2Hkk25pJnf4BUihJA8tmKYyjeASaUH24w/cb
         XgL1ZyhpMpKcTEpXQqqKd+J/H9QhO31PcxNvvnA/kCaNHeiFdXeHw2g623TTpwhuDc
         fAICXROIhNRSzEfABBO4yqMezlL9RFeTbS5VLh9CqG7Uwf/OqwRWqZpwugLZ2exYPe
         VzY/xDKHYXm2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D46EE85D90;
        Mon, 25 Apr 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165090781605.23002.7605056633203664508.git-patchwork-summary@kernel.org>
Date:   Mon, 25 Apr 2022 17:30:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: cadence-quadspi: further simplify cqspi_set_protocol()
  Submitter: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=633276
  Lore link: https://lore.kernel.org/r/20220419084640.191299-1-matthias.schiffer@ew.tq-group.com
    Patches: [1/2] spi: cadence-quadspi: further simplify cqspi_set_protocol()
             [2/2] spi: cadence-quadspi: allow operations with cmd/addr buswidth >1

Series: [v2,1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
  Submitter: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=633864
  Lore link: https://lore.kernel.org/r/20220420155616.281730-1-matthias.schiffer@ew.tq-group.com
    Patches: [v2,1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
             [v2,2/2] spi: cadence-quadspi: allow operations with cmd/addr buswidth >1

Series: Improve SPI support for Ingenic SoCs.
  Submitter: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=634921
  Lore link: https://lore.kernel.org/r/1650724725-93758-1-git-send-email-zhouyanjie@wanyeetech.com
    Patches: [v3,1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
             [v3,2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


