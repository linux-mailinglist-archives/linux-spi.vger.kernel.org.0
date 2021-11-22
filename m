Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3D459807
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhKVXAD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 18:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKVXAC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 18:00:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9419160FDA;
        Mon, 22 Nov 2021 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637621815;
        bh=RWHFdTb495MB1AhR6pELI9Br2Wed4bg79XAzIBnCOnA=;
        h=Subject:From:Date:To:From;
        b=B2VwTiYqO1J0pXbwXBv/Dwqx5nDJMOhRs1mzhr/N1AjMF2zy2q9+LCBy9Jgxizxhg
         ZIvdYSTJVROrk8zLUieoidrBdOgx2YxYm7gtrRS1WY8FEiADfisJj3MtBMxkvdNf9o
         idcOe2Z+dMTyA7Kcru8FovHZi7DRM339wP/yo8pdcPfun6wP3ImHODC7nJAOtGJGuA
         s2H+U7Q4HPR3RsEevK/zd6NKJaEBS8HoODNYjOAZC51ZsiY0mV9c9+4sUQKIW9egfM
         LZ37HVZGD5XlKja0vIfh79HSX1s+aIGf3czv3A02UjaMmBeE3W6XUF3Ppz4/AxXBH5
         NVL/lJs8oEVQA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8835E60A3B;
        Mon, 22 Nov 2021 22:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163762181555.1547.14715663075960614921.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 22 Nov 2021 22:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dmaengine: kill off dma_slave_config->slave_id (2021-11-22T22:21:52)
  Superseding: [v1] dmaengine: kill off dma_slave_config->slave_id (2021-11-15T08:53:52):
    [01/11] ASoC: dai_dma: remove slave_id field
    [02/11] spi: pic32: stop setting dma_config->slave_id
    [03/11] mmc: bcm2835: stop setting chan_config->slave_id
    [04/11] dmaengine: shdma: remove legacy slave_id parsing
    [05/11] dmaengine: pxa/mmp: stop referencing config->slave_id
    [06/11] dmaengine: sprd: stop referencing config->slave_id
    [07/11] dmaengine: qcom-adm: stop abusing slave_id config
    [08/11] dmaengine: xilinx_dpdma: stop using slave_id field
    [09/11] dmaengine: tegra20-apb: stop checking config->slave_id
    [10/11] staging: ralink-gdma: stop using slave_id config
    [11/11] dmaengine: remove slave_id config field


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

