Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4444F7E7E
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiDGL63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiDGL62 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 07:58:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95963899
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 04:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58670B8272C
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 11:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1109C385A4;
        Thu,  7 Apr 2022 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649332586;
        bh=fy1Be6hJQ2s+wvEc+3M9oDw2GamaddrRa6gMElu4nyc=;
        h=Subject:From:Date:To:From;
        b=K4oSZuUTFdrICF7dPPdLIxsIoGlLJZ+THP54EwQ5s/ev9YAmr+P1X3kQuX1QZ/U/l
         NKwbuPexkzfQpp3lNSOe2GUFyv2J8wVhlSffl60eLEO9g0f+uf56RozW9dalRxjGOw
         dsrraMmzmFZg/3sRDEXm2X1wG8IJnm1C0ikNcDhRZzcRP5vu6z07oL1s9hWgqrRW8F
         efqRzL5z1tzLjhJs2my/tRfxrxKEXxi/lo8/QUrf4pkrJ/1lWnPFluUczycStKCwHE
         A+R7OkY/SJXfEORf2hLTwzWJisUZ8ty3ORcedcA9lEOTkzXKNKjI9teXnpGYFjqQmT
         Cv7ZkuyPxwj6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D222DE85B8C;
        Thu,  7 Apr 2022 11:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164933258585.30501.639431884991612618.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 07 Apr 2022 11:56:25 +0000
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

Latest series: [v2] MediaTek SPI controller cleanups and documentation (2022-04-07T11:44:20)
  Superseding: [v1] MediaTek SPI controller cleanups and documentation (2022-04-06T10:04:03):
    [1/7] spi: mt65xx: Simplify probe function with devm_spi_alloc_master
    [2/7] spi: mt65xx: Switch to device_get_match_data()
    [3/7] spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
    [4/7] spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
    [5/7] spi: mt65xx: Simplify probe function with dev_err_probe()
    [6/7] spi: mt65xx: Add kerneldoc for driver structures
    [7/7] spi: mt65xx: Fix definitions indentation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

