Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7D791131
	for <lists+linux-spi@lfdr.de>; Mon,  4 Sep 2023 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjIDF4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Sep 2023 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjIDF4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Sep 2023 01:56:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F60B3
        for <linux-spi@vger.kernel.org>; Sun,  3 Sep 2023 22:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7DF49CE09B3
        for <linux-spi@vger.kernel.org>; Mon,  4 Sep 2023 05:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CCE9C433C7;
        Mon,  4 Sep 2023 05:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693807006;
        bh=IoxUgaVJ2Sbi4t32UIzUwJV7mzoYl2XWrFOO2ZiRF8E=;
        h=Subject:From:Date:To:From;
        b=PUzDJr5gV5OqEp+lL3+W5K3DRlKlWZlq3BH+TRSHXBej1vjyFM7ZXN0L/JlZ/++Le
         scaz6q3H+4ygEMvjtxjDjDdpMhnUPFfckjjT6d8595bVqzS+PIu1pNC2gS8RYnk9iA
         NaqNs7JvUoxrtbpb9lOtltQTZsAI/gWaJT3dNkg7wRU0kVtPVAOac0uS9N0q/n3VKa
         3EXcylA5McPsIf2OC1lVfkg4D4ZJttK89by7T6rdCQQT2sgW8xfJfjneXqsVv90GpM
         YhBqSR6kL34Pi5okngQC5BRpTpieaJ9ddpQF4GTsJjZDVFk95araSysnhsZTiS1O1w
         ha3flQjm3a25Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C77EC04DD9;
        Mon,  4 Sep 2023 05:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169380700637.1386.10988526468285088989.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Sep 2023 05:56:46 +0000
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

Latest series: [v14] Add Intel LJCA device driver (2023-09-04T05:44:17)
  Superseding: [v13] Add Intel LJCA device driver (2023-09-04T03:17:38):
    [v13,1/4] usb: Add support for Intel LJCA device
    [v13,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v13,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v13,4/4] gpio: update Intel LJCA USB GPIO driver
  Superseding: [v13] Add Intel LJCA device driver (2023-09-04T05:28:29):
    [RESEND,v13,1/4] usb: Add support for Intel LJCA device
    [RESEND,v13,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [RESEND,v13,3/4] spi: Add support for Intel LJCA USB SPI driver
    [RESEND,v13,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

