Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5A4CAC9F
	for <lists+linux-spi@lfdr.de>; Wed,  2 Mar 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiCBR5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Mar 2022 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiCBR5M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Mar 2022 12:57:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE170D10AA
        for <linux-spi@vger.kernel.org>; Wed,  2 Mar 2022 09:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C668B820E4
        for <linux-spi@vger.kernel.org>; Wed,  2 Mar 2022 17:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59F26C004E1;
        Wed,  2 Mar 2022 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646243786;
        bh=4GU1QKlKrw6vuuWvBYPuw5+Jm7yi8ApjhTQYA1b8PFE=;
        h=Subject:From:Date:To:From;
        b=oYxg0eh+X+ylPzY/Yr7KaXpYShi+AsU8AMtubRsmLh+VPZGM4dlUqMiFThEo1pxDG
         lWLwH7M6rXfpSHX+IyTjKPBm6d/zEjbGUwRdbUpJ7EU9RIxaJXBRqS8iXjS+YaIVB6
         HsF9R9LQR5BlcwexxkeQK89WXQfmT/X+HmX52kuMu3G3hVeRC7Th8zhk2lOpk+xHxv
         jg9zaLF7RxUC6nP9qZw12C3SEc8w+UcJllBcXOJdeNfee+epJa2km2OX1oTvAYrm9J
         AdakXT/P3GflH+Us3eAVnwbB8jqBqAgUU9cKUsPf9YKcCWety6viK2bnY+N6tT2WoN
         BMSUv+JoD2ktA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B2B7E6D44B;
        Wed,  2 Mar 2022 17:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164624378623.27025.3629585775704559543.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 02 Mar 2022 17:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mem: Add driver for Aspeed SMC controllers (2022-03-02T17:31:07)
  Superseding: [v1] spi: spi-mem: Add driver for Aspeed SMC controllers (2022-02-14T09:42:22):
    [01/10] mtd: spi-nor: aspeed: Rename Kconfig option
    [02/10] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
    [03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
    [04/10] spi: aspeed: Add support for direct mapping
    [05/10] spi: aspeed: Adjust direct mapping to device size
    [06/10] spi: aspeed: Workaround AST2500 limitations
    [07/10] spi: aspeed: Add support for the AST2400 SPI controller
    [08/10] spi: aspeed: Calibrate read timings
    [09/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
    [10/10] spi: aspeed: Activate new spi-mem driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

