Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9EC1E82A6
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 17:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE2P6P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 11:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2P6P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 11:58:15 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8E1208B8;
        Fri, 29 May 2020 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767894;
        bh=zL5cZTZL9Q9NYyBA9lT7dprVoQEUmueen5FwUFKr71A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMiV2+SxCCGbgl65XqB38WA3kKS1Bk6V3pQDJ9ZVs9H5VI9Z2pWzAuHF2cFqMwoHt
         Je4vYsI3doBvrNkWOw1FAxlzrIZN8qXBrkCgTZS+jpv6SBLhxkgW8NG55CjUUXmMY2
         +2yQwFVDA+koPTa89gsX0B4sZ7SYsvpMNcivVRYE=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        andriy.shevchenko@linux.intel.com, lars.povlsen@microchip.com,
        liang.j.jin@ericsson.com
Subject: [PATCHv4 2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
Date:   Fri, 29 May 2020 10:58:06 -0500
Message-Id: <20200529155806.16758-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529155806.16758-1-dinguyen@kernel.org>
References: <20200529155806.16758-1-dinguyen@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add optional reset property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: rebased to linux-next 20200529
v3: no change
v2: actually document the "resets" and "reset-names" optional properties
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 020e3168ee41..0f21407a7ea3 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -25,6 +25,9 @@ Optional properties:
   device.  Supported values are 2 or 4 (the default).
 - dmas : Phandle + identifiers of Tx and Rx DMA channels.
 - dma-names : Contains the names of the DMA channels. Must be "tx" and "rx".
+- resets : contains an entry for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names : must contain "spi"
 
 Child nodes as per the generic SPI binding.
 
@@ -40,5 +43,7 @@ Example:
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
+		resets = <&rst SPIM0_RST>;
+		reset-names = "spi";
 	};
 
-- 
2.17.1

