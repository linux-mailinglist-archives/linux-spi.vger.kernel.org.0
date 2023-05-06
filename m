Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87886F951C
	for <lists+linux-spi@lfdr.de>; Sun,  7 May 2023 01:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEFX4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 May 2023 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFX4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 May 2023 19:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182951328E
        for <linux-spi@vger.kernel.org>; Sat,  6 May 2023 16:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EE160CF7
        for <linux-spi@vger.kernel.org>; Sat,  6 May 2023 23:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 018EEC433EF;
        Sat,  6 May 2023 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683417399;
        bh=XtHJjcKS1Qn4HIRXFInavyUMYystqA372bxrBQvrTFk=;
        h=Subject:From:Date:To:From;
        b=uF/Ds7Vj3IYPRpWoC5B9NosFkmgystWQktiuRrP9PH9NPpQJXkv7uNUNum6GOkrXA
         +GDwr/ZMwiAiMaGuYH+HVCnTfx+CDh5irXrzxgjElzTduB7z/FurdlWJN5pDU0IDzf
         z5FAOPr2l0szf3DDy6IPsSpl1cjEKIyUj5+P8p8xhJ0LgfF+IMi0/UdpJlG917RmzS
         6Ew0ARYuMPo0zZJlQHL1nXQdm0+wG9ZNWrwd2U1nGuve6QE4KcLNBjCKGyW6nuPLCu
         FwOumtu1YAfLdAwiW7ByvDSVhtMS3TxYj/OywHJAI3VJIcquaia5exWEpDD/RD0vwJ
         jnjGcKIywQBKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D91A9C395C8;
        Sat,  6 May 2023 23:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168341739888.14262.16523251709040188816.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 06 May 2023 23:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Allwinner R329/D1/R528/T113s SPI support (2023-05-06T23:26:03)
  Superseding: [v2] Allwinner R329/D1/R528/T113s SPI support (2023-05-06T07:30:08):
    [v2,1/6] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329 SPI
    [v2,2/6] spi: sun6i: change OF match data to a struct
    [v2,3/6] spi: sun6i: add quirk for in-controller clock divider
    [v2,4/6] spi: sun6i: add support for R329 SPI controllers
    [v2,5/6] dt-bindings: spi: sun6i: add DT bindings for Allwinner D1/R528/T113s SPI
    [v2,6/6] riscv: dts: allwinner: d1: Add SPI0 controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

