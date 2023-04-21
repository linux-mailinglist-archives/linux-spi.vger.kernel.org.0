Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324EC6EA7A7
	for <lists+linux-spi@lfdr.de>; Fri, 21 Apr 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDUJ4w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Apr 2023 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDUJ4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Apr 2023 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60CA268
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 02:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4D064FA2
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 09:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00A14C433EF;
        Fri, 21 Apr 2023 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682071010;
        bh=Kc+btWASR80ien6rF33a+sjCcq/iTPl/848Gcypnu3I=;
        h=Subject:From:Date:To:From;
        b=OvXrYw4rGltm4MqSaSUDIwK7mmONXcmPremrtiZ+3ElVPGHHj60R651XK4iozqb2p
         AM2TJxt7nTTXUyiubZV1xvjM0TJ5Z8M50W1y2DRuQh5Mhcr/3tfLOIjA04wfPxdHUv
         loxNdaQWPo1v6LjWnowWrjBlLxvg2NWPetaVldkjfM9lFzYvzJEXVBT6j9tfV1qjR5
         KdqDbbxzlDpCTBQuTG9B9gJ69I2FFyNU9gk8Bd9sNhA+zfbrqmdWsdVWLS4LuRmolY
         yhpbURhuUap6M/VM/jW1+eW1GWKRiGenDfNE4Qg10Bbf+lF8XloUq2MAI4VKp9snwA
         Pgqr6L2IQviyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC0D1C561EE;
        Fri, 21 Apr 2023 09:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168207100989.14620.5854816049388508907.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Apr 2023 09:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] Tegra TPM driver with HW flow control (2023-04-21T09:13:07)
  Superseding: [v9] Tegra TPM driver with HW flow control (2023-03-25T18:34:06):
    [V9,1/3] spi: Add TPM HW flow flag
    [V9,2/3] tpm_tis-spi: Add hardware wait polling
    [V9,3/3] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

