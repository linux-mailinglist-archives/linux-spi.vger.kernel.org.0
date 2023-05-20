Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67870AACA
	for <lists+linux-spi@lfdr.de>; Sat, 20 May 2023 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjETT4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 20 May 2023 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjETT4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 20 May 2023 15:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857397
        for <linux-spi@vger.kernel.org>; Sat, 20 May 2023 12:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A792260ADC
        for <linux-spi@vger.kernel.org>; Sat, 20 May 2023 19:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13413C433EF;
        Sat, 20 May 2023 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684612607;
        bh=Axh76XfqDLo2d3WiED1otzPy4u1orlRho+VKmVFLHHo=;
        h=Subject:From:Date:To:From;
        b=kAJe5aCEHA8GWGot3l6Q8u4cQEX8TyC7aC84/1zgIscJUOPpJN8l7o/iolQI/XXb/
         2mMhnjBxGjULCX5DgD0QBvGQ9DlPB5+cGxJNJWH4F9G5cP4MmkrGEOPhlAMdqhwP6u
         ppL8wMv0cRsHSnOCXwz2BtvtnL0+UC/oq04mE+kLqcbLYE6kmsqOnX7Imgrg+W3GZj
         Mh/fM6mH9F1m/CIspqgzNCFgO6cuNd7WZfmZ0ia9PMDss8GFSiUpq1ytnz2OsietKy
         wIvdALzqemvte8NAc3nK5Tng5I1esjs1fHRMbgxTP5/byq12PJ6Y9IrwyNeAwP9TQS
         K4R4rjAoMdz1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E10EBC73FE0;
        Sat, 20 May 2023 19:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168461260684.30045.9196458940900511661.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 20 May 2023 19:56:46 +0000
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

Latest series: [v5] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-20T19:08:51)
  Superseding: [v4] spi: add SPI_MOSI_IDLE_LOW mode bit (2023-05-17T22:30:05):
    [v4,1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
    [v4,2/3] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
    [v4,3/3] spi: spidev: add SPI_MOSI_IDLE_LOW mode bit


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

