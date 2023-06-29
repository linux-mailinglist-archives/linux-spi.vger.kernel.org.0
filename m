Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01556742649
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjF2MX6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjF2MWP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 08:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890723C01
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 05:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072796153C
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 12:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6720EC433C0;
        Thu, 29 Jun 2023 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688041221;
        bh=ttjX9qnEZ6CVwSKwOEKjmrJLUJLjOtR8XXsoXYQZ8sE=;
        h=Subject:From:Date:To:From;
        b=hnPyJLs53++1SQ5Ipv8RNKmpHmG1g5+Ekv6iuTvt0wPXSrc6OAJm/pDSDAVa76SuY
         Mzr02GhYZmsqMJisgrvyuBhwnjHtHZSQxmnAM7qlB+iRHEwdf71L7ZmU3Kfd+Rs9Ng
         amjRqm7h3xjCQJcD7oZPS0OC2vh53TD2l/R2ocjoMFYRyrnyk5V5TZIp2qw2eZ6T2g
         9vWA3x80kivv74B3YkUOhWFK2IHsCyIU6fpMcQB9Acyp6G7fz6zDncaixiPTP5iwbt
         TjEj6wTf/3HxG6xWKZ1anKkDrY5EpiSGKNZo+ERktFPL2/WwKWeiT9fUPPvWk7R8D9
         238RpT9kXu46g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F91E5381B;
        Thu, 29 Jun 2023 12:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168804122122.17623.7998701433537607903.git-patchwork-summary@kernel.org>
Date:   Thu, 29 Jun 2023 12:20:21 +0000
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

Patch: [v2] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
  Submitter: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761201
  Lore link: https://lore.kernel.org/r/20230629110039.3659309-1-dmitry.baryshkov@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


