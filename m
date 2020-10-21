Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE502946C6
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411467AbgJUC4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 22:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411434AbgJUC4L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:56:11 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603248971;
        bh=sgPhWUQ1+o+LCSV+KH56HlgHJg8NMuymfvrpEgz5JlY=;
        h=Subject:From:Date:To:From;
        b=LBuAVCK12RAYfeDFvTBCO5aKvVlEPKoyRiQcvRB3XS+bN2r+ZvhszfrflTelNsWB1
         a+VkcmJ7yuh1vFUfhUIU8W+cKODU7K6FXLqXo44ai/leZReQXRqaH+kzQWzjZAfjC1
         t11RA/pe5sEn/aYylxEX7q+qM6FbPG6F5DeIGhvQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160324897091.7706.137588481375203080.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 21 Oct 2020 02:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:55:01)
  Superseding: [v1] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-20T02:32:20):
    [RESENDPATCH,v1,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [RESENDPATCH,v1,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [RESENDPATCH,v1,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [RESENDPATCH,v1,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [RESENDPATCH,v1,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [RESENDPATCH,v1,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
  Superseding: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:36:09):
    [v2,1/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v2,2/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v2,3/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v2,4/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v2,5/6] dt-bindings: spi: Add compatible for Intel LGM SoC
    [v2,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

