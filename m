Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8859F2C1D2B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 05:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgKXE42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 23:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgKXE42 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:56:28 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606193788;
        bh=8tNkwRkBrNXAVK3s7nZTF9iEvBX28JVrqGDEy/oGD/k=;
        h=Subject:From:Date:To:From;
        b=LZy15AebiY87S2xL0c/O1w/3nqNpKuw2Q8y7eh55k08XVa5fTSYhNjF4JunpHMpPE
         ONKYOJBLtm4Shjgb3acNNQ6+E7r9M6qrgckTHcVdwSZlXqIInP179KB03p5jvDR0kK
         nQRe0r7vzgqn9JnS+iCzghigNIAyG4WYPasCGVsI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160619378812.6855.6533437712977715302.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 Nov 2020 04:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-11-24T04:18:35)
  Superseding: [v7] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-11-16T03:09:57):
    [v7,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v7,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v7,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v7,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v7,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v7,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
  Superseding: [v8] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-11-19T05:55:48):
    [v8,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v8,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v8,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

