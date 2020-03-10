Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362E1180064
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCJOkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCJOkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 10:40:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583851214;
        bh=Mm4iZGW9DMrqf4ixYsgOYU0PPcIGXrcPTYIz4hoQnrE=;
        h=Subject:From:Date:References:To:From;
        b=vwpZAMNDgHIiQzvSPraasQ5KAxeKYwmE3X3q8os8b6v1iW/s4YUji1tT2B5jKN1sp
         Nmt8+brgSEw7rkDnRQn+IidQJ3duqGMdSpIwmdvtSNA+2pDd7qA2XNZTh1Gw5zEAYW
         lVQKIb8ZMfR9f9A923tdVq9TNN6ibR8bPNipb+QQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158385121428.9642.16592369733916934817.git-patchwork-summary@kernel.org>
Date:   Tue, 10 Mar 2020 14:40:14 +0000
References: <0e530494349b37eb2eab4a8eccf56626e0b18e6d.1582448388.git.mchehab+huawei@kernel.org>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: docs: dt: fix several broken doc references
  Submitter: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=245937

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
