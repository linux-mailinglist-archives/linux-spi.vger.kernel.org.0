Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BBE79107E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Sep 2023 05:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbjIDD5E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Sep 2023 23:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjIDD5C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Sep 2023 23:57:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C672F0
        for <linux-spi@vger.kernel.org>; Sun,  3 Sep 2023 20:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 395FDB80D39
        for <linux-spi@vger.kernel.org>; Mon,  4 Sep 2023 03:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D869EC433C8;
        Mon,  4 Sep 2023 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693799812;
        bh=cwsbdt209ApbNkZHqlVeNGWBFH1MrmtqsS/XD6aedhg=;
        h=Subject:From:Date:To:From;
        b=lM3JniNugqr0/ZOSLz/2WOoJDoe7g0EAJW6t3fIDmoDy5GAMqpmyTH25I9Lf9eD/T
         yrVYg0zdlfseIPwJx+y23E3wwwq1iuyPFZD3F2ChkFeVCce2B7sysEs2zlAbsuv7DI
         yR2/lCoA0gHmFnc+nON0p5h76SEfhPf7EUWAydn7zzYjHv1yZMOp7ir+wD0yhoDNLK
         KYX9LsrREUcqvgcMyqiNPB0cHcfxlmsgMMu/sKmGi3eCtBOvGeyiDWdgY52lCuHr4d
         nwcahj9yinHuBxLJ4fJKsvc04JaXAyxn3F+J0b9IT1A4UcxLivnGKi11X/pfOONhfT
         P9svLNu4luB1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7CD5C04DD9;
        Mon,  4 Sep 2023 03:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169379981274.13683.13773008956425601832.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Sep 2023 03:56:52 +0000
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

Latest series: [v13] Add Intel LJCA device driver (2023-09-04T03:17:38)
  Superseding: [v12] Add Intel LJCA device driver (2023-09-01T05:36:13):
    [v12,1/4] usb: Add support for Intel LJCA device
    [v12,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v12,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v12,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

