Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3CF4F1697
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359332AbiDDN6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376505AbiDDN62 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 09:58:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F973EB87
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 06:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F353CE183F
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 13:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26F5C2BBE4;
        Mon,  4 Apr 2022 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649080588;
        bh=Z6VkBpvYoLUxdepy0TWLDhQCgUY8NNSIg/i2OSZpHz0=;
        h=Subject:From:Date:To:From;
        b=BYBng9+YZITE/0b74wE2rHm3XNczKq8qVv+MePs5msZchAlCtnD2EaMUXNIG2EgLm
         8zofMDjxDcaNyfWINtX5CpT/QrXTvlzJmLi4g+6EtAqCuru9ga80R8GY2e2v4kxwml
         vLIVpOoghOWyEapiWEb/bsXaApOju7iRkvQrI9HRL/hvzbntdyle5PNQrsEXd637fB
         24q0+v37G1KS3uDf/RxEhjmAfUr70rwEU6TiPX1dnCoDuPx+kCjHE21jAHKBdMwBk8
         K8Tz12TbvfUYyS6SJYg6OLCySwiKilE5OTIk2Ia0ut+3IOzJI5mvZ/YpvpTIqT4pPb
         T+zthlL7X8hHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 794D0E85B8C;
        Mon,  4 Apr 2022 13:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164908058840.14328.2006723963077161239.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Apr 2022 13:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: add support for Mediatek SPI-NAND controller (2022-04-04T13:18:13)
  Superseding: [v2] spi: add support for Mediatek SPI-NAND controller (2022-04-04T04:01:48):
    [v2,1/5] mtd: nand: make mtk_ecc.c a separated module
    [v2,2/5] spi: add driver for MTK SPI NAND Flash Interface
    [v2,3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
    [v2,4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
    [v2,5/5] arm64: dts: mediatek: add mtk-snfi for mt7622


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

