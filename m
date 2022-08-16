Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC255960AC
	for <lists+linux-spi@lfdr.de>; Tue, 16 Aug 2022 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiHPQ4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Aug 2022 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHPQ4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Aug 2022 12:56:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68E80E9D
        for <linux-spi@vger.kernel.org>; Tue, 16 Aug 2022 09:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BB6B81A97
        for <linux-spi@vger.kernel.org>; Tue, 16 Aug 2022 16:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D77DFC433C1;
        Tue, 16 Aug 2022 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660668988;
        bh=oY/iOj9g3hWoIwLC9XygejvkwknCQ6xUmh7a/WXjnR8=;
        h=Subject:From:Date:To:From;
        b=NJvZpckdOIvgOzL+GwegiHTmppisXmo9TZ4i6+g4xP62wrbF0PR6y16fgp+JXZkcJ
         eSOuqi3bBMY9aGW0Derg73SwajpJiCRTudGPQf+WjP0peizooh7zTIKSnhfdYuuuY5
         sP5uisQB4+9h/rSDXlWg7FqfshDY2P4cCZBUx/th/9mgecATvEr0F2fzCHufMwtnQw
         p+Mk2mhSYvv3V1vVcjR32b1ReXh4sLXQTiEsijGjFnmOCBd0tercoQqEcqtbg13gV1
         AJhn23UwxQnkX37PJbFiI8vtrmSab3rDw+z8TphTN/UAaSPHb8Z9zR0C8H3SbIqJAI
         MB4IPmrbC8vEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA46C4166F;
        Tue, 16 Aug 2022 16:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166066898876.21556.3297962292210434795.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Aug 2022 16:56:28 +0000
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

Latest series: [v3] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-16T16:13:42)
  Superseding: [v2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-10T09:32:13):
    [v2,1/2] spi: stm32_qspi: Add transfer_one_message() spi callback
    [v2,2/2] ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

