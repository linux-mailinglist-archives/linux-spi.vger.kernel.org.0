Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B086FF9AE
	for <lists+linux-spi@lfdr.de>; Thu, 11 May 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbjEKS4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 May 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKS4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 May 2023 14:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6430C5
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 11:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1387863D78
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 18:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 785E6C433EF;
        Thu, 11 May 2023 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683831407;
        bh=Ddtp0+hSoM/KfhKjiFIPxGgbeZSjosgLV9g9iL77V4o=;
        h=Subject:From:Date:To:From;
        b=Lszc1yiI2/rpkxfFrqD5Y/Bw4ter+05SSy0Huymzp3QSlZLUOvlz/L8C2FPgwyrYA
         FlhKn1zoZukOnBwk90SfltUvsOl1+Sdh+DjANPqlgbvoi2P213MYTZwNZ0v6y24uUc
         IWkwLYAEVVKOkRCXDrXedPZWv48/yyjJfo1kxDtTlrwmhsQPpxpyctIGa4NCERvD8D
         B5bwH/RVhnAHDkZJ5vccQv0NTJ27kab3ldK1nVgDGV1iTif0Q8TwIgPBKxlb5rE383
         tP9TtX71MO5bm3Uukfa7P5rkENoVkfHU+OeO1bs3YqVpUbNNMK4/TKsisyu3R+nhDi
         O4yUBXmgNIc9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58900E26D4C;
        Thu, 11 May 2023 18:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168383140735.26235.13087231582850850333.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 11 May 2023 18:56:47 +0000
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

Latest series: [v8] Add Intel LJCA device driver (2023-05-11T17:58:38)
  Superseding: [v7] Add Intel LJCA device driver (2023-03-25T15:47:05):
    [v7,1/6] usb: Add support for Intel LJCA device
    [v7,2/6] usb: ljca: Add transport interfaces for sub-module drivers
    [v7,3/6] Documentation: Add ABI doc for attributes of LJCA device
    [v7,4/6] gpio: Add support for Intel LJCA USB GPIO driver
    [v7,5/6] i2c: Add support for Intel LJCA USB I2C driver
    [v7,6/6] spi: Add support for Intel LJCA USB SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

