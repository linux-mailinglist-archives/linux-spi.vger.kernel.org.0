Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BC6D90E8
	for <lists+linux-spi@lfdr.de>; Thu,  6 Apr 2023 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjDFH5T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Apr 2023 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjDFH5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Apr 2023 03:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083D8A54
        for <linux-spi@vger.kernel.org>; Thu,  6 Apr 2023 00:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12C06441D
        for <linux-spi@vger.kernel.org>; Thu,  6 Apr 2023 07:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E09BC433EF;
        Thu,  6 Apr 2023 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680767807;
        bh=Mn0AC9C/qR0lJrW0OZZ7JH8qU2Q4uP9yIGMfztYDg8A=;
        h=Subject:From:Date:To:From;
        b=sETgG4rUjtxmvy1SS8HCAXq+dvCb3esepnhHj9XxNXZnYlfTiIybg7NICXMg0+9pP
         r7Qr3sP3Usbf4EMsxdRUfxRLeBOaCGQgZMWLsUB9NGqzgzgU32rPFIK00wyob5B5yH
         WzlSLTY1/DBy4DC/AcaGRykfSf6g2768c/JHlb6j5HLVfy17IhkBPN1JvtIOVqJfw1
         9+7g8QVTVMndiZrmw4NHI9GpoisCsExDcy6kFV2pPxjhjk36o7RZVDwhotWYS9WYcw
         3P72j0+WkvAI8JLKafe4j3mVF8tMKOfk+HuftNXRvn9ZVbmJKy57Q8i0+nWTRitgfQ
         2Rqp8FxM6mdkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C57A7E29F4B;
        Thu,  6 Apr 2023 07:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168076780680.7822.6532254658753353278.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Apr 2023 07:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: Add support for stacked/parallel memories (2023-04-06T06:53:29)
  Superseding: [v5] spi: Add support for stacked/parallel memories (2023-03-06T17:20:54):
    [V5,01/15] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,02/15] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,03/15] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,04/15] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,05/15] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,06/15] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [V5,07/15] powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
    [V5,08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call
    [V5,09/15] spi: Add stacked and parallel memories support in SPI core
    [V5,10/15] mtd: spi-nor: Convert macros with inline functions
    [V5,11/15] mtd: spi-nor: Add APIs to set/get nor->params
    [V5,12/15] mtd: spi-nor: Add stacked memories support in spi-nor
    [V5,13/15] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [V5,14/15] mtd: spi-nor: Add parallel memories support in spi-nor
    [V5,15/15] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

