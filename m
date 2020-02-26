Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2608817082A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgBZTAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 14:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgBZTAH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 14:00:07 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743606;
        bh=DLz+KqWnZvhMA+S0nDCD95xEeY9np0luI6k0ST2c6gc=;
        h=Subject:From:Date:References:To:From;
        b=Ls70e5zzuPj1geeCWbm9ro5PPBk00rD9C/eBlPGm5Ag4kaLJS/Ux62C8PGyjWpjzq
         WNefgPdmQ4lX6kZ15q0xfTE99T6CxbQMJRrw93PPvXw0F7pRr5P620D8J1Ohkuyz8o
         Z6L/D00buIE8GPHSzsPweiXL3yQ43fVbHXfhHaNA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158274360658.24014.9473215104257731449.git-patchwork-summary@kernel.org>
Date:   Wed, 26 Feb 2020 19:00:06 +0000
References: <20200211223700.110252-1-rajatja@google.com>,
 <20200211223400.107604-1-rajatja@google.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: pxa2xx: Add CS control clock quirk
  Submitter: Rajat Jain <rajatja@google.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=240023

Patch: 
  Submitter: Rajat Jain <rajatja@google.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=240019

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
