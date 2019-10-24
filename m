Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B406E302F
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407242AbfJXLUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407198AbfJXLUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Oct 2019 07:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571916019;
        bh=gMhK2F/gKjag/SBDRarERNTJmFw5DwQ7+cA6FsGaUF0=;
        h=Subject:From:Date:To:From;
        b=y86i8o1rfaIMDphVGfP77BneQI95yaColi4ZXFwkhIoYck2dLSO/Xbgqi43tg79gT
         +MRvz2BMbIzp+wPSXBBfY/XYLt+5HOylsv5pLL4aJooNpGWGiAd5tak/3NJIoY9aQr
         xQVzEOxh7uc47dL1xhkjOGjnk9uPJOQi7rsVYOxQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157191601947.30192.10611418869727111553.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 24 Oct 2019 11:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: xilinx: Add DT support for selecting transfer word width (2019-10-24T11:07:56)
  Superseding: [v1] spi: xilinx: Add DT support for selecting transfer word width (2019-10-22T09:00:07):
    spi: xilinx: Add DT support for selecting transfer word width


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
