Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF81E251F
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgEZPMg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 11:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgEZPMe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 11:12:34 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A062084C;
        Tue, 26 May 2020 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590505954;
        bh=Z9bdFnz1pD08lYT+ADDGs4FNE+dhk4zct/gTLKdD2e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YquJWBRw4fUGZ1351dAw9Kiwg7K3Hl4o4UTHmz1qJ4evIGudXDEQpoNbAYvnM3N3r
         F3D0VnkftoawaVL+SuakWnWVjfz3S0iyBaHWdwpOgt8uUcXB0gHCmNdvT2qiJu2tUq
         uuCEU7rcfGkmPMlRIRVyBuif6y03NTU2n6u29f4k=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        andriy.shevchenko@linux.intel.com, lars.povlsen@microchip.com
Subject: [PATCHv2 2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
Date:   Tue, 26 May 2020 10:12:18 -0500
Message-Id: <20200526151218.6186-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526151218.6186-1-dinguyen@kernel.org>
References: <20200526151218.6186-1-dinguyen@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add optional reset property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: actually document the "resets" and "reset-names" optional properties
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 3ed08ee9feba..c679778612f3 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -22,6 +22,9 @@ Optional properties:
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
+- resets : contains an entry for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names : must contain "spi"
 
 Child nodes as per the generic SPI binding.
 
@@ -37,5 +40,7 @@ Example:
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
+		resets = <&rst SPIM0_RST>;
+		reset-names = "spi";
 	};
 
-- 
2.17.1

