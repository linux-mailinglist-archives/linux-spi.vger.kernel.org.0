Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C80692780
	for <lists+linux-spi@lfdr.de>; Fri, 10 Feb 2023 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjBJT41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Feb 2023 14:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBJT41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Feb 2023 14:56:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00335B1
        for <linux-spi@vger.kernel.org>; Fri, 10 Feb 2023 11:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3162E61E8F
        for <linux-spi@vger.kernel.org>; Fri, 10 Feb 2023 19:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981B2C433EF;
        Fri, 10 Feb 2023 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676058985;
        bh=DUlZOloXWat+3220FA2nC+RbclHDpVia6vmAwOnLbgU=;
        h=Subject:From:Date:To:From;
        b=fG+Gz4TvSSHjDpgFcD3u1OFzp9pJFomr6Ih57cDNcSjKXYwLDfkZdPbg8kKNm28xF
         AVaMiBFpKnmHg7HxvfXu+GY8WPwqyYAEnKoDwkSAc0Vy88TizaLyAANx3oowo3BcSK
         GYLBGURrezM4ObEHWU00DjhXqWbd0bnZ/aZ9Z2aPFP9SsqjqzhB1uPSpFbXsNblx+I
         BnP1MWt6txhHg86U47kpbp7h3xQyrLb7cGGggY7ty62XDOgDXaweMQfuh7nN6JuYeR
         tN1fEOkFNAj9wH5ZDR8BOnRiLS1z0zx003eBc5hMXAN2MDlH0kSqYtD+Bs8fWTfwb9
         Du5GEPqPGG8Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AE20E55EFD;
        Fri, 10 Feb 2023 19:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167605898549.17330.15439899576358809489.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Feb 2023 19:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: Add support for stacked/parallel memories (2023-02-10T19:36:31)
  Superseding: [v3] spi: Add support for stacked/parallel memories (2023-02-02T15:22:45):
    [v3,01/13] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,02/13] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,03/13] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,04/13] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,05/13] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,06/13] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v3,07/13] spi: Add stacked and parallel memories support in SPI core
    [v3,08/13] mtd: spi-nor: Convert macros with inline functions
    [v3,09/13] mtd: spi-nor: Add APIs to set/get nor->params
    [v3,10/13] mtd: spi-nor: Add stacked memories support in spi-nor
    [v3,11/13] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [v3,12/13] mtd: spi-nor: Add parallel memories support in spi-nor
    [v3,13/13] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

