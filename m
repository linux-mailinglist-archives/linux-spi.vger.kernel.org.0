Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1B5AF05A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Sep 2022 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiIFQ07 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Sep 2022 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiIFQ0l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Sep 2022 12:26:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E9A6C41
        for <linux-spi@vger.kernel.org>; Tue,  6 Sep 2022 08:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B1AFB81923
        for <linux-spi@vger.kernel.org>; Tue,  6 Sep 2022 15:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E31CC433C1;
        Tue,  6 Sep 2022 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662479805;
        bh=mysM9bFXZJPlkmGlKbllguvyLT1ui6lT0Xf2RMXoZGI=;
        h=Subject:From:Date:To:From;
        b=PKoNQ8TE/1Vc0WvYC3buB6dS4YOby4AtV1N89rbrloVKb0F7c+ZcF3B7adEArYInx
         9ZqvgOqokk3h/4V0rpSlumwVysL1/oC+iJwv1L68uAnVcZL2UYJ2RfTaAWUlEL0TaX
         kH2hfA/8pl3WyOvBt1/jY5DRux/xtdBn2WJpEgf88OwdycQG0T3hkWIUNZLWe5yYyy
         zQzqofM/EqyaWksrfDrKQFn40s/c8TKToKGp3aL6HNZRiWeyBsdcXUuFYYJGkfS1hG
         Yod3vW5siAgIM9DpJiKICd3Bhxd3SPR15hBytx71GIQkDEyslMOYLRoyvyEyi6BzHJ
         /o/alzsbtiYKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 319A0C4166E;
        Tue,  6 Sep 2022 15:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166247980519.12242.5418920071906989066.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 06 Sep 2022 15:56:45 +0000
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

Latest series: [v2] Make atmel serial driver aware of GCLK (2022-09-06T13:55:02)
  Superseding: [v1] Make atmel serial driver aware of GCLK (2022-08-17T07:55:13):
    [1/5] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
    [2/5] dt-bindings: mfd: atmel,at91-usart: convert to json-schema
    [3/5] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
    [4/5] clk: at91: sama5d2: Add Generic Clocks for UART/USART
    [5/5] tty: serial: atmel: Make the driver aware of the existence of GCLK


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

