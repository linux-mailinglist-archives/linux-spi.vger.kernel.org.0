Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B493517DF1
	for <lists+linux-spi@lfdr.de>; Tue,  3 May 2022 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiECHAG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 May 2022 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiECHAF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 03:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A529CA6
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 23:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6441DB81C97
        for <linux-spi@vger.kernel.org>; Tue,  3 May 2022 06:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29BADC385A4;
        Tue,  3 May 2022 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651560991;
        bh=pjUqKugTv7pOEetfiECJxzbEb5GelQ61gmqhPkZLNAQ=;
        h=Subject:From:Date:To:From;
        b=GElHm1aNiClUduAu8a3qf69rqx4k35tuZgFo+TxSq4WUZXr6Jv1YjmC9PMZXDWDF5
         +VuM9Que1rux9Z/t2AJ6fSkLGCWIcQPFb/fY5BeBGAH3yYuZHI2lVG3XkB9rcACfHY
         WWZ7li+UL1u8yANmqNDaRDxDAoGuZRLssybos335wyKGXidRDbOWoAw6dzpXG54KXV
         KAKYpoEUl8VQu2f1XcRUPdbwjNwDzOffz0wmgA4OAMSWcKGyeovtBfmxiigcK//O8L
         MVzxGxMRdPa+bHuOdFQK/P6h3G9xvFfx1+4/kZX/mGbsYPvrnishIt/ncBeG6o8WhM
         JGdqhSb+wzmjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03490E7399D;
        Tue,  3 May 2022 06:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165156099095.23817.17421129591539059418.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 03 May 2022 06:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-03T06:06:23)
  Superseding: [v5] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-02T08:13:30):
    [v5,01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
    [v5,02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
    [v5,03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
    [v5,04/11] spi: aspeed: Add support for direct mapping
    [v5,05/11] spi: aspeed: Adjust direct mapping to device size
    [v5,06/11] spi: aspeed: Workaround AST2500 limitations
    [v5,07/11] spi: aspeed: Add support for the AST2400 SPI controller
    [v5,08/11] spi: aspeed: Calibrate read timings
    [v5,09/11] ARM: dts: aspeed: Enable Dual SPI RX transfers
    [v5,10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes
    [v5,11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

