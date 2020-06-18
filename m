Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A622A1FF6CD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgFRP3L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:29:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:21448 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731538AbgFRP3H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:29:07 -0400
IronPort-SDR: EWDCxDSlCRHUOYQiFIgmKQPR8SZVtVClrXiHguU/gdyVGUFGEN7oxHOj2Al9lZZYMKotC7H8f5
 4Yj0/flSfJuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="140137391"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="140137391"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:29:07 -0700
IronPort-SDR: 3PZZ9fhyzoqDBmQ9LssgSmsSrq4GOnNU3IkzLnUkHnF2PcU99QFJFDtUNXWzNybmrdUDXMcHdX
 88EAECn01y3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="450675734"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 08:29:05 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH v2 0/6] add regmap & indirect access support
Date:   Thu, 18 Jun 2020 23:25:07 +0800
Message-Id: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Updated the regmap & indirect access support for spi-altera.

Patch #1, #2, #3 is already applied.
Patch #4 is an 1:1 replacement of of readl/writel with regmap_read/write
Patch #5 introduced a new platform_device_id to support indirect access as
         a sub device.
Patch #6 is a minor fix.

Main changes from v1: 
 - Split the v1 Patch #4 to v2 Patch #4 & #5. 
 - Add a new platform_device_id to support indirect access.
 - Removed the v1 Patch #5. Now we use driver name string directly.
 - Add Yilun's Signed-off-by for Patch #6


Matthew Gerlach (1):
  spi: altera: fix size mismatch on 64 bit processors

Xu Yilun (5):
  spi: altera: add 32bit data width transfer support.
  spi: altera: add SPI core parameters support via platform data.
  spi: altera: add platform data for slave information.
  spi: altera: use regmap-mmio instead of direct mmio register access
  spi: altera: support indirect access to the registers

 drivers/spi/Kconfig        |   1 +
 drivers/spi/spi-altera.c   | 177 +++++++++++++++++++++++++++++++++++++++------
 include/linux/spi/altera.h |  29 ++++++++
 3 files changed, 183 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/spi/altera.h

-- 
2.7.4

