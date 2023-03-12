Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE46B6298
	for <lists+linux-spi@lfdr.de>; Sun, 12 Mar 2023 01:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCLA4k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 Mar 2023 19:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLA4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 Mar 2023 19:56:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014756535
        for <linux-spi@vger.kernel.org>; Sat, 11 Mar 2023 16:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06F7DB803F5
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 00:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B6BC433EF;
        Sun, 12 Mar 2023 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678582591;
        bh=N0bsEgIIIB94zcnxkKNPviBF071ggdSlD9cEUy+S434=;
        h=Subject:From:Date:To:From;
        b=i9n0Fqw5vdUg4O8agR55aqAlnuFoshqMj7iKX942DksnFZ+biJQ906cfYOwA/BSt2
         Ra3Rz91aQFK31uKj4JTB/aFPBkayYdxDNdFIHSXL0JcVUTG9kwdkiGo4KxXaK3tpsL
         5+Gkw+kvQGbSpHr2lxlpCBSQfaXQc+0VIcHqyGRXAX8w+a2SuRT/j3wonn87mveBZP
         +aIPBLe81aNqw8H+QTg6zW3QiSPBWvifmCezx5k0bKQXG55132kuyG4T5SaP5XHnfk
         zFYszzzmse5gFTXVWOO0YAyLvUNu0M9pqI499fgtdgWvmIliMPwgWW6ZjstVx5Wi7/
         I86Z2dWRhJrsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 828CDE61B75;
        Sun, 12 Mar 2023 00:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167858259148.23577.13344540396804879654.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 12 Mar 2023 00:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] Support AMD Pensando Elba SoC (2023-03-12T00:44:30)
  Superseding: [v10] Support AMD Pensando Elba SoC (2023-03-06T04:07:24):
    [v10,01/15] dt-bindings: arm: add AMD Pensando boards
    [v10,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
    [v10,03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v10,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    [v10,05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add AMD Pensando SoC System Controller
    [v10,06/15] MAINTAINERS: Add entry for AMD PENSANDO
    [v10,07/15] arm64: Add config for AMD Pensando SoC platforms
    [v10,08/15] arm64: dts: Add AMD Pensando Elba SoC support
    [v10,09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v10,10/15] spi: dw: Add support for AMD Pensando Elba SoC
    [v10,11/15] mmc: sdhci-cadence: Enable device specific override of writel()
    [v10,12/15] mmc: sdhci-cadence: Support device specific init during probe
    [v10,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
    [v10,14/15] mmc: sdhci-cadence: Support mmc hardware reset
    [v10,15/15] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

