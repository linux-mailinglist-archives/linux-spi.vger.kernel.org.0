Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07161C3AD9
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEDNEj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 09:04:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:6159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgEDNEj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:04:39 -0400
IronPort-SDR: 6QGzARkDtTETT1rxyRnOd3iZK5tUBgQr3mAA43T9qRicEavLSWD5jF3AgUuLqMibGJ8AwkF1tV
 YkKvkNcdYu3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:04:04 -0700
IronPort-SDR: Jp3+BuxZTFbOqwkr1LxJ9advre9i//UJItPnZzX3Q1xd9vc72gHqCdYMaI/3gyiLcSAAg/POtG
 3iOKid0EXJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="249169148"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 06:04:02 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 6/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
Date:   Mon,  4 May 2020 21:02:45 +0800
Message-Id: <20200504130246.5135-7-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document Intel Keem Bay SPI controller DT bindings.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2ead46b633ea..7a4702edf896 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,8 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a"
+  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a" or
+  "intel,keembay-ssi"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.17.1

