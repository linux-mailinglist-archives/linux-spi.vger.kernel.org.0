Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2B4C373F
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiBXU47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiBXU46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:56:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC36227582
        for <linux-spi@vger.kernel.org>; Thu, 24 Feb 2022 12:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C06AB82334
        for <linux-spi@vger.kernel.org>; Thu, 24 Feb 2022 20:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1357C340E9;
        Thu, 24 Feb 2022 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645736184;
        bh=dPeIqSr7XwCXilcdA99X1P7G+/z61YK2UYYVYgL+ads=;
        h=Subject:From:Date:To:From;
        b=arTqOiThk5vwhT86U7lnlodS3LPCKOW4xJLQT1eXc6ZMjsAALAX4tFYFfFdVTqWqo
         35d6X56rwZ77kNqsijWQy4e8UPrbfSBEHD1NWcaVWAtXe/zWGF1pZJOlg1B7dWrCWx
         hmmHtM5Ki9ENQ2GlQBidIvJCzfq35tzfexsRx8dNljzzQvU2lp1ACc8JQJN6Tea0Mu
         blRjzWdpA8q6OKTsQKTVIJYEGOka+8DXeMWnRDHvxxhxBDW8V1hn0vzap/NRSJrjOx
         Tz7zwxo0eXVCxZdnddkmF21togO5ea2NSfaFaCUH9mFvaPlarRPbm8V2h34I9YVYpO
         tAhnyk42EOIqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4769E6D3DE;
        Thu, 24 Feb 2022 20:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164573618466.23367.17249791403832085168.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 24 Feb 2022 20:56:24 +0000
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

Latest series: [v4] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-24T20:00:38)
  Superseding: [v3] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-23T17:56:35):
    [v3,1/5] dt-bindings: vendor-prefixes: Add Titan Micro Electronics
    [v3,2/5] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
    [v3,3/5] docs: ABI: document tm1628 attribute display-text
    [v3,4/5] auxdisplay: add support for Titanmec TM1628 7 segment display controller
    [v3,5/5] arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment display


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

