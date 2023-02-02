Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCB68838F
	for <lists+linux-spi@lfdr.de>; Thu,  2 Feb 2023 16:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjBBP6n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Feb 2023 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjBBP6X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Feb 2023 10:58:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09779CB5
        for <linux-spi@vger.kernel.org>; Thu,  2 Feb 2023 07:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79DFEB826E3
        for <linux-spi@vger.kernel.org>; Thu,  2 Feb 2023 15:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29EC3C433EF;
        Thu,  2 Feb 2023 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353380;
        bh=r0qU6NTwQyeDhp89qZlFeuPm8mxzaTv2pA/46DvalsA=;
        h=Subject:From:Date:To:From;
        b=S+lhhx1riZE/IXLBHDCzA+RUpIA3OdNV34HS9SebeCXJ5EGHs49EHz4Dy2AsSUVV+
         TNqTU85HHQ22BNWI4B6XuwMBAXPIC1+isKI6rxUhh+TLOWNouIFCEEm/bWWeiei+qn
         xb/NYz3hQtBUqm8MqHxHSy/gjh9VRz04G0lgMjZLPf9ES5alP+/UuG137kn2jDLMbk
         8kdjtldl52niQpr8yJb/AF5bnID9cdprN4WUynvuOd1Fy/+0O0AItoHOREx/0e5iW4
         vYkmLS6jL7zJmqPA6cLO45vKTN6sB5pHp27IBvK4wRbp4C/0k0Lyg2I1/xQksc1GUA
         B5xuYpAOEWa7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19616E21EEC;
        Thu,  2 Feb 2023 15:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167535338009.32066.2878274085771908041.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 02 Feb 2023 15:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Add support for stacked/parallel memories (2023-02-02T15:22:45)
  Superseding: [v2] spi: Add support for stacked/parallel memories (2023-01-19T18:53:29):
    [v2,01/13] spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod
    [v2,02/13] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,03/13] net: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,04/13] iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,05/13] mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,06/13] staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,07/13] platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call
    [v2,08/13] spi: Add stacked and parallel memories support in SPI core
    [v2,09/13] mtd: spi-nor: Add APIs to set/get nor->params
    [v2,10/13] mtd: spi-nor: Add stacked memories support in spi-nor
    [v2,11/13] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [v2,12/13] mtd: spi-nor: Add parallel memories support in spi-nor
    [v2,13/13] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

