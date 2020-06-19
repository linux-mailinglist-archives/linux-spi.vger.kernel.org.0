Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE19D20093D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFSNAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 09:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732310AbgFSNAO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 09:00:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592571609;
        bh=mBJ5mObuv9w6InOyPOlwMl1fHwkXj9PtDy+FuidwT3I=;
        h=Subject:From:Date:To:From;
        b=ZNLGLfbWFi0JXWAy4I6z4l6m7U/YgNVK4lRgLDWH2jJztjm3qk35SFT/8M4XUDT21
         5t5XK9vAZRMPnbdSK9sbKzzXJ2sFshHJKSppB44J2bvdkISczFQRyEI3d5/lBu5iAo
         W9Q8nFqMtFMfUKzfE2eGBSQM+LZUB+XSARdKiRr8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159257160973.351.7172221526279524136.git-patchwork-summary@kernel.org>
Date:   Fri, 19 Jun 2020 13:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: add regmap & indirect access support
  Submitter: Xu Yilun <yilun.xu@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=305301
  Link: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
    Patches: [RESEND,v2,1/3] spi: altera: use regmap-mmio instead of direct mmio register access
             [RESEND,v2,2/3] spi: altera: support indirect access to the registers
             [RESEND,v2,3/3] spi: altera: fix size mismatch on 64 bit processors

Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
