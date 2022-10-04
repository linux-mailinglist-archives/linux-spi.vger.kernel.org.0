Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D725F4278
	for <lists+linux-spi@lfdr.de>; Tue,  4 Oct 2022 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJDL44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Oct 2022 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJDL4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Oct 2022 07:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083127FC5
        for <linux-spi@vger.kernel.org>; Tue,  4 Oct 2022 04:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB9F613FB
        for <linux-spi@vger.kernel.org>; Tue,  4 Oct 2022 11:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 331EFC43470;
        Tue,  4 Oct 2022 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664884610;
        bh=3qQqggCj+2k3OEgHN1udVynSsvWldjTvT78WbjHBI9U=;
        h=Subject:From:Date:To:From;
        b=ArumdnKOMf/FSsZEACdfIkRuzP2ojIqGLfGVnfwT0Au5ngQfi1it2BevT4fjLic2P
         oTKUObBZrowRbPEcfG18Cfv9VPyZZOxCmHU5IWnhP29aNj+MeWN/g0/sgVFf12Ae8j
         JP1IX9T3ufBpOJAmx1tsnlNBpIXG5t+YsqFzF+K58S/u5LXQi1MujR/YZy9f0Q+7sl
         +MVik7TmP7MdSLv1pEa/lmRE+j37pv8RGB2v9oXMNbBF2HoDZHtcCF321kToHykmWq
         1PCrhTsKqQ1iniT/3WjBzH769+YhbE+M2HXKa5wD1Tjryabvbm2m0Xdsh90zfBCp0x
         85KNVOWLZA48w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13085C072E7;
        Tue,  4 Oct 2022 11:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166488461007.26777.14657585258825370888.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 04 Oct 2022 11:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-10-04T11:10:36)
  Superseding: [v1] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-08-09T17:20:15):
    [1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
    [2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

