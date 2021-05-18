Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651E387A7B
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbhERN6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 09:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244711AbhERN6E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 09:58:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 684A161184;
        Tue, 18 May 2021 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621346206;
        bh=LVfM2Yp2WH7tJejElWIyxwHB6MX6SWwvIbrbO7I3W70=;
        h=Subject:From:Date:To:From;
        b=k5aqqD7n0xraAUxpEAPLUKGQn5zD/oH9ZbPHaEwPHJvuCWCYXbBxzfx/N7NBGZbLo
         FiX7X6lKqlToq9VH8k1g6rwoGtKpfCcRZKmZjOoGysVipmg6R9wU9aQzJMGJwRAI04
         QI14CO+wUJKxWM0q96qbfdUbLxNZWS2ZNcy7WYzWySnR3GZjX0UmbwXZ+zCHN2Y5Y3
         wDfbpd7ibDW6c+8HCVNCRXJ3bEhV06JuLZT8uPClQrnKLpDz+vsf5m4WnuLX2/ohrQ
         khutdJHRPTnbmiobcIoLLmSGzqFNKKhamlavHgWkFUmVtY/fkruwEsd9Dn4AE7uNTd
         nRHeKuzc+fHLQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5BFE060972;
        Tue, 18 May 2021 13:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162134620636.2373.5430071948916287898.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 May 2021 13:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] MTD: spinand: Add spi_mem_poll_status() support (2021-05-18T13:43:32)
  Superseding: [v3] MTD: spinand: Add spi_mem_poll_status() support (2021-05-18T09:39:49):
    [v3,1/3] spi: spi-mem: add automatic poll status functions
    [v3,2/3] mtd: spinand: use the spi-mem poll status APIs
    [v3,3/3] spi: stm32-qspi: add automatic poll status feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

