Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832BC1167E3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLIID0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:03:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:36446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIID0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:03:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="210037577"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 00:03:24 -0800
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     linux-spi@vger.kernel.org
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/6] spi: dw: Add support for DesignWare DWC_ssi
Date:   Tue, 10 Dec 2019 00:03:57 +0800
Message-Id: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Hi.

This patchset add support for DesignWare DWC_ssi. This soft IP is an AMBA
version 2.0-compliant AHB slave device. Existing driver already supports
the older APB version.

This patchset is tested on Intel Keem Bay SoC evaluation module board.

Thank you.

Wan Ahmad Zainie (6):
  dt-bindings: spi: Unify SPI DesignWare DT documents
  dt-bindings: spi: Delete spi-dw.txt
  dt-bindings: snps,dw-apb-ssi: Add compatible string for DesignWare
    DWC_ssi
  spi: dw: Fix typo in few registers name
  spi: dw: Add update_cr0() callback to update CTRLR0
  spi: dw: Add support for DesignWare DWC_ssi

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |  24 +++-
 Documentation/devicetree/bindings/spi/spi-dw.txt   |  24 ----
 drivers/spi/spi-dw-mid.c                           |   4 +
 drivers/spi/spi-dw-mmio.c                          |  31 ++++-
 drivers/spi/spi-dw.c                               | 125 +++++++++++++++------
 drivers/spi/spi-dw.h                               |  25 ++++-
 6 files changed, 163 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

-- 
1.9.1

