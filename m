Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B522974C
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGVLUJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 07:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVLUI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 07:20:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595416808;
        bh=5IaP2munkoLaa/0PuBqPPFV/cJ5CMTD5DaNx6GylRN8=;
        h=Subject:From:Date:To:From;
        b=Ukqo+6/m4Mdvn14nOKtIPqIoMrcJn9wYKdBEZVYuntEscrnlQnqnH8GKz0FJ2WTKF
         P+JAI0D/r9yxq8tbQ2Aw8++dK1vhCqZF0dl9+4FhrJ4Pf6VPmrjNbTZzXr43zyicKa
         ctpoMzJbcfBannrCcINsiEllMNrEvBEF5Z5oFQK8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159541680855.4353.2086057902077715245.git-patchwork-summary@kernel.org>
Date:   Wed, 22 Jul 2020 11:20:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: spi-cadence: add support for chip select high
  Submitter: Shreyas Joshi <shreyas.joshi@biamp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=321593
  Link: <20200721000850.370-1-shreyas.joshi@biamp.com>

Series: [v2,1/8] spi: lantiq: fix: Rx overflow error in full duplex mode
  Submitter: Dilip Kota <eswara.kota@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=319857
  Link: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
    Patches: [v2,1/8] spi: lantiq: fix: Rx overflow error in full duplex mode
             [v2,2/8] spi: lantiq: Add SMP support
             [v2,3/8] spi: lantiq: Move interrupt control register offesets to SoC specific data structure
             [v2,4/8] spi: lantiq: Add support to acknowledge interrupt
             [v2,5/8] spi: lantiq: Add fifo size bit mask in SoC specific data structure
             [v2,6/8] spi: lantiq: Move interrupt configuration to SoC specific data structure
             [v2,7/8] dt-bindings: spi: Add support to Lightning Mountain SoC
             [v2,8/8] spi: lantiq: Add support to Lightning Mountain SoC

Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
