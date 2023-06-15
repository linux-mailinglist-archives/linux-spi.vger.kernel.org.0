Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65183731C0F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jun 2023 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbjFOPA0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jun 2023 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbjFOPAX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jun 2023 11:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1A273D
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 08:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3D561CAA
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEA08C433C0;
        Thu, 15 Jun 2023 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686841221;
        bh=1ThYTQpVhz5mr2SwEOcs6uH7Zu93bEYWVc4QD6yT9YA=;
        h=Subject:From:Date:To:From;
        b=Lcs8KC2S2FKznUOzb7oT5NOWQ+iTKN/fBRS5P+sksjgvUGVWrTerXmx/Rp80IsRhx
         dZw56WjXk/YfUMGZT5ofB5sNTev/rd+VtydEkH/31KgPpdU9Pmy6Zd6o24XCKHcK3O
         FoozE7gzzHqA48Xj98oF11qyn6LNJcSmyDNdmB6BUWu3tEWRsf6ey5xxyP+KLLVOXz
         sKxhjSh60mwtzKUkn5e46rxl+VZOX93kqqVfOVgpEwF+wA5FyM+54CAOf6ce2IXh02
         95yZZRacI9PsPm7RapNqzI5rVjPVLwFOOzyeSruN/voOnGRwtddLXMYErpFHxOfQSc
         Bp1vJJVn0lQ4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86D13C395E0;
        Thu, 15 Jun 2023 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168684122148.31410.2039793487343539011.git-patchwork-summary@kernel.org>
Date:   Thu, 15 Jun 2023 15:00:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()
  Submitter: Neil Armstrong <neil.armstrong@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=757479
  Lore link: https://lore.kernel.org/r/20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v2-1-670c3d9e8c9c@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


