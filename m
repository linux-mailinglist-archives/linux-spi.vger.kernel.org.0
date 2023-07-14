Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865C753731
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jul 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjGNJ4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jul 2023 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjGNJ42 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jul 2023 05:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675392D55
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 02:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD0261CC3
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 09:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F723C433C8;
        Fri, 14 Jul 2023 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689328584;
        bh=Q5I4t26YVSG6d46YPUduhaJTstXtqGRI7O0qBT6hHw8=;
        h=Subject:From:Date:To:From;
        b=vJt21CxsSqBfL4Bt/6aux2APHrnL0fwLUGp6BFVG8UMhMhzNxiSQ9a+mfDROCTPSH
         w4cc6dbbmzfhZABO1ggajxSEiixC1WpxrnCUJO13Mj/CzzHTtMrxeMwX2lrP0EKnvX
         JVDEFH0UXdtg8c8/zLN7mJWeOxJYEqtXDhJP14rp/L7K6DZRKB2dPoIyZR4hLTNFRV
         COF/T00E10owBwSSnQ5WwsPkPesHI5aGv++DPwOmc4gmzQ5L1XmkBS0MaaqVIjmMFQ
         RHO0KsLED5u4HMHBNy8pHe700t3+ddjOGfdjWg8M691rTencjoYVXBKKixjeNNZDlp
         dkqaJkXHpjHrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42098E1B4D6;
        Fri, 14 Jul 2023 09:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168932858426.2425.15859140852573574293.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Jul 2023 09:56:24 +0000
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

Latest series: [v4] spi: Header and core clean up and refactoring (2023-07-14T09:17:48)
  Superseding: [v3] spi: Header and core clean up and refactoring (2023-07-11T17:17:43):
    [v3,01/14] spi: Remove unneeded OF node NULL checks
    [v3,02/14] spi: Deduplicate IDR allocation code in spi_register_controller()
    [v3,03/14] spi: Refactor bus number assigning code in spi_register_controller()
    [v3,04/14] spi: Remove code duplication in spi_add_device*()
    [v3,05/14] spi: Kill spi_add_device_locked()
    [v3,06/14] spi: Use sysfs_emit() to instead of s*printf()
    [v3,07/14] spi: Use BITS_TO_BYTES()
    [v3,08/14] spi: Sort headers alphabetically
    [v3,09/14] spi: Use struct_size() helper
    [v3,10/14] spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
    [v3,11/14] spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
    [v3,12/14] spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
    [v3,13/14] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
    [v3,14/14] spi: Fix spelling typos and acronyms capitalization


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

