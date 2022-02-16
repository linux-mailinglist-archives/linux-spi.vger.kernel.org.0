Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92A4B7CEF
	for <lists+linux-spi@lfdr.de>; Wed, 16 Feb 2022 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbiBPB4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Feb 2022 20:56:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbiBPB4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 20:56:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6A3DFBD
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 17:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5346A617EC
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 01:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBEABC340EB;
        Wed, 16 Feb 2022 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644976581;
        bh=fBm0UUUiVu3Nb4ce+cqdb0XiQPbtDAGl07dzwzZo3+Q=;
        h=Subject:From:Date:To:From;
        b=WVMh2nWbmfgYlvidBbrGKFQCAO9cryg3TZ1ce7yno6zIngNcfqkZWj2ai8OWnKp8D
         EhJJBWkjsW7dL6+Ccct6R2MvKOLrxiAP1IPm2cdTTgicam4nNNeCIuwm7zlizAfe1S
         aJPP3FhJGJmS65B5h7NCuRDBJ3EHNIzNfbvNwnZC0YuDsRwrAVRs5NVCMpcTUoyEMT
         wp5LwVVnqOsiFG4XVVny0/pJvy7gY4im6r7BHFy9Sn3Etv1IBT50ZHv3sseyG5M8bw
         j2r9fYB6lrwFLmTzib5QTPdftMBZxRnoORw4wKuuvkubvvKxqm9sYKlHKWX64EezhC
         4Dd75CBeaY5rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA727E6BBD2;
        Wed, 16 Feb 2022 01:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164497658169.20944.11978254419395912212.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 16 Feb 2022 01:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] New support and problem adjustment of SPI rockchip (2022-02-16T01:40:22)
  Superseding: [v2] New support and problem adjustment of SPI rockchip (2022-02-14T08:43:33):
    [v2,1/6] spi: rockchip: Fix error in getting num-cs property
    [v2,2/6] spi: rockchip: terminate dma transmission when slave abort
    [v2,3/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
    [v2,4/6] spi: rockchip: Preset cs-high and clk polarity in setup progress
    [v2,5/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
    [v2,6/6] spi: rockchip: clear interrupt status in error handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

