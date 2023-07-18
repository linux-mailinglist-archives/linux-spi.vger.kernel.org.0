Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97B7585E0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jul 2023 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGRT41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jul 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRT40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 15:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B59D
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 12:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3428D60B37
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 19:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AAA7C433C8;
        Tue, 18 Jul 2023 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689710184;
        bh=0aLxgPRyrVZ7j82W+xa8xCfNLLov+lcnMFGm8avUI60=;
        h=Subject:From:Date:To:From;
        b=ZeB7P0nlcIGWSM7381jwPtw7PnIyHj/dKDQFkN+NPDxJDkYzvVebBUEIh7cvr+poD
         jEmk9YaTJsxBNmfblGNfE/laneOimQul7Kl1r5x8sUpQG7qEqMJNmLKCQY7KnSehzS
         n4jm0mEI8aNUSyZr108BbV9zIaI1rZK6hFUpUs9CuPocELy0RyeKfqtZfii3uxnJCc
         HS85N/94pBkOiFqgE3qD8tLnzgrHnu4tMDQIMf6FuCWkMiNDUHQTa3vdBTkcgVBFzF
         m9NMrJowjqnTOoV/gTiCLOHDdh9jPJS+wDGK6zpuqgZowP9tMQvWLrLqQfB9JUBBTi
         Dk6uwTGUj0+Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C841C64458;
        Tue, 18 Jul 2023 19:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168971018441.27282.342989782695419500.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Jul 2023 19:56:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rzv2m-csi: Code refactoring (2023-07-18T19:24:49)
  Superseding: [v1] spi: rzv2m-csi: Code refactoring (2023-07-15T01:03:57):
    [01/10] spi: rzv2m-csi: Add missing include
    [02/10] spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
    [03/10] spi: rzv2m-csi: Rework CSI_CKS_MAX definition
    [04/10] spi: rzv2m-csi: Leave readl_poll_timeout calls for last
    [05/10] spi: rzv2m-csi: Replace unnecessary ternary operators
    [06/10] spi: rzv2m-csi: Squash timing settings into one statement
    [07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
    [08/10] spi: rzv2m-csi: Improve data types and alignment
    [09/10] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
    [10/10] spi: rzv2m-csi: Make use of device_set_node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

