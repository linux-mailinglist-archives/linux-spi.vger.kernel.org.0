Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B71175B3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 20:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLIT07 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 14:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfLIT06 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 14:26:58 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575919618;
        bh=VJjBM+O+gZE6OliOSnVtoa3psO6ucdVP0skCAhMAHiI=;
        h=Subject:From:Date:References:To:From;
        b=eL0u9wKXmVcyrbrAace/fNgGWkWSv/XQRwx0ChnuaHM6ru4mRz1R50H1LtQPOLPT7
         pDWr+Ifa6ZFO/aVOv6+flFCFZ/oCG0s8Bj6iGxEfX9uPSuMR1851dqIkLFYos5F+xM
         m7G98E9gVBm7bI4RiMJDZ2My6me7pAjWIA0DtO/A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157591961835.17736.14350073191933211362.git-patchwork-summary@kernel.org>
Date:   Mon, 09 Dec 2019 19:26:58 +0000
References: <5daaac0d.1c69fb81.12761.2a24@mx.google.com>,
 <5db1f3ab.1c69fb81.5387b.d1fa@mx.google.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: broonie-spi/for-next boot bisection: v5.4-rc3-73-gc673f2d99c3d on jetson-tk1
  Submitter: kernelci.org bot <bot@kernelci.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=190289

Patch: broonie-spi/for-next boot bisection: v5.4-rc4-82-ge025ec2b58a5 on jetson-tk1
  Submitter: kernelci.org bot <bot@kernelci.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=193195

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
