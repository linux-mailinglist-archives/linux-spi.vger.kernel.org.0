Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C601A2B3BED
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 04:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKPD4R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Nov 2020 22:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgKPD4Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Nov 2020 22:56:16 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605498976;
        bh=PJbVTFZeWq1MyLeH+9mPHaiSB50/7+IRpxD+Qgwysqo=;
        h=Subject:From:Date:To:From;
        b=k+iRM7BvqkhakXcMY0UhRsq4h3Sr9hzAPy8gRa1cSVsx2u6lHH6Hiti2CfHu7AfbH
         wobYRIMKKaelqafak9t4BP6uvbbhUKKhRxKFTv+95FpmLptzZC131FGTP7B7qU95m1
         3RecmhosrYysm5miqjJ97aGRXc1fMUFmo+3dU1TI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160549897646.25617.17168632016845251864.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 16 Nov 2020 03:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-11-16T03:09:57)
  Superseding: [v6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-30T05:31:47):
    [v6,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v6,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v6,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v6,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v6,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v6,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

