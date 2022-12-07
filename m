Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B90645447
	for <lists+linux-spi@lfdr.de>; Wed,  7 Dec 2022 07:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLGG4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Dec 2022 01:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLGG4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Dec 2022 01:56:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796F1EAF2
        for <linux-spi@vger.kernel.org>; Tue,  6 Dec 2022 22:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1965FCE0EEA
        for <linux-spi@vger.kernel.org>; Wed,  7 Dec 2022 06:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C8EDC433D6;
        Wed,  7 Dec 2022 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670396185;
        bh=XgJvzIV9PvOzar+qzZH8uuZ2KnwxoksrETb6BT9V0/g=;
        h=Subject:From:Date:To:From;
        b=OikiZZJV2j1/z3TIXB9CZqFrztUf1arEjmzcL/P3ZwjBxQbfQt1cTi9a26/Lwwt05
         r11QMVmzejMB/apmr5iK9jeV3W5oy1sCezzpdCYyP9z78sntpr1fNbVCjAhMM4YeJ3
         JIayajgeCPcbKd7X7al+TzHjfZNv3YN+ndtOKsfB4NKaHZJWEmgQYBay2csYh0wzoU
         c7wbuSfVaam5YMHSNXEMtZxbB+M2dX2uPmuSGCl8so/SwlrbNbd0lT0u71ZEhlDcoI
         W8QPVXL8nv1LnLxeGIwmYE/pR0EUWg+FHErrwRpntuElsp9o0yrul96lnrn/LvJcVN
         l0HWp/6/HO+OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20F58C5C7C6;
        Wed,  7 Dec 2022 06:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167039618502.22082.9219338592795027700.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 07 Dec 2022 06:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout (2022-12-07T05:54:35)
  Superseding: [v1] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout (2022-12-05T08:24:19):
    [v1] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

