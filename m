Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5D2989E2
	for <lists+linux-spi@lfdr.de>; Mon, 26 Oct 2020 10:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1735136AbgJZJ46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 05:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768783AbgJZJ4K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 05:56:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603706170;
        bh=eGy9X7OAL4wkzbeBoEWEG1SGeJHANMG2vppdHyxCWtQ=;
        h=Subject:From:Date:To:From;
        b=HyImArrwbK2fXB6sRS5tyjldkIa5AoFrG05xgNqhAu2BgefhWRbx5V+7oG5pKsTiH
         IqFL4d5G7SpzOowaJn9siIFkYTFA2RI24xVDdCjqm50IT0Vz8hzKbxw6ehe9aq5tuN
         Z7A4VT7bZVNq+S9OfplHWiiFHzNasvp5iQy4Bjms=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160370617030.22691.8838875473685877977.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 26 Oct 2020 09:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-26T09:45:18)
  Superseding: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:55:01):
    [v2,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v2,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v2,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v2,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v2,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v2,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

