Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2B74F79C
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jul 2023 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGKR4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGKR4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 13:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F5E55
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 10:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 794C3615A3
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 17:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD98CC433C8;
        Tue, 11 Jul 2023 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098191;
        bh=h5aDbG51XLItBPpHS4WUM9vmQfxLJ37Q5yXLBKPIQIY=;
        h=Subject:From:Date:To:From;
        b=tfMRbyqSkMOgSQucTmA4UzJbLohB7SmvO+a/1woU0R5b4ffTwhXBMq/zNwb4G1vo2
         o6xJq/BO9QSKmE3QaB4LQDNhgJa6flubclY548TCq157mo2f1sLRg+XGNcf3c44Ipv
         utaQ6YOP0Wp6Crej+Ks2XLmhDQB0xB1PCO9Fq0SStzm/2tORdCKzZMGpx85/JzCxRg
         BnN207Kj5zDECHfjHedcLmLXj8uGsbUXgruYrtSKaM1vTcd3HXhgoPI0DjMp4BoXJW
         5q5+FCaJ4JX7Bwqx1zEpoYfR/wSW2yiNYpCre7W/F+1HifOGI61oMuMDzsI30kmO5K
         rJTTiHyqEmQZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C47ABC4167B;
        Tue, 11 Jul 2023 17:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168909819180.15001.6001393046650311094.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 11 Jul 2023 17:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Header and core clean up and refactoring (2023-07-11T17:17:43)
  Superseding: [v2] spi: Header and core clean up and refactoring (2023-07-10T15:49:18):
    [v2,01/15] spi: Remove unneeded OF node NULL checks
    [v2,02/15] spi: Drop duplicate IDR allocation code in spi_register_controller()
    [v2,03/15] spi: Replace if-else-if by bitops and multiplications
    [v2,04/15] spi: Replace open coded spi_controller_xfer_timeout()
    [v2,05/15] spi: Remove code duplication in spi_add_device_locked()
    [v2,06/15] spi: Use sysfs_emit() to instead of s*printf()
    [v2,07/15] spi: Sort headers alphabetically
    [v2,08/15] spi: Clean up headers
    [v2,09/15] spi: Use struct_size() helper
    [v2,10/15] spi: Use predefined constants from bits.h and units.h
    [v2,11/15] spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
    [v2,12/15] spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
    [v2,13/15] spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
    [v2,14/15] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
    [v2,15/15] spi: Fix spelling typos and acronyms capitalization


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

