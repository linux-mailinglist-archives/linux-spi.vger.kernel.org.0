Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665E139C4A6
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 02:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFEA62 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 20:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhFEA61 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 20:58:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D91DA611AD;
        Sat,  5 Jun 2021 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622854600;
        bh=2gbOhOJCH2gUr2CFwhFTdsCDM//HMR9iB/MgL8aiqFs=;
        h=Subject:From:Date:To:From;
        b=EEcqv7K9VGtd8SO49UVDs/o64P5hZ0Yj0zDMTYW7901O6a7eee1OMguRsFxIU3To4
         8LWAp0H9AOmCJiwcPe6XLwkfc5AV4gdnFQiPAgOSgtud86oroAprFOIrAnRRxEifM7
         xIPVliPue2WwzQTwkbQcd7KE2BbjhaxGvAPXywi+t/fsubaz2qsPIRwU94BfT2AR6u
         zn3muZsl0mAU5bC8G7eRl/Z0NQWlgg7fnFF4rvZwYfFzntQ4Jsml6yo3s4BlpkW+ve
         V4wPCeKOFlzNGeU7m+dbXEgBVp0qKNSbwm7hz3LhuFNxXuY6//LC25i7zGoQLpNY/g
         tH7lcaQr+bCHA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D1ED060BCF;
        Sat,  5 Jun 2021 00:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162285460085.19826.6839624402439161551.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 05 Jun 2021 00:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: xilinx: convert to yaml (2021-06-05T00:29:31)
  Superseding: [v1] dt-bindings: spi: xilinx: convert to yaml (2021-05-31T05:21:42):
    dt-bindings: spi: xilinx: convert to yaml

Latest series: [v2] dt-bindings: spi: convert Cadence SPI bindings to YAML (2021-06-05T00:38:11)
  Superseding: [v1] dt-bindings: spi: convert Cadence SPI bindings to YAML (2021-05-31T14:15:38):
    dt-bindings: spi: convert Cadence SPI bindings to YAML


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

