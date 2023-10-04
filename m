Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5107B8456
	for <lists+linux-spi@lfdr.de>; Wed,  4 Oct 2023 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbjJDP5J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Oct 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbjJDP5I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Oct 2023 11:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C798
        for <linux-spi@vger.kernel.org>; Wed,  4 Oct 2023 08:57:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4A1C433C7;
        Wed,  4 Oct 2023 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696435024;
        bh=Aoh4p9Un450CfqHqHk5C/4ikpD/Mn74YpGQCYJAx9Uc=;
        h=Subject:From:Date:To:From;
        b=s2fMvqlkgcNp8Z3dNtqhqoogWOfZDqxWwEAtYAaAFwKlTbfNc+mmQHnLQCoOxz6Vk
         nHufNnybuwCml7x/GwLD2NL0VJFdSNW+01KVyKlO2l6C1NlyOikGlxyQHmWkZNqr1P
         zN0taFqCgZ2Qepknl7ri6tIFO7l7cyA5Zw8NLpeFax3XY2lzf0xdEVMPd+W7J0kZHm
         VjEr1F0sryG/elIJJ7ILdRHL1Fs4USWk3GGMuO72aKOKixzhXdRv+redzTm6QtNUxY
         Zy/OgtXWWkdSsChVCtFrFpBYpaKqDwSd2RvgwI2MnGB3Ah5PtZjOz3Rkzzmw+JmWbY
         T/8+yz5raBpzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4494E632D7;
        Wed,  4 Oct 2023 15:57:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169643502473.4271.185220480013234779.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 04 Oct 2023 15:57:04 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] ARM: pxa: GPIO descriptor conversions (2023-10-04T14:56:24)
  Superseding: [v4] ARM: pxa: GPIO descriptor conversions (2023-10-01T14:12:53):
    [RFC,v4,1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
    [RFC,v4,2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
    [RFC,v4,3/6] ARM: pxa: Convert Spitz CF power control to GPIO descriptors
    [RFC,v4,4/6] ARM: pxa: Convert reset driver to GPIO descriptors
    [RFC,v4,5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
    [RFC,v4,6/6] input: ads7846: Move wait_for_sync() logic to driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

