Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52D38AFBD
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhETNOW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbhETNOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 May 2021 09:14:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F52C061574
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:13:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k14so21749169eji.2
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/e9wmFRK34KVqxpuDLR0+Pbsau4yqa9WEQV9ibbe7U=;
        b=S6Xz/8/jobrxo7PlvBJmOZZjArYZImPjbZJFQ0RT+k31XlHuPL93qi4EmaO2ZWXUfs
         TxM8Z6tPCgncmeRGSlJ1ivFOcek7EMBalU329X8+JZMz9J+bmRgmN1YysQNjrquQsRZ8
         N/UNV2Jhp2scPOPv9cKTqoTAXUgWuetwLJMBTrWSVRxaMY/v40RKWasHrPlAZb8O1Frt
         3qY1VxP/iLpOHAVz884yt9D6W4yEsrZD8AhOzlTMi607wyX4I8wPkac2IFE7AdsO09XW
         7+LxaFS+Ifzy8PRLxyebgIBI60kd6UBbT7w9lkGQqe1C5GbW1DPQaRkw46puBUpuojb6
         G1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/e9wmFRK34KVqxpuDLR0+Pbsau4yqa9WEQV9ibbe7U=;
        b=AfwOMH7UbQ4Rf5wXlTTQAbLMoFMobg5mhv33BITJCBnDDt+Cs9mn/nkjP8BMbfXWju
         47fDy50odvPXwEkt1/o7nlsH4lnUPwA7CbMhNf0Nd9doiTJVH02F8mPQHKv5ZhjxITzF
         Hap7OY5eqaKr5tWqyhU/CHVAETAZc5iPwBjJp3i+yffSpaV7msPxWJRbA9XtN7QBuFk6
         yWIhpmzIAps/Fq3rinH5ovHOM09oVNUd+qEKjGNVnzhBD3/ZD9Isp20n55GoG94K2y1u
         mnMCSiM6SnArbghS1NOAlAjPDhhvfAOntzOOW5ejK1hR4pF/VoBpLfynrjCzTebot6Nt
         xXAQ==
X-Gm-Message-State: AOAM5329vC9aAxL3AEO9t/HIuxNkbi8VKYFcOkcFrGzBUWuahNlaaTKM
        rGPZ8LHEY0fLzpW8kShyWYj3wG85P/0=
X-Google-Smtp-Source: ABdhPJxFYNf6BERz5Twg5NxazBp/5DHJTjq/kFE10dnqWyi+IpPpCCBFmcBNNMvMGK8eS47spWcehQ==
X-Received: by 2002:a17:907:1002:: with SMTP id ox2mr4518945ejb.337.1621516378967;
        Thu, 20 May 2021 06:12:58 -0700 (PDT)
Received: from localhost.localdomain ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id gt12sm1362505ejb.60.2021.05.20.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:12:58 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v1 1/2] spi: sc18is602: don't consider the chip select byte in sc18is602_check_transfer
Date:   Thu, 20 May 2021 16:12:37 +0300
Message-Id: <20210520131238.2903024-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520131238.2903024-1-olteanv@gmail.com>
References: <20210520131238.2903024-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

For each spi_message, the sc18is602 I2C-to-SPI bridge driver checks the
length of each spi_transfer against 200 (the size of the chip's internal
buffer) minus hw->tlen (the number of bytes transferred so far).

The first byte of the transferred data is the Function ID (the SPI
slave's chip select) and as per the documentation of the chip:
https://www.nxp.com/docs/en/data-sheet/SC18IS602B.pdf
the data buffer is up to 200 bytes deep _without_ accounting for the
Function ID byte.

However, in sc18is602_txrx(), the driver keeps the Function ID as part
of the buffer, and increments hw->tlen from 0 to 1. Combined with the
check in sc18is602_check_transfer, this prevents us from issuing a
transfer that has exactly 200 bytes in size, but only 199.

Adjust the check function to reflect that the Function ID is not part of
the 200 byte deep data buffer.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 297c512069a5..37871edc7962 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -174,7 +174,7 @@ static int sc18is602_setup_transfer(struct sc18is602 *hw, u32 hz, u8 mode)
 static int sc18is602_check_transfer(struct spi_device *spi,
 				    struct spi_transfer *t, int tlen)
 {
-	if (t && t->len + tlen > SC18IS602_BUFSIZ)
+	if (t && t->len + tlen > SC18IS602_BUFSIZ + 1)
 		return -EINVAL;
 
 	return 0;
-- 
2.25.1

