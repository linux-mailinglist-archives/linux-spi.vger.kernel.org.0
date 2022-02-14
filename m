Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF14B44FF
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiBNI41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 03:56:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiBNI4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 03:56:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1B5F8F8
        for <linux-spi@vger.kernel.org>; Mon, 14 Feb 2022 00:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F28D60E96
        for <linux-spi@vger.kernel.org>; Mon, 14 Feb 2022 08:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEDD9C340E9;
        Mon, 14 Feb 2022 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644828977;
        bh=OWXBI89xnc+Ns8is3COFfOm9034qzIN6ki0qWs51uks=;
        h=Subject:From:Date:To:From;
        b=fWAVCJpM4M4Yk1IhG2vC24t7x3M/v1paj80hLjvMZ7YsIsbbGoZbwk1G1BNV2j9f4
         zqITqqBrPwgkqNxNKWgOKDz9yDTPpDyb0cg0YfO8uuGwaC0xzer6kiv3Zj1T8P2qYb
         tl0eQ6KfJ6HsL7P5w8s4GMTnj85CgaHdIWuGVvA2fboy+ZtyKjRkY8+Ag9oHWTSwj+
         U31MhgY0pRhvVzrDsMjqdGx2Miihw1Cc/wABQHQfL1+AqYuxoZ4Zmz9Jss7wvyHdJR
         fWAR3EDbCHlVuKvUH7CyaGazSJNb+R0lLs/Iurkq26VCJeXqNvLcEfUlqcjE7bjPnH
         VYV6I/3DvBXXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B225AE6D447;
        Mon, 14 Feb 2022 08:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164482897766.17505.9917967390872461400.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 14 Feb 2022 08:56:17 +0000
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

Latest series: [v2] New support and problem adjustment of SPI rockchip (2022-02-14T08:43:33)
  Superseding: [v1] New support and problem adjustment of SPI rockchip (2022-02-11T03:49:32):
    [RFC,v1,1/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
    [RFC,v1,2/6] spi: rockchip: Preset cs-high and clk polarity in setup progress
    [RFC,v1,3/6] spi: rockchip: Fix error in getting num-cs property
    [RFC,v1,4/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
    [RFC,v1,5/6] spi: rockchip: terminate dma transmission when slave abort
    [RFC,v1,6/6] spi: rockchip: clear interrupt status in error handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

