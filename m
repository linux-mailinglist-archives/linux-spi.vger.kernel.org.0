Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE239AA32
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jun 2021 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCSlu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Jun 2021 14:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSlu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Jun 2021 14:41:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 58FC3613E3;
        Thu,  3 Jun 2021 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745605;
        bh=pYkOtJJWdf2N2VkjZj8J4StIyEu8eBYWoOaopTjtcto=;
        h=Subject:From:Date:To:From;
        b=glcCyyJsZmbL30f5TjE3+nLI2SyJfvW33PuBr5D0mmsCYbPpjYbDU0DuGBVFQXobP
         0Y7IBda6dy+ttXpdBpTCZ6ck5w4IQnTxPDM++jBcqL7f2QCSDFN+d9TgInRcTvAGr2
         AtYIeQ+SVzMY82mamHwPouFEjF0uuFqbarEbw4GUlEePeV1Cjtbp9hkkZXdSG+LpiQ
         hhTdiNur18ody4XmMIT3xP36QE//dr7XeR0vxVJY/lUKXuGhaicgIQ9EPIYdmFOLfj
         wN8xphhlpjQ1LxzlGNHQRDUr3eAtBj1BsqVFcZ5T/msNBzrjqfy0DmT/rC3Snm594M
         axFhsyVQ2l5ww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 447FA60953;
        Thu,  3 Jun 2021 18:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162274560522.762.17947647912567771375.git-patchwork-summary@kernel.org>
Date:   Thu, 03 Jun 2021 18:40:05 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: MTD: spinand: Add spi_mem_poll_status() support
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=484439
  Lore link: https://lore.kernel.org/r/20210518162754.15940-1-patrice.chotard@foss.st.com
    Patches: [v5,1/3] spi: spi-mem: add automatic poll status functions
             [v5,2/3] mtd: spinand: use the spi-mem poll status APIs
             [v5,3/3] spi: stm32-qspi: add automatic poll status feature

Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


