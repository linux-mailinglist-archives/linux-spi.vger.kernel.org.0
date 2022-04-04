Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763434F0E67
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbiDDE6V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 00:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377210AbiDDE6V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 00:58:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38842DD7F
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 21:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA518B80E79
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 04:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81CF2C2BBE4;
        Mon,  4 Apr 2022 04:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649048182;
        bh=osJ5mfk0ePOQWxyE2Ihfa5D3XRYCn0u8hPnOC/WRq+s=;
        h=Subject:From:Date:To:From;
        b=cmqynK+9aN1VRS/w2e4bIbcr9lXCfhCPUm+DYjxRlU6nZKOrx//Aj835qxL32WfYI
         0r41GUpPzvpaTZm/vo9oET3w+qsKtui2CtRMZhnZDf2zHCj1JCF7HrwpmRN54MkNY/
         599Q50mqvwC8Kzw+h5u1WvpEPorXLCc2TIkrt2XbqhkOXftNEYmBPE5ipUSVB8X4K8
         lK5dGQoxSsMmK9ougZH6N3pP8CUorAYSZheysIo85ZUnfeWF/B+E4WSF/MdaQqbdzg
         HAdsyoXuWZ10mcijCjRj4ue++MPXL03RgbYoNUvUr8MByReE9CTgARCVVdsbgl8vZi
         f5TpjlmESh7dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 594F0E85DB6;
        Mon,  4 Apr 2022 04:56:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164904818230.5524.641596214915904923.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Apr 2022 04:56:22 +0000
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

Latest series: [v2] spi: add support for Mediatek SPI-NAND controller (2022-04-04T04:01:48)
  Superseding: [v1] spi: add support for Mediatek SPI-NAND controller (2022-04-03T13:14:49):
    [resend,1/4] mtd: nand: make mtk_ecc.c a separated module
    [resend,2/4] spi: add driver for MTK SPI NAND Flash Interface
    [resend,3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
    [resend,4/4] arm64: dts: mediatek: add dt node for MTK SNFI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

