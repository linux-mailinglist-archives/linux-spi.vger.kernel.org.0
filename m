Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04FF7BEA2F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Oct 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377493AbjJIS4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377392AbjJIS4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 14:56:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BAAC
        for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 11:56:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DD5CC433C7;
        Mon,  9 Oct 2023 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696877809;
        bh=bhqOFfyHZz35B+XxsSrX32fSJo0onN8Ztnt3yby6co4=;
        h=Subject:From:Date:To:From;
        b=NIqcVSCLkSwsIXbobmc93EvuKd+sYiZVUvxOWZMbq7/PspNacvdu0J+3knzcGmS3J
         hLCojf3mr9Hmga+8rzTbyhi4/R5Ys0GD/zvQEtw92yCG2TkTxAhliAAuvMzxal4arq
         Qe8kbSzN5QFZUDw6JmBTICfcyU0XuRgUQc57ifkQmGaX4ZCCpN4EW46xtturkSRZPE
         y6noKvseXhb8oiEVc6eiXYWOfKy5YXsmWThQ+H65EOZnxtU5vvXHQSmvlUQt7xR8xC
         IE/L3UeK7wC/6ed05ex8bmeZiFw3ecfGD5a4EMB+xdb/zarLxQB+cOQf69yWe0osnC
         wcGi4UzOcBOXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2C19E0009C;
        Mon,  9 Oct 2023 18:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169687780892.17603.13979236192693671176.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Oct 2023 18:56:48 +0000
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

Latest series: [v7] ARM: pxa: GPIO descriptor conversions (2023-10-09T18:33:57)
  Superseding: [v6] ARM: pxa: GPIO descriptor conversions (2023-10-06T13:44:26):
    [RFT,v6,1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
    [RFT,v6,2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
    [RFT,v6,3/6] ARM: pxa: Convert Spitz CF power control to GPIO descriptors
    [RFT,v6,4/6] ARM: pxa: Convert reset driver to GPIO descriptors
    [RFT,v6,5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
    [RFT,v6,6/6] input: ads7846: Move wait_for_sync() logic to driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

