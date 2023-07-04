Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C32746E09
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jul 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGDJ4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jul 2023 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGDJ4b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 05:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80814E3
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 02:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA49611D6
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 09:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72599C433C8;
        Tue,  4 Jul 2023 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688464585;
        bh=c1eyX40Epd38QelgUXBQQjVsbNN6zUTuRuTzTBOS2sE=;
        h=Subject:From:Date:To:From;
        b=JcjIk5JsW/psVdwDmYJG6Rf17zSBtpVdv/Yfc7zXXmuuX/n+UXKEpB7kNURSI7NDt
         ik4Pb9ZGrb/hgoQcLZ3RBw/kBoS7PQmvHb7QRrcmfqbNyDAibgl/DpOwgo1j57U4Ao
         xzkopjCGsQ5HGeRL9eEVlOapNYAZ4H7TFyo+ADhw553YuQX4Uh0v4WimVAVGIkO0Fa
         ruLOjTC2ExSoh9vMLdkcgIc03BTHjwFBBqHlF1SrFOSkjV9fkEEXeHSlXohkvXs7WJ
         RB8yeQyOvGfYHmy858BmHRIw62fNRk3GPYntvTRZMJlCZW3inPrIiZpRnQQ/3XqtDO
         Gfer2egNuYCmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 569A0E5381B;
        Tue,  4 Jul 2023 09:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168846458534.13183.8779739825784899948.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 04 Jul 2023 09:56:25 +0000
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

Latest series: [v4] Add initialization of clock for StarFive JH7110 SoC (2023-07-04T09:04:50)
  Superseding: [v3] Add initialization of clock for StarFive JH7110 SoC (2023-06-19T08:35:16):
    [v3,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
    [v3,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
    [v3,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC

Latest series: [v1] Add SPI module for StarFive JH7110 SoC (2023-07-04T09:21:58)
  Superseding: [v1] Add SPI module for StarFive JH7110 SoC (2023-07-04T09:19:42):
    [v1,1/2] dt-binding: spi: constrain minItems of clocks and clock-names
    [v1,2/2] riscv: dts: starfive: Add spi node for JH7110 SoC
    [v4,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

