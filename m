Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4C7667EE
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjG1I4z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjG1I4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 04:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3731BD5
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 01:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814AC62083
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 08:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD0A7C433C8;
        Fri, 28 Jul 2023 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534602;
        bh=4RmHmREWaJsRf/cSUuZ4/UE1yg0/NmD/fpGoG8dpV8c=;
        h=Subject:From:Date:To:From;
        b=WUueVOargUR9nTF6eKHIXOS/Bl1qgrgeQm+66adRJz2zXZTswfW4apB11pkD+BsgD
         qtDe/6WW6pv1zYyXiDY7zwTyea8ylx9OXU7X5Dz9PE3xLMvXApyCxMJdAy21hBGF7/
         ejjICIcmFQd2U9EKoESqY0+U8k8y2wYIb9/Q5I7wCPy9AS08i06mNyG2JQc+LQtsvK
         3c5803ZAtr9ZLkrCKq8VamfZDgd6mvQD9YHcEVtrx8cDTlTh0hxcRvspH74zty1EeH
         sMOdEwiM9C7QWj+LTJKWsQGnj2WVJjCbFoyMxPqn2YtmHVOtA/MpDk+2iOhWTzyWs7
         BbuQB2fN6VYXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0AA3C4166F;
        Fri, 28 Jul 2023 08:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169053460278.19171.4657096056328892298.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 28 Jul 2023 08:56:42 +0000
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

Latest series: [v2] spi: microchip-core: Clean up redundant dev_err_probe() (2023-07-28T07:57:29)
  Superseding: [v1] spi: microchip-core: Clean up redundant dev_err_probe() (2023-07-27T13:00:49):
    [-next] spi: microchip-core: Clean up redundant dev_err_probe()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

