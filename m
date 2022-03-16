Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562D14DB577
	for <lists+linux-spi@lfdr.de>; Wed, 16 Mar 2022 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357342AbiCPP6B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Mar 2022 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352277AbiCPP57 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Mar 2022 11:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FC5FF0E
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 08:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72EC7B81BE7
        for <linux-spi@vger.kernel.org>; Wed, 16 Mar 2022 15:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4166DC340E9;
        Wed, 16 Mar 2022 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647446203;
        bh=NbBmt2i8y/rJy3dMqNDr3mShvLFkNaeGufy/z5HKzxY=;
        h=Subject:From:Date:To:From;
        b=UXbZd3rGVdoc0l2usScUOC252hsUfTDFhW3pY+5qQzH46RiCzorVQ+MAx0bUm/w/r
         VP+q4qp9B2nlT5vD7x6EvvzoOgdThM4eKGEJk/nE4iY1tDrGhPCKAwRP5UQlpNuN/4
         U4ZTdO5rahMPrkpOp4LWjZRkP1gcwJ6Wvi9/W6V6WbscaDS+S98xM695VIep46e0q1
         iS54vlkVd9VsvK8/aWLLl96+Ti6nJMm5WHx+QHCw2oPuXEX+/GVSgJbhbvpRtuY/2o
         jy+5Ce1Uybukv214NujqBjgRvUojnpX+aoV7kvQmFNrK8K24Wki11GjlOStO0LHV/n
         SWera7ipUQEwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 224CCE6BBCA;
        Wed, 16 Mar 2022 15:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164744620313.10882.890390532120953797.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 16 Mar 2022 15:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Fix broken usage of driver_override (and kfree of static memory) (2022-03-16T15:05:22)
  Superseding: [v4] Fix broken usage of driver_override (and kfree of static memory) (2022-03-12T13:28:45):
    [v4,01/11] driver: platform: Add helper for safer setting of driver_override
    [v4,02/11] amba: Use driver_set_override() instead of open-coding
    [v4,03/11] fsl-mc: Use driver_set_override() instead of open-coding
    [v4,04/11] hv: Use driver_set_override() instead of open-coding
    [v4,05/11] PCI: Use driver_set_override() instead of open-coding
    [v4,06/11] s390/cio: Use driver_set_override() instead of open-coding
    [v4,07/11] spi: Use helper for safer setting of driver_override
    [v4,08/11] vdpa: Use helper for safer setting of driver_override
    [v4,09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
    [v4,10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
    [v4,11/11] rpmsg: Fix kfree() of static memory on setting driver_override


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

