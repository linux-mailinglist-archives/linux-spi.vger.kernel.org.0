Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675674592A3
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 17:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhKVQHm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 11:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239994AbhKVQHm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9EE160524;
        Mon, 22 Nov 2021 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637597075;
        bh=7su5gVKoU6LxfqwsdkPAzegniwM93fqsZvNA4Sk4ACw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOX6ARW1xXFQRPRHt2euwA7dN4QMa97W+iQQPNdZrrMjPJx+aiRXglxfyYITn8+cy
         /w4Q3iUJIGAvzZ63GbBvi3MG9bw5xqm1t4jyk2hco3/3E0Nkbgtx8L0DxUTh7tQcG8
         fs5Y3y73XrfEbAeUMSrfvd2wucc9afLF0F1gbjlVUCTv2GXgtmyDa1nQ0IXctX11id
         6XXbf9lMGCIEEKYVi+fnkn7dhUu15B5m8+ozzXVG5kXr0QgKNpvndA4dNkiwHF4lcT
         XQO1C5WLiuuvJUD8jWG/FKaTEW+mQWy3L4lyMM4bHYS8rxXv1uJaHf0gQsDizVi49e
         47D3ZAgllcifg==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     broonie@kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: spi: cadence-quadspi: document "intel,socfpga-qspi"
Date:   Mon, 22 Nov 2021 10:04:27 -0600
Message-Id: <20211122160427.2808342-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122160427.2808342-1-dinguyen@kernel.org>
References: <20211122160427.2808342-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The QSPI controller on Intel's SoCFPGA platform does not implement the
CQSPI_REG_WR_COMPLETION_CTRL register, thus a write to this register
results in a crash.

Introduce the dts binding "intel,socfpga-qspi" to differentiate the
hardware.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index ca155abbda7a..037f41f58503 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -29,6 +29,7 @@ properties:
               - ti,am654-ospi
               - intel,lgm-qspi
               - xlnx,versal-ospi-1.0
+              - intel,socfpga-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
-- 
2.25.1

