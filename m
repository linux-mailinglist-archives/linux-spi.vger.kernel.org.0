Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8C793442
	for <lists+linux-spi@lfdr.de>; Wed,  6 Sep 2023 05:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIFD4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Sep 2023 23:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFD4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Sep 2023 23:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3DDCE2
        for <linux-spi@vger.kernel.org>; Tue,  5 Sep 2023 20:56:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB442C433C8;
        Wed,  6 Sep 2023 03:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693972605;
        bh=c2h4YAbXgLk+Vjccbi9oUEGG8HwtVYrKMYrEpA7cnuo=;
        h=Subject:From:Date:To:From;
        b=Nx6KKusVLg1mMui5Xn6rOa+fEAoDX3LDMRHN9YTNKr/hUt3nYTVJ+rLI2eakTZ8wE
         RwDq16uA6oInHAlTL3eoRmLOfimQLPHB5WiEjf79IW4FgPIGj0M2hn/Vlm3WRkDreP
         gBwJdpXZPzQu1j8NJRPUUdmnzzSSwkPFbz/vmumwrtjE812kVC7oc2CXcUtebqoWIk
         DzayW7wvkX6p1qlQS3xMYO0JgDjQQkLUt0ns9pjG2DPJbY1kKRXidNC0+Ur1RranIz
         PpthqfJi20ElQsc3dF+U/+m4FKS2uCBtrDVxQgw6WlDrYy7oUh9m9jsuWXFae0JYmi
         VHsXaOsQd7J3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3C34C04D3F;
        Wed,  6 Sep 2023 03:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169397260566.21068.12009895030263976771.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 06 Sep 2023 03:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v15] Add Intel LJCA device driver (2023-09-06T03:22:56)
  Superseding: [v14] Add Intel LJCA device driver (2023-09-04T05:44:17):
    [v14,1/4] usb: Add support for Intel LJCA device
    [v14,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v14,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v14,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

