Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D966A584
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jan 2023 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAMV5Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Jan 2023 16:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAMV5P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Jan 2023 16:57:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14012892D2
        for <linux-spi@vger.kernel.org>; Fri, 13 Jan 2023 13:57:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA21B82248
        for <linux-spi@vger.kernel.org>; Fri, 13 Jan 2023 21:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1460CC433D2;
        Fri, 13 Jan 2023 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673647030;
        bh=qCj4rY1a/hnFhouTyDWuioi6sr11018sHix7TsqEcHc=;
        h=Subject:From:Date:To:From;
        b=YMVLWKwq/4jD2uNeUVzw1Nv3qZ6nEthkR3rpFLytziogFtvJUq/5NP48q5soCc5JB
         fvKMVfXQRsEpNqTC6yU4DYvGlJ6g6wXv2Sm5FUyl0rfJsBU6VabNSL2Cgtw2PEQYf1
         iDNH2tqDD2glCJFH9MMWxWZdzymD0oO7jv5AyM9yBf97WpvOs80RhssxLJjNC94f2C
         Ip3rT6p5cpnFkkDBkFk4R7skFs91iU1LfJglRGarCu4RmE0A0555ZoaAnR2ymOFQMi
         XRrKF7VmG5KNLmt9SfOYvV5Dkfx/85w4kUIpjaEk/1D8nQTC3tdUAcGwPLK7U0mN+L
         6JAAmTHE2HVyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED263C395C7;
        Fri, 13 Jan 2023 21:57:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167364702996.6043.16991036284949438663.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 13 Jan 2023 21:57:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] SPI core CS delay fixes and additions (2023-01-13T10:23:08)
  Superseding: [v1] SPI core CS delay fixes and additions (2023-01-04T09:36:26):
    [1/5] spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
    [2/5] spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns
    [3/5] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
    [4/5] spi: dt-bindings: Add hold/inactive CS delay peripheral properties
    [5/5] spi: Parse hold/inactive CS delay values from the DT

Latest series: [v2] spi: dw: Fix wrong FIFO level setting for long xfers (2023-01-13T18:59:42)
  Superseding: [v1] spi: dw: Fix wrong FIFO level setting for long xfers (2023-01-13T16:57:24):
    spi: dw: Fix wrong FIFO level setting for long xfers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

