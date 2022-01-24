Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E512497ACC
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiAXI4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 03:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiAXI4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 03:56:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C94C06173B
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 00:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE1E5B80AE3
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 08:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFB25C340E4;
        Mon, 24 Jan 2022 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643014572;
        bh=7xsgxdqVXhkTkb3JpkzzToxHcGIHslllgRM5PnjF94o=;
        h=Subject:From:Date:To:From;
        b=Zn/s86iymXJqlaa1tJHEpa8N/PoNFjQT8Wb3yxc867MYn5+JAUlevfIlxWmGhpio2
         NfJns9mmsk1BmRNoH/gx7xHiaxnCcLvOGoG8Daq3oNGOJMnPlT5tgykrdG34ReiuGp
         Jzfyp0lv828vo8vJ82r4ZhBz5TPK93I3Xv03v8Krks7rv9/HwgPMymHYbOYHpebK9O
         9JQWWIa0fGYjaOX989ZfV/UujY8hb8yjo7MGm1GN4ibNKAKGc+MS4A7iYb+fG9X304
         9kVRra2FCTeaiXffttuJQzZw9LTBkG96qXB4mLRxqIL6kCIJcR1SJHGSgnHwNv2XC9
         woys9zjgZcDiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D635F6079B;
        Mon, 24 Jan 2022 08:56:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164301457263.9666.2281648955073920700.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 24 Jan 2022 08:56:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: dt-bindings: samsung: convert to dtschema (2022-01-24T08:23:43)
  Superseding: [v5] spi: dt-bindings: samsung: convert to dtschema (2022-01-20T17:57:43):
    [v5,1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
    [v5,2/4] spi: dt-bindings: samsung: convert to dtschema
    [v5,3/4] mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
    [v5,4/4] spi: s3c64xx: allow controller-data to be optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

