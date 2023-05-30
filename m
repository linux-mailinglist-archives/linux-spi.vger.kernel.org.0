Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7228D7160C3
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjE3M5n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjE3M5Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 08:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896E312A
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 05:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A64362FBC
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 12:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 731CCC433D2;
        Tue, 30 May 2023 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685451407;
        bh=emT/T8WTJHikmPaZsZtLECQlnckk4URUt701eMvWm7I=;
        h=Subject:From:Date:To:From;
        b=LwUyYGGMjDqFTGDp1OaoUozUbj7/9s3BPfdEAhR+aZT2lDdpKgt4I1DH7yqcSQAUz
         nStzUPRVB/AA45llgPfcDfiuCBSKiEckO0LLcsd2gnm/GVOkHAj2XIW3htkDx7f+uG
         U2Te0safTPfrxDi4sJz5Km2xAC+5NmhpDHiskLD7H9HjgUC8UVnIuuMlfl6IrYSx/f
         Yd+cWBIBVeXEbbuCgRDlq8EY8CNnsmVwrVFGj4/J9DwiL1lmmmpduDqLkD7uh1UBZ7
         LAyjlnKbpcb2Vd1ir5E+Cu9nhOSojDFd8n3v1bLWPnPekg7XTGDlMGBqeGpSzErhHU
         biTusR6WUCLsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DF2AE52BF6;
        Tue, 30 May 2023 12:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168545140738.11707.15252485230425750861.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 30 May 2023 12:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add cs42l43 PC focused SoundWire CODEC (2023-05-30T12:21:06)
  Superseding: [v1] Add cs42l43 PC focused SoundWire CODEC (2023-05-12T12:28:29):
    [01/10] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [02/10] ASoC: soc-component: Add notify control helper function
    [03/10] ASoC: ak4118: Update to use new component control notify helper
    [04/10] ASoC: wm_adsp: Update to use new component control notify helepr
    [05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
    [06/10] mfd: cs42l43: Add support for cs42l43 core driver
    [07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
    [08/10] pinctrl: cs42l43: Add support for the cs42l43
    [09/10] spi: cs42l43: Add SPI controller support
    [10/10] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

