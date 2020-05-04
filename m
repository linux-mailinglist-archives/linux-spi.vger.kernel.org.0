Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C71C3908
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgEDMNM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:13:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:41921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDMNM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:13:12 -0400
IronPort-SDR: 9adqNiFcKQ2FHmQ7T6ZXlPuT9wYEUcQM3pLlV5Q3D33+9b+MkNarYrGpiIZrZNUiCMqOsjuYOB
 a5cI/DZqeNRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 05:13:12 -0700
IronPort-SDR: O5aLDg2zNnMaaTjBgB9TwST3+cvqgId82I3l37rYS4PqlrGV5ulDmP/IbRcSK9Gq/tn0mP3fzx
 FZsjArUf2e8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="295480544"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2020 05:13:10 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v3 7/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
Date:   Mon,  4 May 2020 20:11:51 +0800
Message-Id: <20200504121151.1085-8-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document Intel Keem Bay SPI controller DT bindings.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index f67852fb9d94..edc1e6fb9993 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -20,6 +20,7 @@ properties:
       - amazon,alpine-dw-apb-ssi
       - snps,dw-apb-ssi
       - snps,dwc-ssi-1.01a
+      - intel,keembay-ssi
 
   reg:
     minItems: 1
-- 
2.17.1

