Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41A668D112
	for <lists+linux-spi@lfdr.de>; Tue,  7 Feb 2023 08:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGH4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Feb 2023 02:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGH4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Feb 2023 02:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9910A243
        for <linux-spi@vger.kernel.org>; Mon,  6 Feb 2023 23:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C82B81707
        for <linux-spi@vger.kernel.org>; Tue,  7 Feb 2023 07:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E68AC433D2;
        Tue,  7 Feb 2023 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675756579;
        bh=nkYn27bp+Ds768KdGF1O/a+mQZyLr6p93GxjT1fQHXM=;
        h=Subject:From:Date:To:From;
        b=F3UL7enyzuSN3rt7gXlZb6Y/iHoYVKN3IrLuhDMeIY/wfw1D9539URiwnMK+8uooT
         zKhSpW5/IWx8WH1h5l9ut5xC6jLd4H6Wj+gQHqgGolwE3nRGDouMUe+H8/ZN73XG7d
         4Vd5/umGlLQN4zTsahMDEtxh/X3G/upflgIo0VoF6uanPi4dOzskfz26bsIYG8a0s9
         Xdxy2AGnNzcxPwucpXY2DUZKaRn+uU17Dpg9+2wvIV3IfbD7o/h5IwvqtSE09x0pGa
         I1lJeETPe3ByUuEjJXzL+jh3a73y0BfoaZLhLS1zYBs1iR1DMrWU1HmGJ1Lf6iKRSM
         Led1RJ8DTU+Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16A04E55EFD;
        Tue,  7 Feb 2023 07:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167575657900.4349.18137719571602759967.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 07 Feb 2023 07:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm63xx-hsspi: driver and doc updates (2023-02-07T06:58:11)
  Superseding: [v2] spi: bcm63xx-hsspi: driver and doc updates (2023-01-24T22:12:03):
    [v2,01/14] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
    [v2,02/14] dt-bindings: spi: Add bcmbca-hsspi controller support
    [v2,03/14] ARM: dts: broadcom: bcmbca: Add spi controller node
    [v2,04/14] arm64: dts: broadcom: bcmbca: Add spi controller node
    [v2,05/14] spi: bcm63xx-hsspi: Add new compatible string support
    [v2,06/14] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
    [v2,07/14] spi: bcm63xx-hsspi: Add polling mode support
    [v2,08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
    [v2,09/14] spi: bcm63xx-hsspi: Fix multi-bit mode setting
    [v2,10/14] spi: bcm63xx-hsspi: Add prepend mode support
    [v2,11/14] spi: spi-mem: Allow controller supporting mem_ops without exec_op
    [v2,12/14] spi: bcm63xx-hsspi: Disable spi mem dual io
    [v2,13/14] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
    [v2,14/14] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

