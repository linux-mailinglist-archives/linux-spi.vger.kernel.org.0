Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E047227FD
	for <lists+linux-spi@lfdr.de>; Mon,  5 Jun 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFEN44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Jun 2023 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFEN4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Jun 2023 09:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047D90
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 06:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C1861EE8
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 13:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7751C433EF;
        Mon,  5 Jun 2023 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685973413;
        bh=k7t477CTpOoWeWrSfPCkbSHmZ4TpkWExtCiySIoEolM=;
        h=Subject:From:Date:To:From;
        b=aFwWpbFAuyHpDNnrzMowaevoTwzOuqkTad2YjSwhUuyWO5dPEVlL/Sc0R9IVV8BSb
         Z2+CdQZpPXXGALv30MWFn+hQGYaKDIGkRSAL5LpRV5fACOxAOZ1Q3N5zaY63ktoILC
         KgMxXovUVp90gYs9cHGyvtjy5CL6eniLOoped+/6AiMZU1ba9NzX0ETvt6sQk9opP5
         VfRD7Fnzm9GtiV3wl+VQUbUEzHagG5xAwnFQNnswAmdQxinsQXQUHCvJZdxclboh2l
         S28YMiPfIBJkqlgSG2IkmT5P5fRpNtXAG39haHbFpCAdJquu7zwFS8HEXuwhb5RRxO
         2qQ/Llj+DWL1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9EACE87232;
        Mon,  5 Jun 2023 13:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168597341375.6443.4729988933257882687.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 05 Jun 2023 13:56:53 +0000
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

Latest series: [v3] Add cs42l43 PC focused SoundWire CODEC (2023-06-05T12:54:58)
  Superseding: [v2] Add cs42l43 PC focused SoundWire CODEC (2023-05-30T12:21:06):
    [v2,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [v2,2/6] dt-bindings: sound: cirrus,cs42l43: Add initial DT binding
    [v2,3/6] mfd: cs42l43: Add support for cs42l43 core driver
    [v2,4/6] pinctrl: cs42l43: Add support for the cs42l43
    [v2,5/6] spi: cs42l43: Add SPI controller support
    [v2,6/6] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

