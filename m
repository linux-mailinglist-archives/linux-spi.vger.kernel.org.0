Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA829A719
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 09:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509583AbgJ0I4J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 04:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509581AbgJ0I4J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Oct 2020 04:56:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788968;
        bh=d6+e9SEepoNW3YtvPtt965CTmsaiq2Uw79nHn3HLbn8=;
        h=Subject:From:Date:To:From;
        b=zOTnjj5Z+seyr88cI4FwTmHQ+69oJUPvuOZ12N21uZjuEgfX7mJq7aw7gzPryQELF
         ODQ/t2Nyq1KGwxFCWhoCRnU9X02NXlZ+pDdw/0FdMuZQeRGB7oco9Nbx68H0+aV+o1
         hLilAf2jZD+HzfyHAwhesN+KrU3A80kJGBNZarT8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160378896802.20409.17887457025415546447.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 27 Oct 2020 08:56:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-27T08:22:45)
  Superseding: [v3] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-26T09:45:18):
    [v3,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v3,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v3,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v3,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v3,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v3,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

