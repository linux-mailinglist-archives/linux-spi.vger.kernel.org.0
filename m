Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2706C5B95
	for <lists+linux-spi@lfdr.de>; Thu, 23 Mar 2023 01:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCWA4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWA4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 20:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D07EEC
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 17:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA4762375
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 00:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A763C433EF;
        Thu, 23 Mar 2023 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679533002;
        bh=qScv14BV8jhRjRRpO5/xifNOjB1OZd84twHLM/XCfHw=;
        h=Subject:From:Date:To:From;
        b=K/SlQJIpXgxXqQ2bxAXkzyAM8FnRGCaKdOyfb2fT4mRTxrMWtwVm19B/z6X8ZYnHc
         ghivUlyuRiHIV2QqdDrJCDOJ8pNyc8lET52EHd8e25cENpYi3n5z1TuI5sZlcPPNyX
         00JpW3i/XcBEm+m7nvbZw5rT0tz/9X4VosPejglt2eToS5nJf11u3lu1yDH0Lph7WG
         fH/bHS/0iuRVTAc98sibehp9r/Qa+fD4AhIU7P6PkTDm9Iq3LKsbpCBG75pqYdPFWJ
         yts4JIXUtAQC3cQrheBxprDS4mXyX5B/YtlK8Qh16bxS4zPfn8I8hPuFqQpqUtMRX2
         KidFa/YigLJ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38F2FE4F0D7;
        Thu, 23 Mar 2023 00:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167953300214.14471.9869811526363935038.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Mar 2023 00:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v12] Support AMD Pensando Elba SoC (2023-03-23T00:06:42)
  Superseding: [v11] Support AMD Pensando Elba SoC (2023-03-12T00:44:30):
    [v11,01/15] dt-bindings: arm: add AMD Pensando boards
    [v11,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
    [v11,03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v11,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    [v11,05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
    [v11,06/15] MAINTAINERS: Add entry for AMD PENSANDO
    [v11,07/15] arm64: Add config for AMD Pensando SoC platforms
    [v11,08/15] arm64: dts: Add AMD Pensando Elba SoC support
    [v11,09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v11,10/15] spi: dw: Add support for AMD Pensando Elba SoC
    [v11,11/15] mmc: sdhci-cadence: Enable device specific override of writel()
    [v11,12/15] mmc: sdhci-cadence: Support device specific init during probe
    [v11,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
    [v11,14/15] mmc: sdhci-cadence: Support mmc hardware reset
    [v11,15/15] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

