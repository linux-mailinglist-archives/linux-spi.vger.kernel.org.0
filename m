Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6296268EE2
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgINPD7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 11:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgINPAd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 11:00:33 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095632;
        bh=5i0cdu7uj6m2FyMh4r0d6TsvM3tHIa7sOMxSTjjK5GU=;
        h=Subject:From:Date:To:From;
        b=z5i0Z2rXEhMtOMOlen7Dr+idG2LUl7fhJRc3+TZ3LIzm/y1YoJjuFzGL2GeWTbHPt
         rkICCFVafrmhcGaL1qH1L5himEy9v0YayXdhyDM1WQBtBImb4GE6fT/KoAECpUrw8y
         7T2drM6K7bTlgeA4AgjUlqHxoUyBxnU4o7PMOX+A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160009563266.1732.11267419880423428731.git-patchwork-summary@kernel.org>
Date:   Mon, 14 Sep 2020 15:00:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: qspi binding and DTS fixes
  Submitter: Florian Fainelli <f.fainelli@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=339751
  Link: <20200827181842.1000451-1-f.fainelli@gmail.com>
    Patches: [1/5] dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
             [2/5] ARM: dts: bcm: HR2: Fixed QSPI compatible string
             [3/5] ARM: dts: NSP: Fixed QSPI compatible string
             [4/5] ARM: dts: BCM5301X: Fixed QSPI compatible string
             [5/5] arm64: dts: ns2: Fixed QSPI compatible string

Patch: [REBASE] spi: sprd: Simplify with dev_err_probe()
  Submitter: Krzysztof Kozlowski <krzk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=346757
  Link: <20200910160706.5883-1-krzk@kernel.org>

Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
