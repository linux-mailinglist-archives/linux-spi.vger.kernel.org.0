Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162EC4F0A0B
	for <lists+linux-spi@lfdr.de>; Sun,  3 Apr 2022 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiDCN61 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Apr 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiDCN61 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Apr 2022 09:58:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75A366BA
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 06:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F41C9CE0DA1
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 13:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D51DC340F2;
        Sun,  3 Apr 2022 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648994189;
        bh=311DHnOBS5GX6GvfzFiGAqf7kZQSO4HiV/i6klPfz/k=;
        h=Subject:From:Date:To:From;
        b=OsiYRyM5jDCPCokqiQhf3xZj1seGGEs25xT46V9/VkavQj7xdWcbzwcCN4ti95QmT
         UWOarJ52II8qw6lPZWDfHd+PquKqB2xy8i5a2TEkPeBS/GZmrPFcw46LqMTxh4iCXF
         XMuBOAF2Iem2JEUnfg7hFw7JG7WHUbQa4bitlBkUNfLNh35DmJZ87BoOt0HZ1hp9+R
         VQnsF9uvw3ltcQNjyinUETmItQcMUQ5Dc5dUs21CgM8b2fiiSEjQIm+uxUpibF1LhR
         0KPySNpgSJvAiYoyWKfoxsfyMrgs0fPPqJyTFkllWo9LX3bwk7Oh3s5m6eYEu0BPkf
         2svO5QQKpVg/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F169E6BBCA;
        Sun,  3 Apr 2022 13:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164899418912.20685.8183222527904522969.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 03 Apr 2022 13:56:29 +0000
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

Latest series: [v1] spi: add support for Mediatek SPI-NAND controller (2022-04-03T13:14:49)
  Superseding: [v1] spi: add support for Mediatek SPI-NAND controller (2022-04-03T13:11:50):
    [1/4] mtd: nand: make mtk_ecc.c a separated module
    [2/4] spi: add driver for MTK SPI NAND Flash Interface
    [3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
    [4/4] arm64: dts: mediatek: add dt node for MTK SNFI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

