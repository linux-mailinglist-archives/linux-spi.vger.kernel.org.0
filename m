Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37D111C3
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfEBDAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 23:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfEBDAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 May 2019 23:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556766007;
        bh=eKEA/mRvCur+kApym6dCQJZvk03RANx8RzUKnF3LzPo=;
        h=Subject:From:Date:To:From;
        b=T6et5HFq691J8+rKrvInojZfcOqV9I/+Ab0NzZ6xbo8Q7WiNOEdmHP/B4vH+NZYXf
         rZPq2ns9hNtbFkFk/2Zb/OT28vJN5yaZeLagRO80H7ZLpZ5rxVvll3g2weGpldEc09
         +nwjeEYRXg9IZh0HSuowBFx4wM2GIDBVo153NrWY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155676600778.15941.11431802436480774516.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 02 May 2019 03:00:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-10T12:13:41)
  Superseding: [v1] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-08T14:39:49):
    spi: spi-mem: Fix build error without CONFIG_SPI_MEM


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
