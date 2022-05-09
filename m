Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924C8520694
	for <lists+linux-spi@lfdr.de>; Mon,  9 May 2022 23:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiEIVYL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 May 2022 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiEIVYK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 May 2022 17:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978F27E683
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 14:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84E0861720
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 21:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E436EC385BD;
        Mon,  9 May 2022 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652131214;
        bh=Y09B36K+M92zYbRG4wk/iVMgCKeAGsT3tu5Kf/H3R/E=;
        h=Subject:From:Date:To:From;
        b=XGruhi4Ci3oujfSnC0wDYDFUKxUAnR+NpaKqYRReVh1qD1O/25GBgPGYXB72V4TvP
         RZ8HoXoioJPtFri0B2lFYrLxDjhYip5pga+cO8awHSKUcFvLkAyGuoaRUHMzlMoEQc
         L2SlqYgdDBIsg64zkPznIUjkZE1xGcjMgfJ/OZtvlLBQsNJ24rP4yDzTfTac/L8RcF
         OV0fkZv+qt2JXPX07/7DUOXknGseKuOkO47zIRCiexJP2sHAZaojuziahwtGAr6xZS
         py9KjRVmFtEj3L/XtTrkPHeuVtdVGCBbOZUGfjWPnVXtJAlkrAU1B+Q+ZPkQwZiGRe
         rYuqPytpjC59g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6741F03876;
        Mon,  9 May 2022 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165213121466.23928.8083884010692536090.git-patchwork-summary@kernel.org>
Date:   Mon, 09 May 2022 21:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: spi-imx: cleanups and performance improvements
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=637691
  Lore link: https://lore.kernel.org/r/20220502175457.1977983-1-mkl@pengutronix.de
    Patches: [v1,1/9] spi: spi-imx: fix sparse warning: add identifier name to function definition
             [v1,2/9] spi: spi-imx: avoid unnecessary line continuations
             [v1,3/9] spi: spi-imx: mx51_ecspi_intctrl(): prefer 'unsigned int' to bare use of 'unsigned'
             [v1,8/9] spi: spi-imx: add PIO polling support
             [v1,9/9] spi: spi-imx: mx51_ecspi_prepare_message(): skip writing MX51_ECSPI_CONFIG register if unchanged


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


