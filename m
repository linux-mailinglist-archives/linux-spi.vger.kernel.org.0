Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376237F1C6A
	for <lists+linux-spi@lfdr.de>; Mon, 20 Nov 2023 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjKTSa6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Nov 2023 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTSa6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Nov 2023 13:30:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB192
        for <linux-spi@vger.kernel.org>; Mon, 20 Nov 2023 10:30:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6569CC433C7;
        Mon, 20 Nov 2023 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700505054;
        bh=jdcwCH7V6RtQhfUVcjeYZqpazVSq8pnz5G3tcBNCliI=;
        h=Subject:From:Date:To:From;
        b=nxTq1A/m5Yx9nBYJTdb/qLKn+qtVnaR+T8BS4ZP15q0eSyqojyAVUwh0ALLIyJoWF
         gU4Yix1yFxG0Ksj9u0naYT4MpOlREAlIbPV8qV+UvmOjiIr06U2+WvRjuZRFvWVo+j
         BwGMYXmjHKmdppgnV8PTGjY5sEWUSibF6nGnhyirHONOQmurUoBx0AruCWf+HrLw42
         P5J2Ym5RUqjW6x+vvtTlIwCLOWDEs0PZrFiSwL8XxeSVn1KmymJcb6yZVLIeBE13t1
         NTxOujOry07HLSyOLIQ13Hh/kHPVxVaraTy1uwvmjhV9vI7o9kDD15X2juLki+k0G2
         t0SLu3GwATmFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E69AEAA958;
        Mon, 20 Nov 2023 18:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170050505416.29141.7728123207776291520.git-patchwork-summary@kernel.org>
Date:   Mon, 20 Nov 2023 18:30:54 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axi-spi-engine improvements
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=802046
  Lore link: https://lore.kernel.org/r/20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com
    Patches: [01/14] dt-bindings: spi: axi-spi-engine: convert to yaml
             [02/14] MAINTAINERS: add entry for AXI SPI Engine
             [03/14] spi: axi-spi-engine: simplify driver data allocation
             [04/14] spi: axi-spi-engine: use devm_spi_alloc_host()
             [05/14] spi: axi-spi-engine: use devm action to reset hw on remove
             [06/14] spi: axi-spi-engine: use devm_request_irq()
             [07/14] spi: axi-spi-engine: use devm_spi_register_controller()
             [08/14] spi: axi-spi-engine: check for valid clock rate
             [09/14] spi: axi-spi-engine: move msg state to new struct
             [10/14] spi: axi-spi-engine: use message_prepare/unprepare
             [11/14] spi: axi-spi-engine: remove completed_id from driver state
             [12/14] spi: axi-spi-engine: remove struct spi_engine::msg
             [13/14] spi: axi-spi-engine: add support for cs_off
             [14/14] spi: axi-spi-engine: add support for any word size


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


