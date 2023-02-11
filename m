Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9846C692C5B
	for <lists+linux-spi@lfdr.de>; Sat, 11 Feb 2023 02:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjBKBAZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Feb 2023 20:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBKBAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Feb 2023 20:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C729405
        for <linux-spi@vger.kernel.org>; Fri, 10 Feb 2023 17:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C433161EED
        for <linux-spi@vger.kernel.org>; Sat, 11 Feb 2023 01:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D64C433D2;
        Sat, 11 Feb 2023 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676077219;
        bh=FN/ISS5VggkX91CGIUcGafEa5F2nNcXh4Utcsa32vIU=;
        h=Subject:From:Date:To:From;
        b=GkR0MebZR0nQu+82JnRbeKxAHmonlErW/kiHhVl8pXPms1qhxXSLNBbo2/+He3vLy
         2MHQr7L0iDqLoQGWMSiyfZV5sVAyGpRRJjre1LW2CZ+FcblT2JnuKs323cIMTxDQ4Y
         I9hsj6OU1ORDKz08vPkn8LwSV+0tySuqne51Z53aImvFCfXjHsnEbsm+qXLdjcSwxu
         2s2TjOMqtof+T+kuA6aNhYTvqokg/381E33xkYU/3TLqdDRZbP0ammZTbi+YjHJ5iT
         40z3D7iZsNaRR9Rj40l0W2IXncrotajk5Dw/y7B8uNLTRBpwTOTIuyZSUpapAx1cPV
         stVevrpVF3pPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03DDEE21EC5;
        Sat, 11 Feb 2023 01:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167607721894.15103.14471867955291661915.git-patchwork-summary@kernel.org>
Date:   Sat, 11 Feb 2023 01:00:18 +0000
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

Series: spi: bcm63xx-hsspi: driver and doc updates
  Submitter: William Zhang <william.zhang@broadcom.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=720455
  Lore link: https://lore.kernel.org/r/20230209200246.141520-1-william.zhang@broadcom.com
    Patches: [v4,01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
             [v4,09/15] spi: bcm63xx-hsspi: Handle cs_change correctly
             [v4,10/15] spi: bcm63xx-hsspi: Fix multi-bit mode setting
             [v4,11/15] spi: bcm63xx-hsspi: Add prepend mode support
             [v4,12/15] spi: spi-mem: Allow controller supporting mem_ops without exec_op
             [v4,13/15] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
             [v4,14/15] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
             [v4,15/15] MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


