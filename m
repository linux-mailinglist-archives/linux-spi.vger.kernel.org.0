Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75D33D02F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhCPI4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 04:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhCPI4e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 04:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A358465001;
        Tue, 16 Mar 2021 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615884993;
        bh=55fHWguuYicA2b20KLwGgGbjAKuQmHzoa8ENQEJJmXw=;
        h=Subject:From:Date:To:From;
        b=mV9j9R9Vvp1iCzgCsUYv/z36KKVCxFtRD7GjWe/kXRkfbHM52pz40Qray+hZ/w2Ga
         pLxSCv80xGyZB7zGDIe8Bdfe9ytyal4N8Jk9vSPAqKNNSE3+GYWsMpNip1iqXRkOhE
         WJXMUwjfAPyooycitR0X/Zq9SYKwruDynZzszcHWWqr7GF2JgtSuGbxh1d3bkmJCDQ
         PYpy/5Ijvk7jDlp7XBH0GYVYR8UZCh+rgxfLc8QF+L4f0ZJsNS1wmddELrc03NL2ji
         UgnRcstFJrMPMAsW+YGwier3oWfSt6dXEa++QNFT1rMnccCYVHMLJk0BBexg/BgM7j
         LvKpYmRc3rJYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9646860A3D;
        Tue, 16 Mar 2021 08:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161588499360.11297.12894397986181970947.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Mar 2021 08:56:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] enable flexspi support on imx8mp (2021-03-16T07:59:26)
  Superseding: [v1] enable flexspi support on imx8mp (2021-03-16T05:04:23):
    [1/2] spi: fspi: enable fspi driver for on imx8mp
    [2/2] dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

