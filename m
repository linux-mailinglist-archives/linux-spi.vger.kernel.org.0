Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4452C396832
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEaS63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhEaS63 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 31 May 2021 14:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F0B1B60FF2;
        Mon, 31 May 2021 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622487409;
        bh=y/unjfJL3JberZzNI8z+souRrxLXfInpdkycMGOLks0=;
        h=Subject:From:Date:To:From;
        b=Vi3N1u7XKr2kk6PCL2Py5RBQ6q6YIWiNJJXEFxhVdV7kT07bK/WfoylAHkvO307PY
         jiijrEAJdLMViAaUTc59dsgA5zkbWXw6BAUeT8kATEInsAyIFeLuamQOhiskoc1055
         uoQp7XMns3rh9vxRW3ctojj6IgU8e0WyEur5Eq8uUdYLzd0ZnvdSgsnYO2gU2bKe/X
         bRZcXqCfmBg5A1zpnCdNS5XSIj1qOJPiMjYMMsZ1t7xAkppn3/P5Q6qCGjBmvSrYWW
         7pBxNS4DZI7y8rz+goeDS7ASywsbAklRBriuu7v/eqTdIsdvgID2GSAsnn3IYmIoPQ
         yd/OtJJ8ASPBQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCCD0609D9;
        Mon, 31 May 2021 18:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162248740884.29057.15653802629122106187.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 31 May 2021 18:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Avoid odd length/address read/writes in 8D-8D-8D mode. (2021-05-31T18:17:51)
  Superseding: [v1] Avoid odd length/address read/writes in 8D-8D-8D mode. (2021-05-06T19:18:23):
    [1/6] mtd: spi-nor: core: use 2 data bytes for template ops
    [2/6] mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
    [3/6] mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
    [4/6] spi: spi-mem: reject partial cycle transfers in 8D-8D-8D mode
    [5/6] mtd: spi-nor: core; avoid odd length/address reads on 8D-8D-8D mode
    [6/6] mtd: spi-nor: core; avoid odd length/address writes in 8D-8D-8D mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

