Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC345473A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhKQNeT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 08:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhKQNeT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 08:34:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC8C761B1E;
        Wed, 17 Nov 2021 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637155880;
        bh=33bRfbMDfWohdew3q0h0oJFiJrEU9QRWSRrNJ0UHk7U=;
        h=From:To:Cc:Subject:Date:From;
        b=by00Ve2WLafWkl76i97JRGysVEVEByUutTkJbGK5kgXnQRVMOrtqbX5gnFYNNZWSR
         m/vP4hLPfwRmWcpACsDLJb30AiM069a6L3/XlQU2auwwqE30povUkBu/cWr3WK97p2
         PjMwH1lhP5iufwvD5O+/1fzs0ZedEC8YN+iGs1jz4YyOyMJHTUCF8ArwAYPL7Q3P2a
         7B2UocvJ3NaRfDtOuIBHtw0kL0huB1k+EqLaY7Zv+3xC1Po49URDyqd9TMSF60A045
         2REBASspxknEXGFUjTJ71JH5WcOXVDJrYJcDkhKRIzwF4PWbXXc7/yU+DfxMqh7rJn
         iDEY1DCA8LgRA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: qcom: geni: remove unused defines
Date:   Wed, 17 Nov 2021 19:01:08 +0530
Message-Id: <20211117133110.2682631-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
added GPI support but also added unused defines, so remove them

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e2affaee4e76..413fa1a7a936 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -71,10 +71,6 @@
 #define GSI_CPHA		BIT(4)
 #define GSI_CPOL		BIT(5)
 
-#define MAX_TX_SG		3
-#define NUM_SPI_XFER		8
-#define SPI_XFER_TIMEOUT_MS	250
-
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
-- 
2.31.1

