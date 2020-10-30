Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5768829FD81
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgJ3F4J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJ3F4J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:56:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604037368;
        bh=rCbIXsuLv2fhaao036k6Qzqwy0lyLA5Y27IcmirOP30=;
        h=Subject:From:Date:To:From;
        b=n8dqSxoSP2hmC9cyY/8nIRhppfbSxDVG3f63uaV75KLKaOpwtK4vm17ihcn7oPefL
         VO72xN9RoYZimFAF5HZsnECK2jJW2W8G8PJ+fAq3qxiS5BJfGUfZgYnL6EfFz37hEs
         20nJFTlNxpn5+Cn70y9dp6PChmJ1RorDUanzVRZs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160403736830.12092.2152998476656214039.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 30 Oct 2020 05:56:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-30T05:31:47)
  Superseding: [v5] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-29T06:20:14):
    [v5,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v5,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v5,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v5,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v5,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v5,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

