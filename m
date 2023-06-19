Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA13734EDF
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjFSI6G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFSI5n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 04:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29131704
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 01:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A9760205
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 08:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59558C433B7;
        Mon, 19 Jun 2023 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687165010;
        bh=0GGJv0bgZOPE760XzJ2Y5Ax+VBUAlQ+6KCOapRHK+Ms=;
        h=Subject:From:Date:To:From;
        b=Emu5u0oXX0l4VTGp+3jZNFTQZlFGvfiOWHtdg8RzNxe6icydxCvfPBVpb+he3Rjfe
         1pakKugP51HDQd4JJt0/ZXSTu/1rLqrFsIh1NPntzdDqeiQMOiBPjYJXJlntIV4Cxf
         uFjc7fXlbMqNJcRmpHzlCh88RvDDxS4y/uGE6qM75s0xCS9kLZ/XpsbZRRqmGrz1i2
         u/m1et6J5cXAE2xazD+STqnsfEzZepK0KNZPpFALGlzY8uDEJss+PlbXexeYbPKO98
         Tj/srEOMp0CCEPw+Mz8IURIiLoW4G8R9YgxDWVP5Z1tk7cuzqIHTnjjiv+v27+CyrD
         tua9velf6TxTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 463CEC4316A;
        Mon, 19 Jun 2023 08:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168716501028.7700.11060864432833321045.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Jun 2023 08:56:50 +0000
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

Latest series: [v3] Add initialization of clock for StarFive JH7110 SoC (2023-06-19T08:35:16)
  Superseding: [v2] Add initialization of clock for StarFive JH7110 SoC (2023-06-02T08:49:23):
    [v2,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
    [v2,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
    [v2,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

