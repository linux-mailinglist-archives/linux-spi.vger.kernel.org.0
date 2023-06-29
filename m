Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC8742532
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjF2L4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 07:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF2L4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 07:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5B613D
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 04:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0ABA61519
        for <linux-spi@vger.kernel.org>; Thu, 29 Jun 2023 11:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43E69C433C0;
        Thu, 29 Jun 2023 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688039798;
        bh=ALEi1zxiulFx+qyscM6Ycc5sC0jzI2ZADxiR4857Rj8=;
        h=Subject:From:Date:To:From;
        b=pOIOkdB0mdWpa4swYK+MFSU1/bqvRVtPbND/IyDqgntkfq1pOd8JNfiM6A9FzK9PI
         SpiDVxBCw2vS/wXxW0+Pvq7GOHkymD2SGASJK1501hxzSIJUAHKq1NiuWfIq/EgAoy
         wWb0ITkTfdsdQ2yHYV49k+ZH3jMYnLage4/a6UCe3HooGHqd2BwJ4Oe28V89JTKJMb
         43s+XmGKqg9JDcMIlRokDy+g7vVwLBu/Lz4OFnGYTwnyNrECsLCuHqPcVHnM7wqQFe
         xOWRNL+H1efStunZk5L7tBuD0Sid2euWUEMxlmm7b21z8UvYaS+hCGUAPjk50NMXT4
         fY0EnVG2DLlEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26ED6C43158;
        Thu, 29 Jun 2023 11:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168803979815.4139.16232043952670749523.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 29 Jun 2023 11:56:38 +0000
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

Latest series: [v2] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode (2023-06-29T11:00:39)
  Superseding: [v1] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode (2023-06-29T09:58:47):
    spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

