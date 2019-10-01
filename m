Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1603C3F33
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJASAF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 14:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJASAE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 14:00:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569952804;
        bh=tGGdZeaPYDytPm0udl8hNHXF6YkoqL+id501GxHik7M=;
        h=Subject:From:Date:References:To:From;
        b=tXN1g2z2XuhCvFMkvgxupj4ljAgyb1do7eXRdPttN/mGR7X3dT2NYraxqtcWc9mAy
         2w7c6FvmIhk+NnuJ7H+SFjT56NJjQEPdtZeIdWBFwuER4fVHh5UjO8XK11iLy3sQAC
         vCHbZXjbWs+TUVT9srZqaSOM9Er/HNnJg/wx29F4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156995280453.24256.7165519031897637742.git-patchwork-summary@kernel.org>
Date:   Tue, 01 Oct 2019 18:00:04 +0000
References: <20190930033928.32312-1-navid.emamdoost@gmail.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: gpio: prevent memroy leak in spi_gpio_probe
  Submitter: Navid Emamdoost <navid.emamdoost@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=180171

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
