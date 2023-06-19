Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6377354C2
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjFSK65 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFSK6g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 06:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57B1BE
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 03:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B085560B4B
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 10:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26171C433C9;
        Mon, 19 Jun 2023 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687172212;
        bh=bdtUp6mFYZF0+Mo2UtHzYB+8NFKe1SnH+MpUZryyM2o=;
        h=Subject:From:Date:To:From;
        b=X1Bx6Z5n/h5aiUnQ5r96l/VpizRD5zVTSmBQ1kdg64O5Rh2Tt7XII3fM2VyVduqiY
         E6M/wa+XZATlQO0L1Zx6l0tFeVQsQGSVCNhBJBEbR5ePSwLEbs+fTeye8HoGn9mPr1
         a3KP/sF2fFndCmFZjFlfGso86O44pQop/OQrn+gEBSb9qry29oLrHC/dusi5Qw1C3G
         2JhvSZPniVRSw6Or/0MMOuvNktRQO/m6eY1FfYNAkfV0VezSozltgZNdPmW047iYmK
         gYgbFFEVxdyHDWPdMk3V/Cjt2PpN3liu3TDrgNlirUKlfG+C8bzOC42fZnOWMsbvBT
         ZdRWdfC4jlDcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 136D1C4316A;
        Mon, 19 Jun 2023 10:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168717221207.28588.13922006433093185529.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Jun 2023 10:56:52 +0000
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

Latest series: [v5] Add cs42l43 PC focused SoundWire CODEC (2023-06-19T09:56:20)
  Superseding: [v4] Add cs42l43 PC focused SoundWire CODEC (2023-06-19T08:43:23):
    [v4,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [v4,2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
    [v4,3/6] mfd: cs42l43: Add support for cs42l43 core driver
    [v4,4/6] pinctrl: cs42l43: Add support for the cs42l43
    [v4,5/6] spi: cs42l43: Add SPI controller support
    [v4,6/6] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

