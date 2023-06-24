Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52473CC49
	for <lists+linux-spi@lfdr.de>; Sat, 24 Jun 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFXRuW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 24 Jun 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFXRuV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 24 Jun 2023 13:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEB1BE2
        for <linux-spi@vger.kernel.org>; Sat, 24 Jun 2023 10:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7493460907
        for <linux-spi@vger.kernel.org>; Sat, 24 Jun 2023 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01CEC433C8;
        Sat, 24 Jun 2023 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687629019;
        bh=zevvP5MooIPRVmoi7Ui7/LkFx4Pt0Y6vvu6LIFCbcmU=;
        h=Subject:From:Date:To:From;
        b=VeBcoGsY++BXskXjHbiO5F3lj3Lqdq5JvwZvZvGatNckR6JQo0FfW3RGv8Qx11uoN
         jpgJHTBcX+Z44X8nrYpJocqT9N3s8X6xsUIrDysYZMoDAOJYgTYATkeZfnmjGtiWTQ
         C/sjpBLz1ktHw7thzXb1Wm4qYCk0PYpKL2zcuWh9qYUcG2H6FtNWB3FcAEAMlXdbAz
         gBWfSXzus0pQ6wywEUcEhzlkbR29clxvCMFksDHVWIna/S9lL0Q4+BepyXlFRh/OmV
         yz0gcyr3BJIAq7qpt8wo7CQnLzkgGgnKHJSGaoz9oHt2xHySCWe9oFTuUQrF3rGb2P
         Pt2Uumu6VoGzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAE64C395C7;
        Sat, 24 Jun 2023 17:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168762901964.550.13378781454093080679.git-patchwork-summary@kernel.org>
Date:   Sat, 24 Jun 2023 17:50:19 +0000
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

Patch: spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759968
  Lore link: https://lore.kernel.org/r/20230624082054.37697-1-krzysztof.kozlowski@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


