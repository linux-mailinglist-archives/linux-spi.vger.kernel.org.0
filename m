Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6F6ACBB9
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCFR6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 12:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCFR6g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 12:58:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6916B5DE
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 09:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB9C61085
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 17:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57323C4339C;
        Mon,  6 Mar 2023 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678125397;
        bh=RygmouDesmm8hFuRCfLXpmBQxpTjTyE81QH/Ujb0H1s=;
        h=Subject:From:Date:To:From;
        b=mmZHz9yog1Q5zoVbGaBd4vcVVssr3Qfgk3QZh1hR5pYwcGaqYJOfg6ASC45+FUF3Q
         XnvINxVVc05gLSAEwMpca36m4M7nqEdFJhj8DTt0rWlXtZsl7P7zWepvz9c3sZHjIe
         ONXywlPjyE+/83256Tsq2FKW5z59HlcmaqKYN0tYVIdTiFgltvBzjtmqA4x3oLZNsT
         1TKtmfJk87Qn+ZmbLo5u6lRrrRldmwVtLzRmIiKx7LtKGUnfyDxsaYENDC2FBvv7lA
         TAVkJpc/e18rV6MCJvtIRWdBOnL4JjdLEbz6NSWzoHVb3zjc1z0IdIoe7rtiMYSu1i
         XyeHlCRaBUJ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 448FAE55B15;
        Mon,  6 Mar 2023 17:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167812539727.1565.3244432069338351524.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Mar 2023 17:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: Add support for stacked/parallel memories (2023-03-06T17:20:54)
  Superseding: [v4] spi: Add support for stacked/parallel memories (2023-02-10T19:36:31):
    [v4,01/15] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,02/15] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,03/15] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,04/15] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,05/15] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,06/15] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v4,07/15] powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
    [v4,08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call
    [v4,09/15] spi: Add stacked and parallel memories support in SPI core
    [v4,10/15] mtd: spi-nor: Convert macros with inline functions
    [v4,11/15] mtd: spi-nor: Add APIs to set/get nor->params
    [v4,12/15] mtd: spi-nor: Add stacked memories support in spi-nor
    [v4,13/15] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [v4,14/15] mtd: spi-nor: Add parallel memories support in spi-nor
    [v4,15/15] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

