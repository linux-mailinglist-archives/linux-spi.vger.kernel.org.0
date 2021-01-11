Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED332F1B9B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbhAKQ5X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbhAKQ5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 11:57:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C762A2242A;
        Mon, 11 Jan 2021 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610384202;
        bh=iAMofg0vSyL4UVDFO4ukRUmmd/CNpDli2THXZAJVLjU=;
        h=Subject:From:Date:To:From;
        b=NiKSGpVzAwkR2aBI5coUjgUmwaFtXnWhGxsfMlWxXPm5Ab9iRebVP4Xnnea4shcHz
         UQ2/bx+9kqf4TutdoROTvc+lqa2bvr6Xpvx8LwJKWbgtLBBxXDo8tTQXAFAP18l458
         QLTrvkaijXUOItiylIeir6fqnv1F2M8q/Xg4ZZ+MgoogYZZB0CtP633i8jA+rwB7CF
         1T/Z9o2OLeQd+2FaELE2GnT5b89GE4G3FWPSVFgpgGFPusfX6PAuXsjSAHAMmu5U6X
         eXr2rGR7HmLp0s3BkptP1g1F7ukSeXc2lNn/IrQMb6jxcTdWLM947uWvmR0YssCBTA
         AnhhS/0AlBP3A==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id BA19C6013D;
        Mon, 11 Jan 2021 16:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161038420275.3886.16606405380311685175.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 Jan 2021 16:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:54:48)
  Superseding: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:26:29):
    spi: spi-bcm-qspi: style: Simplify bool comparison


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

