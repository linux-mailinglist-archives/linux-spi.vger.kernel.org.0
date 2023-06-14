Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819A172FBC4
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jun 2023 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjFNK44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jun 2023 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFNK44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jun 2023 06:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF6E41
        for <linux-spi@vger.kernel.org>; Wed, 14 Jun 2023 03:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DB46394C
        for <linux-spi@vger.kernel.org>; Wed, 14 Jun 2023 10:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9468DC433C8;
        Wed, 14 Jun 2023 10:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686740213;
        bh=EJmPxsY9uPU5200ZRl0qoxlsYDU2NCXug81mlelvvf8=;
        h=Subject:From:Date:To:From;
        b=cqzUM+cJl4JGoIN0wiX/J+b2ax+ziRGDRHU3BywM581dq5Dkn7vDIExP/LCe5S+NJ
         on4TKAZtaBw9RX9fzD/m25dwpmAoWoD3/wNVo2z29aQcc8b3KIHw74PHf9I3mrC/+p
         DjwgGVbna0DLPJsm45m3eE1IFj29n3VWqSmkio2Eq3KULDINkoUnsYFHXVHjsJooGx
         RgIreh3GkQAwGLg3yBPtXBviBZmO1X3xGA+PwAcqE2TtyEzk+++NKBN8ilsCp845NO
         Uh/trdJChAdMeWvDK0CNpNATB4TdvsBLnMxDXV2eXVk033lbt4qfwm8vcO4Uj4pbHj
         t2x5IVCFbZh0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C292C1614E;
        Wed, 14 Jun 2023 10:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168674021350.5543.3132064807878762005.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 14 Jun 2023 10:56:53 +0000
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

Latest series: [v2] spi: stm32: add spi slave mode (2023-06-14T10:26:25)
  Superseding: [v1] spi: stm32: add spi slave mode (2023-04-28T12:15:17):
    [1/7] dt-bindings: spi: stm32: add address-cells and size-cells into yaml
    [2/7] spi: stm32: renaming of spi_master into spi_controller
    [3/7] spi: stm32: use dmaengine_terminate_{a}sync instead of _all
    [4/7] dt-bindings: spi: stm32: add bindings regarding stm32h7 spi slave
    [5/7] spi: stm32: introduction of stm32h7 SPI slave support
    [6/7] dt-bindings: spi: stm32: add stm32h7 st,spi-slave-underrun property
    [7/7] spi: stm32: add support for stm32h7 SPI slave underrun detection


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

