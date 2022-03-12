Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE34D6F5B
	for <lists+linux-spi@lfdr.de>; Sat, 12 Mar 2022 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiCLN5s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Mar 2022 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLN5s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Mar 2022 08:57:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7F184B47
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 05:56:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D447B80184
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 13:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1CC4C340EB;
        Sat, 12 Mar 2022 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647093400;
        bh=k08og7whGCO4OANKhtVVBR6XfBc5ZAuEUCtqQ7c+EmQ=;
        h=Subject:From:Date:To:From;
        b=XM4ziePd+QxZvsvp4v6lXVqlIdd17DOc4vf4qpLrdwRAJgn/GBKvbBaW1tc8J1KKj
         sEz79dajJdJIdAo7hCDJzeRTlOa+hblmqzFwVP9IRSp4plfV2lzlrVYmXOEnV3m8sb
         6iZSV2LqUYyNc6ovkJORzyG5KYN00vTPJ7ukmF+nsOz9rOOfsGWTqy1NWjqDrogwyp
         hL8+6EB1tNwNcloyjKMyjFbcD+D/XQN0yIhu4JcaqXXLzZa4sJPWrvWdUnBRKrqFKy
         oHjFeg1GIuoaOwaiRUWktQBAj6PKGpG+ji/pZ3teXdFBPahO34jG3k4+ERvE0F5k7q
         cm8a1xHV4yCVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E918E6D3DD;
        Sat, 12 Mar 2022 13:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164709340064.25008.10906378138835769090.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 12 Mar 2022 13:56:40 +0000
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

Latest series: [v4] Fix broken usage of driver_override (and kfree of static memory) (2022-03-12T13:28:45)
  Superseding: [v3] Fix broken usage of driver_override (and kfree of static memory) (2022-02-27T13:52:04):
    [v3,01/11] driver: platform: Add helper for safer setting of driver_override
    [v3,02/11] amba: Use driver_set_override() instead of open-coding
    [v3,03/11] fsl-mc: Use driver_set_override() instead of open-coding
    [v3,04/11] hv: Use driver_set_override() instead of open-coding
    [v3,05/11] PCI: Use driver_set_override() instead of open-coding
    [v3,06/11] s390: cio: Use driver_set_override() instead of open-coding
    [v3,07/11] spi: Use helper for safer setting of driver_override
    [v3,08/11] vdpa: Use helper for safer setting of driver_override
    [v3,09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
    [v3,10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
    [v3,11/11] rpmsg: Fix kfree() of static memory on setting driver_override


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

