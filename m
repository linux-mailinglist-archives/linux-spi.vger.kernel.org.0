Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D94C1B3C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 19:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbiBWS5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 13:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiBWS5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 13:57:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DA2AFE
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 10:56:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13186B82198
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 18:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAD25C340E7;
        Wed, 23 Feb 2022 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645642588;
        bh=QQE+N9mQbzxYv5wIYcydVeFcO6X0XRhUoR73bcm61hA=;
        h=Subject:From:Date:To:From;
        b=kzl9ax2svn7mBsoezNgZpv2a6BsiErqcEBIwnA3JSRVn2N4kliwQ4J97kg6+KT6+W
         ptQInTfL/nZcBRFslXTKsoROtzrirtLgaMMuOHxjz3VLD/F4O/K21JIs1NHwn+dNg4
         OGLAEWSYGfoSuen6Hg71DZTSza7GrVgwrc+3TR83L/xRBYeA5y4XX6BDlDz8MvBCAc
         ss4FfhwpCK5MZYUM9n/A6U+CZpG3tnS7iZUu1yUEid5ztTfcM9+KZxcgh2MIPw0luy
         6hABI9dl9NKUt/0xqd4C26f9Ett9LfcE0/8donE0WP0HHhC1a5bahIildY/ZW5mmD0
         7czNDgvCQS+jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C09DEAC081;
        Wed, 23 Feb 2022 18:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164564258863.733.11352392253723582305.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 23 Feb 2022 18:56:28 +0000
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

Latest series: [v3] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-23T17:56:35)
  Superseding: [v2] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-21T20:19:21):
    [v2,1/6] spi: gpio: Implement LSB First bitbang support
    [v2,2/6] dt-bindings: vendor-prefixes: Add Titan Micro Electronics
    [v2,3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
    [v2,4/6] docs: ABI: document tm1628 attribute display-text
    [v2,5/6] auxdisplay: add support for Titanmec TM1628 7 segment display controller
    [v2,6/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment display


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

