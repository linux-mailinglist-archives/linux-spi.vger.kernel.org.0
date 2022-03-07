Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096E4CF250
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 07:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiCGG50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 01:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGG50 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 01:57:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06B606C9
        for <linux-spi@vger.kernel.org>; Sun,  6 Mar 2022 22:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 024A4CE0BB1
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 06:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28279C340EB;
        Mon,  7 Mar 2022 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646636189;
        bh=evFxX2ngGymKCDktD9ZYgjOD85AjEepAv2iBKtQuR0s=;
        h=Subject:From:Date:To:From;
        b=KB3mo1bhY/IRato/7wgohtZgRf1/QbDxl31dhvehISamj7/ty4qMpgVkIZsxlYJ+z
         /o2nVbrvQAOY8cHQavpV6i62xjBZeOCJQuqFH0tRPVqzoygnHDW90h+tgPPUTyb+SK
         SQ67MhegY9IlDD8sjDtG5OV+ZGIKfq6/hJrVs7HSSbw/vG/c1azTzgZ7/Hv6Weo9lM
         rrLQK1DYNWVPzn5FIvVwvuMeNUrRtaiE2SIRF9ZFVTV5+KqGZNdU00ghJ8cWaONss8
         n1AatxRDNNP0ZgZH//SbJyA4qgEKLvBeKGNTRxGN4yo6YJEQzGGmiIP/ED64n2Rk42
         kJZhKrGVTIiqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10F87E6D3DE;
        Mon,  7 Mar 2022 06:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164663618906.11829.10644520487181262913.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Mar 2022 06:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: mediatek: add single/quad mode support (2022-03-07T06:52:23)
  Superseding: [v2] spi: mediatek: add single/quad mode support (2022-02-21T04:07:14):
    [V2,1/6] dt-bindings: spi: Add compatible for Mediatek IPM IP with single mode
    [V2,2/6] spi: mediatek: add IPM single mode design support
    [V2,3/6] dt-bindings: spi: Add compatible for Mediatek IPM IP with quad mode
    [V2,4/6] spi: mediatek: add spi memory support
    [V2,5/6] dt-bindings: spi: support spi-hclk
    [V2,6/6] spi: mediatek: support spi-hclk


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

