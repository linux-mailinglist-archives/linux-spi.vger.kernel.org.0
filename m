Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07482516CA5
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383993AbiEBJAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 05:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383982AbiEBJAC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 05:00:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D658389
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 01:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E13B80EFC
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 08:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6BC4C385A4;
        Mon,  2 May 2022 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651481791;
        bh=aaNZYbTeQOIUjCDALCBG+KuCBx/RqRz7BqZY47sjrVI=;
        h=Subject:From:Date:To:From;
        b=bFno9HR9dNdWuXQWpev6hMazwgiAljXUAOOiHjYfgMDw4n62/mzxuk+e0DaX2VvSJ
         KvL7qgBJOWnm3S3Vei0Jqc6VYP9glHaeJesGN7RHppKZdO/rwGWJ3wwIhxALRNmbM9
         6D1yiqoSEBH7IB2/UCNy8qKNnOIP2eKibwezwmS4HoXWUJI1y7JTG57UPwQgOc4+zz
         K51ZTD1QVtD93R6Mjv2+9bd1L/WCnGYCjKVs85Wx8Foku6G1cg4U7SSaNuUFKPYLZt
         x8lCDpVW+nK0G9/WO5ipPdOxe5MeYHIJw4OBUcTgj0fDiLfdInVYIYeYk04Ctga5N3
         RvnZzAmePVm/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D47FE8DBDA;
        Mon,  2 May 2022 08:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165148179156.18460.14570493613687777499.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 02 May 2022 08:56:31 +0000
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

Latest series: [v5] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-02T08:13:30)
  Superseding: [v4] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-03-25T10:08:45):
    [v4,01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
    [v4,02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
    [v4,03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
    [v4,04/11] spi: aspeed: Add support for direct mapping
    [v4,05/11] spi: aspeed: Adjust direct mapping to device size
    [v4,06/11] spi: aspeed: Workaround AST2500 limitations
    [v4,07/11] spi: aspeed: Add support for the AST2400 SPI controller
    [v4,08/11] spi: aspeed: Calibrate read timings
    [v4,09/11] ARM: dts: aspeed: Enable Dual SPI RX transfers
    [v4,10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes
    [v4,11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

