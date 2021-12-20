Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C504647A9F9
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhLTM5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 07:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLTM5Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 07:57:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908AEC061574
        for <linux-spi@vger.kernel.org>; Mon, 20 Dec 2021 04:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D703CE1025
        for <linux-spi@vger.kernel.org>; Mon, 20 Dec 2021 12:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80500C36AE7;
        Mon, 20 Dec 2021 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640005032;
        bh=/iizo7HzLNmBpEYdEUzzrzsQWHz99h78z58JaeQXoXI=;
        h=Subject:From:Date:To:From;
        b=hq8l6SYBjfLOIEc5mOr5Y+LBIoT3vC+plUd54+OBnursl1dCjfuwAWRWceiWQPT8U
         1nK0BS5TfEcms7z0zNQ4GHLPX+Z/Kq4nZ/p6qc9oZCfuKzl5WfGkjfLnPnTn9gubUB
         Ot3QQmoZAwCG3gK8NmQj1HETFC22+uTrFygGGB3jgd8W8DxOGL0OFj/FJokh2IvTcc
         TKzLdNCy5VR1Yl9+RYnKFqXzAiTqEZQ/Wi7X7OnfQo7WZAqREUhhbwvaV3rCt2kKOB
         r0DaW30TfnliTfSR/wi7rlbuNc5yOKJSLFqCjg5GKvB7YR7WZncFNO+a5mF5l8decd
         BaQX+Qnx2G5Ew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6EC6D60973;
        Mon, 20 Dec 2021 12:57:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164000503244.31174.4184602571555904660.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 20 Dec 2021 12:57:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add basic SoC support for mediatek mt8195 (2021-12-20T12:18:22)
  Superseding: [v6] Add basic SoC support for mediatek mt8195 (2021-12-11T20:40:14):
    [v6,1/4] dt-bindings: arm: mediatek: add mt8195 pericfg compatible
    [v6,2/4] dt-bindings: spi: add new clock name 'axi' for spi nor
    [v6,3/4] dt-bindings: pinctrl: mt8195: add 'pins' wrapping node
    [v6,4/4] arm64: dts: Add mediatek SoC mt8195 and evaluation board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

