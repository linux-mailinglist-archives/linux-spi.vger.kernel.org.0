Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9279572CC8
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jul 2022 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiGME4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jul 2022 00:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGME4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jul 2022 00:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F487CEBA8
        for <linux-spi@vger.kernel.org>; Tue, 12 Jul 2022 21:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A97761B4A
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 04:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89532C3411E;
        Wed, 13 Jul 2022 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657688197;
        bh=e6QgVyMlAmPoiPg+7FkTGB3Jdn3MBGTs5hJ5LHhka6A=;
        h=Subject:From:Date:To:From;
        b=uXpuZF2i8YPsxfSk0Q19NVp+2YA6zbJry+ApXQi+16MA3m9CmXgLAHbdjpJTOZV/c
         g69snDs1O/pbPZ6rqLAHdqWKo7oQF7Gym2uWVG0j0h44mEcKcUC/I0RGb7Op7sqxNF
         dbLGlumpgGBcgMiZpVtKbLi9PIeOF576zOZUC8LyoOZVfKdCSnxa5R183MbSGpJDYO
         Xf0Vj0UO+xqG3TtCZTp3K4YjheeVJJtfqSDHGdWPuNLsKvwZc9HttRnfDhjlpvjBKL
         KME/7EA9kGaU79pf+6HihcOQYcdtdAJ1JtUtuxhTHIxS2aIO1mjdsnSC6uxmvjDkbC
         osibBdyT6e0Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D843E4521F;
        Wed, 13 Jul 2022 04:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165768819743.9415.12873260808062238639.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 13 Jul 2022 04:56:37 +0000
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

Latest series: [v6] Add support for Intel Thunder Bay SPI controller (2022-07-13T04:22:19)
  Superseding: [v5] Add support for Intel Thunder Bay SPI controller (2022-07-06T04:20:35):
    [v5,1/4] spi: dw: Fix IP-core versions macro
    [v5,2/4] dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
    [v5,3/4] spi: dw: Add support for master mode selection for DWC SSI controller
    [v5,4/4] spi: dw: Add support for Intel Thunder Bay SPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

