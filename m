Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3670F391
	for <lists+linux-spi@lfdr.de>; Wed, 24 May 2023 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjEXJ46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 May 2023 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEXJ4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 May 2023 05:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CAA7
        for <linux-spi@vger.kernel.org>; Wed, 24 May 2023 02:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BB162CA7
        for <linux-spi@vger.kernel.org>; Wed, 24 May 2023 09:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 122BDC4339B;
        Wed, 24 May 2023 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684922214;
        bh=zrWlGwYzOTGuu3krMnkMfjj6rINq3CpATdv5Uv5/2+w=;
        h=Subject:From:Date:To:From;
        b=TS8LwldKH2vZdx3OvqufkuzaZqienPM7QsvtT8xqXgLWRtne/29xUW/VNT0txMZPL
         rqJej4ZHmKV5j7tlmZhUADMZkACD6QIDZY6GMVP3EtmN/CrSsibDGeT1uurwqfFHjT
         pWzFCq0Vv2H5G3gcBSs64Przdh95xWZd9g+7dGnz7A6yk7QldtO7VWWer2Sv04+k9n
         RHIqMjmLkTC7PVGeAwNhLXT6MW690JuhUHNmrlaMTqc8W19VkW8cpNBTURPvs83dAG
         TKXZgOMFmZGXmd0RsC9MlvjcOuN9j+dEZKQGi9GSgS6xS60lnosPwEOaWZ550n0/iF
         04ZXolq8Xrd1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECC2FC4166F;
        Wed, 24 May 2023 09:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168492221396.24089.17172332336440487204.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 24 May 2023 09:56:53 +0000
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

Latest series: [v6] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-24T09:19:43)
  Superseding: [v5] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-20T19:08:51):
    [v5,1/4] spi: add SPI_MOSI_IDLE_LOW mode bit
    [v5,2/4] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
    [v5,3/4] spi: spidev: add two new spi mode bits
    [v5,4/4] spi: spidev_test Add three missing spi mode bits


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

