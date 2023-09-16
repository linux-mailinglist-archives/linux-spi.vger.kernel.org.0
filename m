Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373A7A325D
	for <lists+linux-spi@lfdr.de>; Sat, 16 Sep 2023 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIPT5J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Sep 2023 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjIPT4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Sep 2023 15:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ACC1AB
        for <linux-spi@vger.kernel.org>; Sat, 16 Sep 2023 12:56:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FCAC433C7;
        Sat, 16 Sep 2023 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694894208;
        bh=IKfP66rdF4+GONoDTaUQ4/C4/eoJU4ZW0+mevo0pcAA=;
        h=Subject:From:Date:To:From;
        b=qiWFLNdM0StAal2j0vKY7EOGKrg8x2XdVb9VAGt9guejTR8V8cY80dlf4PQW5URUj
         WIQV4gmT+ov83iwvdfbvjEx8pr/Ybx5yhQ8mYorvUGzAhoHJ7T1MoJKSBthEGLs9CG
         ISnb9Folh8Wpp+k8KKPv3mpu2eXy4GuOadeJdzbMJ6xBejDxj3G57F9SAU6FkCBecy
         b2GW5jLJ8ezvm1JmDrGeCV8aynswcqsttQqdeTLpHbwFn6MiwGmoL5sdX5AcBXhE/M
         SkDHQd6yXFdTSrrcjbIB6mrHtLOg3eNql9f9SNdjLWw72LQDTpJsRDwhZtaxddjwry
         wPZ7SzpZD7c1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67B92E26882;
        Sat, 16 Sep 2023 19:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169489420842.30534.4146555563420341618.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 16 Sep 2023 19:56:48 +0000
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

Latest series: [v19] Add Intel LJCA device driver (2023-09-16T18:53:34)
  Superseding: [v18] Add Intel LJCA device driver (2023-09-16T18:37:18):
    [v18,1/4] usb: Add support for Intel LJCA device
    [v18,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v18,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v18,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

