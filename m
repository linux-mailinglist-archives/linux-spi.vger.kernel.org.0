Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7272010C54B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1IkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1IkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 03:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574930410;
        bh=69+9Jaf8cgMFQer9JuOHWgLh8tVG8pIi8JXtOOOphWc=;
        h=Subject:From:Date:To:From;
        b=KsR+7F3IQQR+Zz1+yFUxwer3uZt0iS/oN2UOltbuNXKHcmaEiK+AGPpVABRNCtrKS
         W/9huFRR86r8zHLyzic340k5rGwCfIRuRqev/74SFdXIE5mhA2Wx+SF02I0pQhOcn9
         tPVqdkf1SQ3VO/FYnAKQeIFu0kkGxGQQQj+9Yatg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157493041019.14425.2666118884101488073.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 28 Nov 2019 08:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: fsl: Fix GPIO descriptor support (2019-11-28T08:37:16)
  Superseding: [v2] spi: fsl: Fix GPIO descriptor support (2019-11-27T13:54:08):
    [1/3,v2] spi: fsl: Fix GPIO descriptor support
    [2/3,v2] gpio: Handle counting of Freescale chipselects
    [3/3,v2] spi: fsl: Handle the single hardwired chipselect case


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
