Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682CD47B1B1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhLTQ5H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 11:57:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40022 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLTQ5H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 11:57:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4067061247
        for <linux-spi@vger.kernel.org>; Mon, 20 Dec 2021 16:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A40D0C36AEB;
        Mon, 20 Dec 2021 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640019426;
        bh=nGt56fgGb4PmmsrdLQw0J6eAqAsdxhds2rZmZdDaRyA=;
        h=Subject:From:Date:To:From;
        b=jURP9tnxdumTsx3mUgIOtOaIO4gYmV3krE/006AFQYqtbA38iFotCbiF5d02tuuRd
         MdC2mw6HHQCjLp2IrTxNgoAftw70AxX+qVHgNc+wFo9SgQnIcwB2+CUGXJcPzq/MSq
         fOLJBoHVuKd0n8OdC7+yd8AAOTa8d27vid/rRIKU1M0Pcukhdrxn3F632SyhGS+VLb
         UwJ5cXDWaeq0ebTaP3A4xtlOhJpzJ1zcIMlhQ+2YMSMhVIbVnIigRX3SOWX0/0P7Ak
         GncaPlcEhgxAIMvCdhrnI5XsmHBACEVrNKEU0LVGu/7uhDpKEsB1o7oGbveI6ktB4u
         X8wwZroq2WN5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 789C6600E8;
        Mon, 20 Dec 2021 16:57:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164001942643.13871.3326603897040404893.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 20 Dec 2021 16:57:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-12-20T16:46:24)
  Superseding: [v4] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-11-18T13:05:41):
    [v4,1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
    [v4,2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
    [v4,3/3] Documentation / MTD: Rename the intel-spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

