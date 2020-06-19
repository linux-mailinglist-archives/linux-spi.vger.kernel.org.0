Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09D22002E6
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgFSHoB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 03:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbgFSHoA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 03:44:00 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16F32073E;
        Fri, 19 Jun 2020 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592552640;
        bh=G9lBmeDxHh2VeTZymUbF1CdX0re/3uaKH5q60zlt4gY=;
        h=From:To:Cc:Subject:Date:From;
        b=Jr0YrytKVOh9yPMdnZtTHUIndZk8WAzweXTFVG3Ktp/df/K6Mvu0eRFsBQt9uI4oO
         966xh614vJSnAP5XdHlHE+Gw+NUQeyGhDVgvXxDbjAZvTjsquBkZoFsHI+TqfRl8IK
         OzEjg9UwNEJmULmxV0z4XYHCNbzPOLV8YrWGRVQo=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org
Subject: [PATCH] spi: spidev: fix missing octal defines
Date:   Fri, 19 Jun 2020 13:13:45 +0530
Message-Id: <20200619074345.4041673-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 896fa735084e ("spi: spidev_test: Add support for Octal mode data
transfers") adds support for octal mode but failed to update userspace
header with octal defines causing build error for the spidev tool

spidev_test.c: In function ‘transfer’:
spidev_test.c:131:13: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function); did you mean ‘SPI_TX_DUAL’?
  if (mode & SPI_TX_OCTAL)
...

Update the header with octal values.

Fixes: 896fa735084e ("spi: spidev_test: Add support for Octal mode data transfers")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/linux/spi/spidev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index ee0f2460bff6..f0c95f5cc719 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -48,6 +48,8 @@
 #define SPI_TX_QUAD		0x200
 #define SPI_RX_DUAL		0x400
 #define SPI_RX_QUAD		0x800
+#define SPI_TX_OCTAL		0x2000
+#define SPI_RX_OCTAL		0x4000
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.26.2

