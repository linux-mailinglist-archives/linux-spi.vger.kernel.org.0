Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224EA7A694F
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISRAa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Sep 2023 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRAa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 13:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC9AD
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 10:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D900CC433C8;
        Tue, 19 Sep 2023 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695142824;
        bh=zeOXY9ZKgeETaH4vx936TW6qO6GRFATtoorPOG7f81k=;
        h=Subject:From:Date:To:From;
        b=s3DV3o2jB/Aj1wcKLeq5OJkaiYLwIg3xfRO4Zlu1E4YoGpsaba4nWDt5B4bowbTIq
         Jiaop5MIQm9YRY9IpS7PSLDBzUF6SPez/ub+lKvGczefXVY1OQ3AexFQ4nVRR9k1qI
         FC2WxF1U4IAXAA2HavECiLK0lJCSsuD6+Av2fc7L/ksQbxABaF3lXKLo8DXnuqRLY/
         AfPs0M//4D8k+qNzFuqW0LMFtqaodQtd7kA9VQkqSfotMXByS7e5L+pQ+tAiYirptC
         uYlPD0BzicXHk0ScT6Qdh7RQ1bEvpuSo5iKpzHJY+psnvbn6VTLWZdgzhTF2ivcpt4
         M6xjtwhNFu5Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B726BE11F41;
        Tue, 19 Sep 2023 17:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169514282467.17079.1142234012459293602.git-patchwork-summary@kernel.org>
Date:   Tue, 19 Sep 2023 17:00:24 +0000
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

Patch: [RESEND] spi: zynqmp-gqspi: fix clock imbalance on probe failure
  Submitter: Johan Hovold <johan+linaro@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=785511
  Lore link: https://lore.kernel.org/r/20230919083401.26454-1-johan+linaro@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


