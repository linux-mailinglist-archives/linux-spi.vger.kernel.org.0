Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EDD1FFEC4
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgFRXkE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 19:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgFRXkC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 19:40:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C422C0613EF
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v24so3154977plo.6
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcHTOjx1Q346P9ZsaYW4owKJanYsDyPidI2shLjtOJ0=;
        b=dY+RVgnMbwlyOGl4P//IOxVJvx4Qsckqq5/7RKUlK3B0HNqReZ1iIEAYd/Gdz4XzoZ
         JUOMUSv3Yr6q9tPxAX+XhmV2u8vtcVcwEflJYgP+lEujrAkAgl82N8OhC6huceMDZDQq
         ytrLGOoiUvTIDJ8xyGuEVcRJxs7f0s/eDwhw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcHTOjx1Q346P9ZsaYW4owKJanYsDyPidI2shLjtOJ0=;
        b=o1lKR+7M75KA63tCP7mAH3gxRQT//TBgD3NOFUV9H/H2qQE5QTqBFx3jGJpfKLIXyL
         wt029gglzmHCeyazTbXnIpoLIUj+/zRr6CG9KMv/cx2HHvDFNB+HShSCM9P/lzZ8OCL8
         40/Cy1Zr9CZFETjc+1adXjmkXsX9I2ViK2NGm6G4U4rXFy5MF/p+5PFDfl7Jg2IOpquW
         tWv/LYUkj8KPNJz0+lc9JI5pFPwK8EubaLYhzW5HVlKJ6EUwzzLcW+B89AtJjb0sL14a
         d1kCmj6P8kXe55CXwz5Rc8UWSVWn7mKYzXS++CMfE7yr3hbI1E6T2CFQeV0Hy+PlFfNt
         excg==
X-Gm-Message-State: AOAM531ZwYxsv5YK5GaA80kvV2K7Uhv51VygbQFFHNWX7UlgxL5g0rFF
        ha05H8bxHP+UpdAtT4xdIRwuzHoScEg=
X-Google-Smtp-Source: ABdhPJyi4TrKrINHRr4ksSg7boVpVbJGS2fQzBBNhqgUlekddu3vS2EjX4ceIVFsaPIJfbmrwC/oOQ==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr765529pjo.85.1592523600729;
        Thu, 18 Jun 2020 16:40:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r202sm3876993pfr.185.2020.06.18.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:40:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 6/5] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
Date:   Thu, 18 Jun 2020 16:39:58 -0700
Message-Id: <20200618233959.160032-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The definition of SPI_FULL_DUPLEX (3) is really SPI_TX_ONLY (1) ORed
with SPI_RX_ONLY (2). Let's drop the define and simplify the code here a
bit by collapsing the setting of 'm_cmd' into conditions that are the
same.

This is a non-functional change, just cleanup to consolidate code.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 636c3da15db0..670f83793aa4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -51,7 +51,6 @@
 /* M_CMD OP codes for SPI */
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
-#define SPI_FULL_DUPLEX		3
 #define SPI_TX_RX		7
 #define SPI_CS_ASSERT		8
 #define SPI_CS_DEASSERT		9
@@ -357,12 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
-	if (xfer->tx_buf && xfer->rx_buf)
-		m_cmd = SPI_FULL_DUPLEX;
-	else if (xfer->tx_buf)
-		m_cmd = SPI_TX_ONLY;
-	else if (xfer->rx_buf)
-		m_cmd = SPI_RX_ONLY;
 
 	spi_tx_cfg &= ~CS_TOGGLE;
 
@@ -373,12 +366,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	len &= TRANS_LEN_MSK;
 
 	mas->cur_xfer = xfer;
-	if (m_cmd & SPI_TX_ONLY) {
+	if (xfer->tx_buf) {
+		m_cmd |= SPI_TX_ONLY;
 		mas->tx_rem_bytes = xfer->len;
 		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
 	}
 
-	if (m_cmd & SPI_RX_ONLY) {
+	if (xfer->rx_buf) {
+		m_cmd |= SPI_RX_ONLY;
 		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
 		mas->rx_rem_bytes = xfer->len;
 	}
-- 
Sent by a computer, using git, on the internet

