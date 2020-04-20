Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4B1B15CF
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgDTTUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgDTTUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Apr 2020 15:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587410416;
        bh=Erk10aFqeLiTLOOC0E+ba8RAcwzSD/3Wqt1/SH/rDdo=;
        h=Subject:From:Date:To:From;
        b=e57AnHOBh9GIuZVyP6CI7SkyjPqolnIhRXp8aDsTyQQ71jMOi3nUIvqqi0VdaaJqE
         HGWSHxKuVt1WfRuSS0Lp06YuQYMRpNxe5X1llUPMIw6Gy8nJnGiVh0BaOEJLYNNwgk
         13vJAYkV09pRpIOpvyvh7L8o4YjxN/KNqbXoTfv8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158741041630.1165.5127497112869386841.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 20 Apr 2020 19:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm-qspi: Handle clock probe deferral (2020-04-20T19:08:45)
  Superseding: [v2] spi: bcm-qspi: Handle clock probe deferral (2020-04-19T19:23:30):
    [v2,1/9] spi: bcm-qspi: Handle clock probe deferral
    [v2,2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
    [v2,3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
    [v2,4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
    [v2,5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
    [v2,6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
    [v2,7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
    [v2,8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
    [v2,9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
