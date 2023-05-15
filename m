Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD3703D16
	for <lists+linux-spi@lfdr.de>; Mon, 15 May 2023 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjEOS4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 May 2023 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243045AbjEOS4q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 May 2023 14:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465410F8
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 11:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EC46318F
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 18:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E17AC433EF;
        Mon, 15 May 2023 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684177004;
        bh=vjUsIK6YomD1Puc7PUQfYXnldXSG6vZOroGdqK9a9eg=;
        h=Subject:From:Date:To:From;
        b=I1qKRulOc2/ilsiPXMLO39Dfna8CutpXnek4mk9THe6EymdzmVapRzuqrQ1YYddzq
         X7nAcDzb9aV7PPyc1YrP5QMykYNtR3qWlEaMHgJQimtuV7eSIEU3NKuPKyo7rmj7pN
         5VD1zElgRkksSxFehdRPdUZGwY/nx9rx7FzquvZ3JiGV8ULmlpfO1xmcsyeh4yJroT
         yFDT8BQuwUcRq4VVHb871i/o6CUXJtxXYGldrNBPoB0sCnuQkOo9AKVtEvXXbDYslv
         IAAr9AvM86cQGQVyNZMIKZ1iA358ITzc8lWBzdoO2GF2E4cYO30hRU7a9edVBZqZ2y
         gl8lVmzLzh4vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CDC2E5421B;
        Mon, 15 May 2023 18:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168417700404.21409.14641057879221551335.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 15 May 2023 18:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v14] Support AMD Pensando Elba SoC (2023-05-15T18:15:58)
  Superseding: [v13] Support AMD Pensando Elba SoC (2023-04-10T18:45:11):
    [v13,01/15] dt-bindings: arm: add AMD Pensando boards
    [v13,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
    [v13,03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
    [v13,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
    [v13,05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
    [v13,06/15] MAINTAINERS: Add entry for AMD PENSANDO
    [v13,07/15] arm64: Add config for AMD Pensando SoC platforms
    [v13,08/15] arm64: dts: Add AMD Pensando Elba SoC support
    [v13,09/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
    [v13,10/15] spi: dw: Add support for AMD Pensando Elba SoC
    [v13,11/15] mmc: sdhci-cadence: Enable device specific override of writel()
    [v13,12/15] mmc: sdhci-cadence: Support device specific init during probe
    [v13,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
    [v13,14/15] mmc: sdhci-cadence: Support mmc hardware reset
    [v13,15/15] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

