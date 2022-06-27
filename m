Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363555D452
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiF0T4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiF0T4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930321ADB7
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D3A616A6
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 19:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97739C34115;
        Mon, 27 Jun 2022 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656359793;
        bh=mBWZ0hoOzJ1slguTevljBv+xCuNqULlnZ/IiZzt3D3Y=;
        h=Subject:From:Date:To:From;
        b=ftUlMW24oOSAt/2Ue5v85njiRYL0815CgcFK+yKpDt+DVJxYn4tj4KZsuRxE2cdND
         2hPGJ/rjHeIFotgJzvp1KMQMLRtgl2awXYMttoqjKmU7I/WwXxWW+zzMjjRUf5TZW6
         6GZ1rnfz8GtmQGcqSIsiXhoV/c0s9izbbHbJgqkOCXJLs9QhzOMOZonulW63M34DJe
         rA2ATsTp829TGUgJQ6H41J9ZuK7+hf4qG5mxsLC4jo5QB0wX/XNopLoLZppGtPRSRs
         p3yCQE4WYTbnMf+xyn7rqcrwVrLKdMNWVC3s2KV7AiT35Ez2heZqxiGYO5xCBk9ow1
         T1SLf4Uv73ZLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7544CE49BBA;
        Mon, 27 Jun 2022 19:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165635979347.3756.18167328056798110626.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jun 2022 19:56:33 +0000
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

Latest series: [v2] Canaan devicetree fixes (2022-06-27T19:39:48)
  Superseding: [v1] Canaan devicetree fixes (2022-06-18T12:30:22):
    [01/14] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
    [02/14] dt-bindings: display: panel: allow ilitek,ili9341 in isolation
    [03/14] ASoC: dt-bindings: convert designware-i2s to dt-schema
    [04/14] dt-bindings: dma: add Canaan k210 to Synopsys DesignWare DMA
    [05/14] dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
    [06/14] spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width for dwc-ssi
    [07/14] riscv: dts: canaan: fix the k210's memory node
    [08/14] riscv: dts: canaan: add a specific compatible for k210's dma
    [09/14] riscv: dts: canaan: add a specific compatible for k210's timers
    [10/14] riscv: dts: canaan: fix mmc node names
    [11/14] riscv: dts: canaan: fix kd233 display spi frequency
    [12/14] riscv: dts: canaan: use custom compatible for k210 i2s
    [13/14] riscv: dts: canaan: remove spi-max-frequency from controllers
    [14/14] riscv: dts: canaan: build all devicetress if SOC_CANAAN


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

