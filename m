Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566C4CD08C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Mar 2022 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiCDI5V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Mar 2022 03:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiCDI5S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Mar 2022 03:57:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AC719DEB2
        for <linux-spi@vger.kernel.org>; Fri,  4 Mar 2022 00:56:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE62E60F7E
        for <linux-spi@vger.kernel.org>; Fri,  4 Mar 2022 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37C47C340E9;
        Fri,  4 Mar 2022 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646384190;
        bh=DydWMl6hnaY+6W/4OHk1UNMYw/6C7Tn5U+fT+5hOzTo=;
        h=Subject:From:Date:To:From;
        b=nkH43lt34lHBpsIwk9T1azd1FZAeQRuvX/blO0VGP3wLeGVcxwUSsXh7NtEiHqN7h
         m/7i99S5vjcYTrjK6Qx8wgwLPHHpHabTnPcJ6ucdz4LEDJq+qDWTNkqTnLkq1C1nmb
         9qoMQ57SMmAN7gkeGTtF4+iYbbzPttnVWmQXkWvgtzymR85lfoC2QRNxb626VhuX3Z
         ZIFPMQ0OyhtqWrIUx9IOSdphVVleSzDnCml+yEmQupd4sdZgueSb8jZq06c9jThbaJ
         8KOXs+mw1WFQOVejLIXbbJPq0+kHsYg5RACtlmmSNBANdpG2lQxF3JHc9IsntJK7OQ
         9tfXLDP4fXwtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D10BE6D4BB;
        Fri,  4 Mar 2022 08:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164638419011.19733.14569852788333776735.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 04 Mar 2022 08:56:30 +0000
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

Latest series: [v3] spi: spi-mem: Add driver for Aspeed SMC controllers (2022-03-04T08:36:40)
  Superseding: [v2] spi: spi-mem: Add driver for Aspeed SMC controllers (2022-03-02T17:31:07):
    [v2,01/10] mtd: spi-nor: aspeed: Rename Kconfig option
    [v2,02/10] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
    [v2,03/10] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
    [v2,04/10] spi: spi-mem: Add driver for Aspeed SMC controllers
    [v2,05/10] spi: aspeed: Add support for direct mapping
    [v2,06/10] spi: aspeed: Adjust direct mapping to device size
    [v2,07/10] spi: aspeed: Workaround AST2500 limitations
    [v2,08/10] spi: aspeed: Add support for the AST2400 SPI controller
    [v2,09/10] spi: aspeed: Calibrate read timings
    [v2,10/10] ARM: dts: aspeed: Enable Dual SPI RX transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

