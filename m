Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20F720244
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjFBMkX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjFBMkV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 08:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A413E
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 05:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC826500D
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 12:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E3E1C433D2;
        Fri,  2 Jun 2023 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709620;
        bh=MQdHWu3FbJqQbVp2ngu178AGpdeFd2JeHxCM+UuDIbM=;
        h=Subject:From:Date:To:From;
        b=HLqspQTQS/xXAl7URSXeSy7KPdY4smFCafqMuD7b6ya0NouXNZQcrYQYqgabkgZCW
         T3FC27zHknA/V32BDUxFugmj2y/cbqaGBGYaLSg2x+z0dz9kb2vz3LfX8wd9zzHWVs
         vZhmv2vjozCwtGdUYaHnnsuKbDuGwCtCu0kALuRMOA3RPKIuBP8XcbMGQ4CodqA8gp
         uHIyy9ZZ5SLHHB9DRfTzZSRqBK/Et6MWq3/XBZgCRsvprRyELp89xEWEAd85a1yDms
         fTVr6bvQ1tLUWpf0RMtkTQ4+RkzvRQBHuLTSoVXWm43iGnh8SCUXji+sA5cSohusbA
         TQHVosEntVCKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E29C395E5;
        Fri,  2 Jun 2023 12:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168570962001.5813.16441790768702980784.git-patchwork-summary@kernel.org>
Date:   Fri, 02 Jun 2023 12:40:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: [1/3] spi: dt-bindings: allwinner: simplify with unevaluatedProperties
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=753023
  Lore link: https://lore.kernel.org/r/20230601095908.563865-1-krzysztof.kozlowski@linaro.org
    Patches: [1/3] spi: dt-bindings: allwinner: simplify with unevaluatedProperties
             [2/3] spi: dt-bindings: samsung: drop cs-gpios
             [3/3] spi: dt-bindings: socionext,uniphier: drop address/size-cells

Patch: spi: s3c64xx: Use devm_clk_get_enabled()
  Submitter: Andi Shyti <andi.shyti@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752938
  Lore link: https://lore.kernel.org/r/20230531205550.568340-1-andi.shyti@kernel.org


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


