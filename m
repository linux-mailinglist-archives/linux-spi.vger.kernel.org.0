Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD67DFB1C
	for <lists+linux-spi@lfdr.de>; Thu,  2 Nov 2023 20:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKBT4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Nov 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Nov 2023 15:56:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3623DE
        for <linux-spi@vger.kernel.org>; Thu,  2 Nov 2023 12:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 236D3C433C7;
        Thu,  2 Nov 2023 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698954987;
        bh=tfGIOddmHLQ7PUz54Zh2CipU76bxxKT54vA2RnHVQvE=;
        h=Subject:From:Date:To:From;
        b=ftZeI0A6HVY2r1MksQWVMs8z/zOs45w1nv/r4IMTQa9JAk5No9qI7j03km2A3Rflx
         QgA2gnjP5Snm3MZAitJjvOCtXkD+2SVplNQPv1DQ8pJbjc9xBlWGXfFz5dgHh8niuR
         caMI0N+NNM5eAfUxZRQdP7xSv7IwIubbeSer5QzyHFWe2G7anyPV2tvp1A4FkRAQU6
         vrqyeK+qXEVeh0Cf41Ry365FoUHmqaavpEhOZu0L8tQQrR+TomKl5jpNdT3OC7DgeF
         vJ/aIvrHLFd7RjhpZupXSkrA0GvkIe7U2f97B+GR4mMOwM8G3Gop8WkFfkuaF5ixWd
         aagtPucZ9TEDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08387C43168;
        Thu,  2 Nov 2023 19:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169895498702.6132.4460455635906631675.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 02 Nov 2023 19:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add STM32F7 SPI support (2023-11-02T19:37:17)
  Superseding: [v1] Add STM32F7 SPI support (2023-11-01T15:08:05):
    [1/5] spi: stm32: rename stm32f4_* to stm32fx_*
    [2/5] spi: stm32: use callbacks for read_rx and write_tx
    [3/5] dt-bindings: spi: add stm32f7-spi compatible
    [4/5] spi: stm32: add STM32F7 support
    [5/5] ARM: dts: stm32: add SPI support on STM32F746


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

