Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96236AB5C9
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 05:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCFE4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Mar 2023 23:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCFE4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Mar 2023 23:56:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1CE079
        for <linux-spi@vger.kernel.org>; Sun,  5 Mar 2023 20:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D684AB80C0A
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 04:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E75C433EF;
        Mon,  6 Mar 2023 04:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678078589;
        bh=09jCZQ/Mk8Rr9YbTb4EQ9wMCBJb6K/7JyXe1g5wUH9Y=;
        h=Subject:From:Date:To:From;
        b=S0P+06DppWkQvJIDetZVRAeHQPHKjK6PHCYFNtPRU0lEnYdhivd7ac4Io51sI3VhP
         ZsbZ13ZB35PHuZ3cNz+vDAapdpG9gcW77slqaz8JqwlKTEIGKNjNxcvjc2apE6WIIv
         g/dYTPZXbGFX8yxpyHSpZ4HewZEN0RRTnnIZ4+AY6dPWg5AyXy4W6895UbOprXu6F3
         bMJQoyR5QeS0vcEG1OU7RNB91M8JeytqwtrByskPOFgeaocj/VwoJAgqQglax2Rqyt
         JWf+wOlLoz2ECgcXQZTRrZVdIFYtIJAbiUUnOCyZHcPILJpdxq8KLwU3Z8b6My2/gY
         KrfNJF2cxhH9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60524E55B14;
        Mon,  6 Mar 2023 04:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167807858932.22217.14872997778977047807.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Mar 2023 04:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] Support AMD Pensando Elba SoC (2023-03-06T04:07:24)
  Superseding: [v9] Support AMD Pensando Elba SoC (2023-01-19T03:51:23):
    [v9,01/15] dt-bindings: arm: add AMD Pensando boards
    [v9,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
    [v9,03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v9,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
    [v9,05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
    [v9,06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando System Resource chip
    [v9,07/15] MAINTAINERS: Add entry for AMD PENSANDO
    [v9,08/15] arm64: Add config for AMD Pensando SoC platforms
    [v9,09/15] arm64: dts: Add AMD Pensando Elba SoC support
    [v9,10/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v9,11/15] spi: dw: Add support for AMD Pensando Elba SoC
    [v9,12/15] mmc: sdhci-cadence: Enable device specific override of writel()
    [v9,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
    [v9,14/15] mmc: sdhci-cadence: Support mmc hardware reset
    [v9,15/15] spi: pensando-sr: Add AMD Pensando SoC System Resource


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

