Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB65B9B72
	for <lists+linux-spi@lfdr.de>; Thu, 15 Sep 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIOM5Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Sep 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIOM5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Sep 2022 08:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C49CCE4
        for <linux-spi@vger.kernel.org>; Thu, 15 Sep 2022 05:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B769B8203D
        for <linux-spi@vger.kernel.org>; Thu, 15 Sep 2022 12:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45E44C433D6;
        Thu, 15 Sep 2022 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663246608;
        bh=gvFEzK28lZPBxnoNK/mcvrISvf6Pq3wRfHEczBtrNi0=;
        h=Subject:From:Date:To:From;
        b=TjEJPPrVcEfU/KGlocIpk0W+wqkU0Ng7dWAxeIWMbIws46MNHzNrUuik8R6+ZqQxE
         D8SMMVcvfMvlnUndyT2vQNOaANkriVlpl9bEYY7gx4YuodRFyzviZMoO3uMs5vJiHz
         /lT7FUjqu8cB3S/iaFoH3LGjTTILxdRXPX/J93GNdsYKzVnLwpQ+9Zvb60N9hr4xRc
         mVpeUUYKxsDOP5MknCC17IoqYRfJTW2PzRtYSfC43EpQZ4Npe9o7izdqT5WeAAa8BC
         NZX45br/IKkCd+s5gOLMpVo/AOYrLw/NnPPi58LSIrvrWA0oVk22gYCO6/DQZBvLNv
         j8iukstYYnXZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A554C73FEB;
        Thu, 15 Sep 2022 12:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166324660817.30361.7770001559935490261.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Sep 2022 12:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support (2022-09-15T12:07:43)
  Superseding: [v1] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support (2022-09-01T05:47:24):
    [1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
    [2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
    [3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
    [4/7] firmware: xilinx: Add qspi firmware interface
    [5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
    [6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
    [7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

