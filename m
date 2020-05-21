Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791B01DD3DD
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgEUREM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 13:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgEUREI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 13:04:08 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0718820884;
        Thu, 21 May 2020 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590080647;
        bh=ByMsLNxOv98oD1I2QYWRxCwZOStuOsJ8QrLvIt31QKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEWX/A2oF2OsTQvKsQzx1VKJFvSfCWBtkpcqgBPKZO4a5l1STPNfU2YJS8csgUYV0
         H1Xs5V5nTZpviD5s2+EeDRquxVbz7fdMI4FjVxRjzob/WDnHAOmQaJLAR6j3BLl7Yo
         TZ0/Y40CgQX6mGYbWI04Z+8y643g53u9KaZd4mpE=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
Date:   Thu, 21 May 2020 12:03:59 -0500
Message-Id: <20200521170359.20430-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170359.20430-1-dinguyen@kernel.org>
References: <20200521170359.20430-1-dinguyen@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add optional reset property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 3ed08ee9feba..e01c557a9876 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -37,5 +37,7 @@ Example:
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
+		resets = <&rst SPIM0_RST>;
+		reset-names = "spi";
 	};
 
-- 
2.17.1

