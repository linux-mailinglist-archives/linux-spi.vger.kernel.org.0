Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB196B60F7
	for <lists+linux-spi@lfdr.de>; Sat, 11 Mar 2023 22:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCKVUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 Mar 2023 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCKVUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 Mar 2023 16:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C8A73012
        for <linux-spi@vger.kernel.org>; Sat, 11 Mar 2023 13:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2579C60DDB
        for <linux-spi@vger.kernel.org>; Sat, 11 Mar 2023 21:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80613C433D2;
        Sat, 11 Mar 2023 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678569620;
        bh=bMP9SfoGFvp+T4vyCP5bTgL1uAwl/SpHsuk7M3BiYx8=;
        h=Subject:From:Date:To:From;
        b=tBHK+EtbBMbPNlZcccfgSexsrSWRtc589a/KmSf5+YA5lChtz2BE9WtrBnh48WM8E
         g7sLmzSz1CyWXigNAFaNFqaDh5Rb/m8yGAkRbTZCiJjj1+RN3yA9Drv0Asq8BtuYNa
         /1fF5A5yq83vQ64AWrAnFCsfrvrTjbYImw37BCwfDiM5klFnnr3ev0eZOQUbTT+3jk
         Wd7yUDh9y9nz7dma9vq0Ohj5FJb76PFfDqGF5Lk4YWL5DenNCdM5tkd8wkY/dbREq8
         dHxIK/9/41Z6WAULyCohznUqJDkbUzPfgDFo8Id8s+ScTCD1ZXFINYIYjvPbMBNzBc
         UtcjWWhkHv4vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58BE0E61B65;
        Sat, 11 Mar 2023 21:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167856962030.4043.16580599400529387415.git-patchwork-summary@kernel.org>
Date:   Sat, 11 Mar 2023 21:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Add support for stacked/parallel memories
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=727018
  Lore link: https://lore.kernel.org/r/20230306172109.595464-1-amit.kumar-mahapatra@amd.com
    Patches: [V5,01/15] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,02/15] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,03/15] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,04/15] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,05/15] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,06/15] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V5,07/15] powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
             [V5,08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call

Series: Add support for stacked/parallel memories
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=728825
  Lore link: https://lore.kernel.org/r/20230310173217.3429788-1-amit.kumar-mahapatra@amd.com
    Patches: [V6,01/15] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,02/15] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,03/15] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,04/15] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,05/15] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,06/15] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
             [V6,07/15] powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
             [V6,08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call


Total patches: 16

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


