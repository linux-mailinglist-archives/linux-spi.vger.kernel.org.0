Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2071E7A0494
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjINM4r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbjINM4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 08:56:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265471FD4
        for <linux-spi@vger.kernel.org>; Thu, 14 Sep 2023 05:56:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C227DC433C8;
        Thu, 14 Sep 2023 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694696202;
        bh=OT9gUSMNvN8qtrxD5UYVlxXObIiCcvamFHaasruHTGw=;
        h=Subject:From:Date:To:From;
        b=EaouEfhlUVSgXUWG2OactieyaF57zFw3/sCfHw8h7yrUadHBMTrQutK7RtdPY7Ruv
         bz0jj/ValTSIrwKBJwgMQw10v17dXf30dSG5B2y+jnJa3VanxOlsZFYoYrWKFvmxak
         tP1BJBF7+Z73BBdzOdZ6MkBlRKA1qWUuV5LTEpCiPU+8lWZGaoOWNmdvpNE7iyqr/V
         XtKKxICekYVNwneaeXD77V5UBjNClhb79sXjGQb05DzbLkGvy+N18XzIz4Kdzc8Tg4
         Trf4NVf/rjodNRd9PCV3QdvQAnOnwEJ/SqHI9fAEjUX41542JW7z7PIooDOy0dB+g/
         5oMWzwR0lh38A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB5CE1C280;
        Thu, 14 Sep 2023 12:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169469620269.15306.11204239201065244534.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 14 Sep 2023 12:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v17] Add Intel LJCA device driver (2023-09-14T12:45:26)
  Superseding: [v16] Add Intel LJCA device driver (2023-09-13T01:40:08):
    [v16,1/4] usb: Add support for Intel LJCA device
    [v16,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v16,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v16,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

