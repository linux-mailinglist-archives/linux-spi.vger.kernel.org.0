Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B5A97FC
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfIEBUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 21:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEBUU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 21:20:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567646419;
        bh=6iwflKl6K5jKo0E0so8inhy6sO6g8cjLPxZN4h40v0c=;
        h=Subject:From:Date:To:From;
        b=aJwbrB9A5JOTZdsGgIfOIn9h+xB+SgW/0MHOKX+kspbmzDTzodurouNCqrT61FvwI
         NaDOK/ozzISSiH4w7lbzm3fFdMbghDe/4jaUIUDBIJHqxX4tqg8/GYHfE+BXy22+HJ
         8xUEQQk+Kokm78gb2ryylHyC+Rz0Subiw3vf7PRE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156764641967.27127.15945108735409147590.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 05 Sep 2019 01:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Deterministic SPI latency with NXP DSPI driver (2019-09-05T01:01:11)
  Superseding: [v1] Deterministic SPI latency with NXP DSPI driver (2019-08-18T18:25:56):
    [spi,for-5.4,1/5] spi: Use an abbreviated pointer to ctlr->cur_msg in __spi_pump_messages
    [spi,for-5.4,2/5] spi: Add a PTP system timestamp to the transfer structure
    [spi,for-5.4,3/5] spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing
    [spi,for-5.4,4/5] spi: spi-fsl-dspi: Implement the PTP system timestamping for TCFQ mode
    [spi,for-5.4,5/5] spi: spi-fsl-dspi: Disable interrupts and preemption during poll mode transfer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
