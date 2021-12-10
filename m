Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38A46FE45
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 10:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhLJKAj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 05:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLJKAj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 05:00:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7AEC061746
        for <linux-spi@vger.kernel.org>; Fri, 10 Dec 2021 01:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90FF5B82644
        for <linux-spi@vger.kernel.org>; Fri, 10 Dec 2021 09:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 435E3C00446;
        Fri, 10 Dec 2021 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639130221;
        bh=JyOXkvY9sCWx2kBwb8wfBrigWxRrUu/XEPFUtjBrfYo=;
        h=Subject:From:Date:To:From;
        b=aFcCyW8WfIVhCzoqwJJvkdi6sGS/eO4H5lTflqwvI9LGFcwXtqEYiQWrymQjLRQre
         1lqL2Mc68xNwrLMQQKp7sU/2AfClJF6YTVedVrINiZikif88+Ge8Oujx73oTnqw79b
         dF4WNB+a9QIoae8AKuwXcOaiXEPnVn84qwykG//XZz5B8zr3x9ZVc0ZH3T16vOpKWv
         BiD8pvH0Zn6aMJq7PvEQ+MRP2N41AydgTESbcS0kAj0Mr0LF3ngovtydXz7bCJ+CPt
         2uUaSUuWWSD7B+ZAwDhqK2te0TAgpjQSW1SK8/dG1Rk2Yw9EvfWHHO8htyqNI2BUJa
         /T+NNYoFBzjXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2295260A39;
        Fri, 10 Dec 2021 09:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163913022113.24111.15552180603934717826.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Dec 2021 09:57:01 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add SPI control driver for Sunplus SP7021 SoC (2021-12-10T09:02:46)
  Superseding: [v3] Add SPI control driver for Sunplus SP7021 SoC (2021-11-22T02:33:31):
    [v3,1/2] SPI: Add SPI driver for Sunplus SP7021
    [v3,2/2] devicetree: bindings SPI Add bindings doc for Sunplus SP7021


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

