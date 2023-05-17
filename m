Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC37075A9
	for <lists+linux-spi@lfdr.de>; Thu, 18 May 2023 00:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEQW47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 May 2023 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEQW46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 May 2023 18:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA699526E
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 15:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577CC64B8B
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 22:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70FFC433D2;
        Wed, 17 May 2023 22:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684364216;
        bh=9HJOKxPYPsevHu+pHP/q8Fi20K9bRGD79nmRny6lW+c=;
        h=Subject:From:Date:To:From;
        b=ZAfbf/wKmLiPaFVP/7XSyE+dAFndc/RdTaSjDwdwaOe0skByo21TXVVb1RWP/6tbo
         bpNBJIuI9DeIGK3uCGoIUS8aaAxTi7pA9ydCwmTtXqdlkrAuB42xJtSqQ9IqzHKwUv
         9mDqrh9SwfTJ2CT6Q0/w9ZYHhGvdEL4HvHxmUZmKaoK33/8lYYxvVPTYqY8W19/RsG
         hfmaTn3UBzlBtGWTLQhTkr+Xgfq5Cnsxtqdjbn7kwxEGwXZ78uZB5NzKf3ZY7z+uH1
         x1l0dLXVweXXIMHsJmA15nQNdWKV5CP9Y4m/gueFSw2Fne5fWCaafbmdwbMClIqohB
         JVsEEn/v0AQpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98423C4166F;
        Wed, 17 May 2023 22:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168436421661.2793.4465207082110158971.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 17 May 2023 22:56:56 +0000
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

Latest series: [v4] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-17T22:30:05)
  Superseding: [v1] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-17T10:30:05):
    [1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
    [2/3] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
    [3/3] spi: spidev: add SPI_MOSI_IDLE_LOW mode bit


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

