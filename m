Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00181C572D
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEENkP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 09:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEENkP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 09:40:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588686014;
        bh=+8lwBT8QpgumI5+oMesDnxTzeQ702ptE3sL6kpNnt3w=;
        h=Subject:From:Date:To:From;
        b=Q7LSssKXyKY0zgfIlbUJ4ynFYGpu1pUoDdWGu/lnXa3K+49sb/EEER+P1kTgT0OqM
         vkFanCBKsIvz8wX0urJBCOHVNy0mjB1EVxKQLEGFq+zD2r3EaXSy4w62rKH85XXE70
         u6VDWVVkvixDDlSHRHzGndQ25ZPqVer/udTY+4DY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158868601475.11996.2927726690169551841.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 05 May 2020 13:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: dw: Add support for Intel Keem Bay SPI (2020-05-05T13:06:11)
  Superseding: [v4] spi: dw: Add support for Intel Keem Bay SPI (2020-05-04T13:02:39):
    [v4,1/7] spi: dw: Fix typo in few registers name
    [v4,2/7] spi: dw: Add update_cr0() callback to update CTRLR0
    [v4,3/7] spi: dw: Add support for DesignWare DWC_ssi
    [v4,4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
    [v4,5/7] spi: dw: Add support for Intel Keem Bay SPI
    [v4,6/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
    [v4,7/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
