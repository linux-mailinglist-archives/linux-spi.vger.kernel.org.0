Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E613D57D7
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhGZKQK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 06:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhGZKQK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Jul 2021 06:16:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D66B60E09;
        Mon, 26 Jul 2021 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627296999;
        bh=mLIHSMUH4kD6amMVqzu4oZzD1/EgQSnj4YVjIkmWnBs=;
        h=Subject:From:Date:To:From;
        b=GwZonk1+VhOuam3NXSKLLlwkpH1BcWFNaJKE/+GYexLNz1gmZg6QKsqYl2ocWZ+Nb
         zVyh+AjUQFqaoFPgfyzmgDDRV/RXVhod+4CjzeO65pGs2xOziplQ5S+1a3BciSvHXo
         sHHEfhTC+vWiNeekD0LdfkpF69qBP1uH8S52ydXQIOX6VGdtCMHTXPWe3QNb3+g+k9
         KalIefNhMwNJBe3Owy3pbTY41ZOr9PaQ3xnFdmDJK/q7qmgsc+mo8l/sqm8o8l/29D
         g9Z5VCD15dupkSESOBtTtIDIlAYGHp77jd37APPJ3KhSK/fu+fWomxM6siUIjit4WW
         Y2az30U5QpxVA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A4C960A56;
        Mon, 26 Jul 2021 10:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162729699924.12097.1934449426991533629.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 26 Jul 2021 10:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation (2021-07-26T10:01:02)
  Superseding: [v1] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation (2021-07-18T21:11:43):
    spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

