Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E335609D4
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiF2S4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiF2S4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB72E0A4
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797C461FF1
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 18:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F69C341CC;
        Wed, 29 Jun 2022 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656528998;
        bh=BkYlt+VDJe3+yxhHxOGWZORQhD8LKoLHf7rU1aF0NYo=;
        h=Subject:From:Date:To:From;
        b=OAjtVG0q6cFQbo3Lu6us8IwvtMuQNudqrAjCSyim6umuaRaxYGTikW1/6L0xFB/b9
         bQpRa/TgmjSVrWW2t7dzmK27IwNFEIyat6RgyVB+xyqq8pfXSGZe0Wm6lrrzVAVd9v
         EkPWJ/bwEe0J/mjRruhjoU/f+V5S/IF2K5jWkYIh1Cg8vKoV3PUKYD0nll3++icTJd
         G/Ea9+T3+i/et24nJxqVBdgjJdeAS6uOh8uEt0qkHZKQsu8Bi89D332UCjkjpmEjiT
         f+zvmjj0tjJodZ/p6JxP+V9BFo9HI/0ESRIxw5PEbF515Jjkpmgt3m9yzvTMwMYbcK
         bIjjFE1cCz6LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B02DFE49BBA;
        Wed, 29 Jun 2022 18:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165652899864.15444.929884380234471536.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 29 Jun 2022 18:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Canaan devicetree fixes (2022-06-29T18:43:29)
  Superseding: [v2] Canaan devicetree fixes (2022-06-27T19:39:48):
    [v2,01/16] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
    [v2,02/16] dt-bindings: display: panel: allow ilitek,ili9341 in isolation
    [v2,03/16] ASoC: dt-bindings: convert designware-i2s to dt-schema
    [v2,04/16] spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width
    [v2,05/16] dt-bindings: dma: add Canaan k210 to Synopsys DesignWare DMA
    [v2,06/16] dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
    [v2,07/16] dt-bindings: memory-controllers: add canaan k210 sram controller
    [v2,08/16] riscv: dts: canaan: fix the k210's memory node.
    [v2,09/16] riscv: dts: canaan: add a specific compatible for k210's dma
    [v2,10/16] riscv: dts: canaan: add a specific compatible for k210's timers
    [v2,11/16] riscv: dts: canaan: fix mmc node names
    [v2,12/16] riscv: dts: canaan: fix kd233 display spi frequency
    [v2,13/16] riscv: dts: canaan: use custom compatible for k210 i2s
    [v2,14/16] riscv: dts: canaan: remove spi-max-frequency from controllers
    [v2,15/16] riscv: dts: canaan: fix bus {ranges,reg} warnings
    [v2,16/16] riscv: dts: canaan: build all devicetress if SOC_CANAAN


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

