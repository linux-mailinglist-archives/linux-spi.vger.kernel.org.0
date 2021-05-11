Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384F337AA00
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhEKO5v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhEKO5v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:57:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CF1616134F;
        Tue, 11 May 2021 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745004;
        bh=oK2rhvX72xfjcv23nSPYwSYQtvp4FJa9InRI0qoLsig=;
        h=Subject:From:Date:To:From;
        b=RoUr8uy8ABC6wC+94Cwsghc/kTDow94YIXVwWwfh6t/4JHdO78R8XI4084B3R2vRT
         AHZUChExZsGKrjfoLS3W4UlgmBxzWqCmzXygIbnctTqm8l9ulNERRg1yRmc3xjuDvc
         dPI/8D4vDYBU2+dfcKg4p9dPhiR599BAFmG1FRR+dlNboOjN5RbofSxkChET0omCmW
         zK80OxRlcpt1A90d1KvJ7XW9r5eK1L0vrBJKBAm2tj0zezRRRnF/NEsjCEY0YVi2KG
         qWBFc3oBHOCZJrVZQPnZ4GDBwbeITqmv2q4onSv1zujm6MJuKKwwFQu0DbW8HYFbsF
         4Fep8wNiBTbDQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B283660727;
        Tue, 11 May 2021 14:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162074500467.26286.3666363351165240696.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 11 May 2021 14:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: pxa2xx: Set of cleanups (2021-05-11T14:17:18)
  Superseding: [v3] spi: pxa2xx: Set of cleanups (2021-05-10T12:41:24):
    [v3,01/14] spi: pxa2xx: Use one point of return when ->probe() fails
    [v3,02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
    [v3,03/14] spi: pxa2xx: Utilize struct device from struct ssp_device
    [v3,04/14] spi: pxa2xx: Replace header inclusions by forward declarations
    [v3,05/14] spi: pxa2xx: Unify ifdeffery used in the headers
    [v3,06/14] spi: pxa2xx: Group Intel Quark specific definitions
    [v3,07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
    [v3,08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
    [v3,09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
    [v3,10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
    [v3,11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
    [v3,12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
    [v3,13/14] spi: pxa2xx: Constify struct driver_data parameter
    [v3,14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs

Latest series: [v2] spi: Assume GPIO CS active high in ACPI case (2021-05-11T14:09:12)
  Superseding: [v1] spi: Assume GPIO CS active high in ACPI case (2021-05-10T14:10:22):
    [v1,1/1] spi: Assume GPIO CS active high in ACPI case


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

