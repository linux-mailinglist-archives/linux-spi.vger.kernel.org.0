Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3193F70C0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhHYH5q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 03:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhHYH5q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Aug 2021 03:57:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29D1961214;
        Wed, 25 Aug 2021 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629878221;
        bh=uWM0Pf7qqAtfBLtvccpCBmBePKTySlx0bSxxeJ0LD2I=;
        h=Subject:From:Date:To:From;
        b=GNpa+BCRdvG+Z3/gilr0QHTHtrNXa9+c6LkEVj9bI+TGIfJ2m0+ZBFV7myeYPN1x/
         DP7fSIXJI/jeYxvg7G+/Sy7l0RCWwtTuQqVuLtTWLRRlFqghWVn1Br2ItrCbpK7tcm
         mKT0MbeJ563admfOMfR2KcVtS3FTptuH1xu51es5NkdKNh71wXGtrmHq/gN8vZ9oYw
         YdOy771cY/sTzp5y1cPSCaVnb0U/3NXi5I8ea16MnhPzCy0ntOvtHNWfJVd02mVyPo
         jF1n5w7GSjuQ5UT0ih8W0rW+Ifz4rMa/UZn2ozdIxyqYVhDfRZrF7SYUzSQoODHTYv
         2i/CmMxAcu2lw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2231260A02;
        Wed, 25 Aug 2021 07:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162987822113.22150.1310197057735425699.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 25 Aug 2021 07:57:01 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add sprd ADI r3 support (2021-08-25T06:59:28)
  Superseding: [v1] Add sprd ADI r3 support (2021-08-24T09:27:42):
    [1/3] spi: sprd: Add ADI r3 support
    [2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
    [3/3] dt-bindings: spi: add sprd ADI for sc9863 and ums512


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

