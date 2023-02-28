Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0D6A53F3
	for <lists+linux-spi@lfdr.de>; Tue, 28 Feb 2023 08:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjB1H4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Feb 2023 02:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB1H4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Feb 2023 02:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726621944
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 23:56:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C2060FED
        for <linux-spi@vger.kernel.org>; Tue, 28 Feb 2023 07:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D83DEC433EF;
        Tue, 28 Feb 2023 07:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677570978;
        bh=IZSVuq9dEVK6cjHjJY1iwLZqvkcrZS7WO6O1S7tKrAE=;
        h=Subject:From:Date:To:From;
        b=vJd3NNPFXcTzhkFP01aquxzLiuuF0Z+NYFhr/VvRO3oTfQjnmQOmdjnbo/GeLKq+a
         cze6OApxmk1caGYTO1DS7lOiZcX8Gg6pAKe7cFSTAxivUYmVZ2cAcQ5cnUzaE9gbbI
         kRZyuiTWFgU8M0/N4HSeSkPDC1GeBWKYFnKl+V1HG52rlT3q/aRA/Alel0EsVg4r1f
         gjSvoYhS3JrqJUgHsE77GZ2V9oZGIUzEzBI7qburfbDgxILkDHsUAdN87jUWmR5uMW
         j8nBEcwg46qy55pvyNorkKHUMuO9eD8v6DG4cPy5Rc+Ct3PmIAJkk5QEW723fVkik2
         NWq9qTWjJKDoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6EF8E68D34;
        Tue, 28 Feb 2023 07:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167757097869.3937.15621393877825321563.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 28 Feb 2023 07:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add Intel LJCA device driver (2023-02-28T06:56:13)
  Superseding: [v2] Add Intel LJCA device driver (2023-02-25T14:01:13):
    [v2,1/5] mfd: Add support for Intel LJCA device
    [v2,2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [v2,3/5] i2c: Add support for Intel LJCA USB I2C driver
    [v2,4/5] spi: Add support for Intel LJCA USB SPI driver
    [v2,5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

