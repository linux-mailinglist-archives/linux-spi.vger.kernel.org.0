Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729AC1E8831
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 21:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2TwZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgE2TwZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 15:52:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067FDC03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:52:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so3396004qkg.3
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXT8rO5H77IwQ11HLXnr8hHAlk0Rk72jIlER0CU2kIM=;
        b=k+MoPpDpNzjxd5awilNKhNHNb6rSV5MVo636orWUMVh+Y32LM7DA5FocymVz407tQQ
         seHH7hJaR5Qw24+z5FpzefPpTk3Zfg7EoZgrNg0bS6KAZUiUxiVbgW1N0Nqt8Xx524ah
         aslFBpAD+TarOxd3n6oYMN2Jnz6ZlkgXzzYM+bBdk5h6FPQRh3B46Q5f0l9OtzVdgZme
         RsvaXkONkXb1WuHK5DicJCkJQ8rCoqr9VnQvkNdb2R33+evcK/6tJVwEqlF6vYguAeTE
         0VGHpNJwDwdTZTC0oy1zA3T3ilRcbOivLYLe67JqxAm9HhRjiVoiXsc/yaK87CS7lYev
         bkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXT8rO5H77IwQ11HLXnr8hHAlk0Rk72jIlER0CU2kIM=;
        b=WphsFb1zep3MvtGGeVUX72H12I3RoeIc8mgjluYUu5kG0kfZkhgVQsgPNKvERSMx4I
         e7Sx0cE9CVEICDrs3RAu6kuaE9BxkuxqiAtvTgoldGDPa9zhiDQ22dG8SjOdDnah1H8k
         d6rg3F3qozn8vHy5mGFTLh2gOu4rh1ToBEKXzJ478rnFr5emi2FwkYxZ8d1o/Qv4l0if
         hvgtRCs8hzotMJyR+C+0wRH1z6XZqJtvnV9Z8e0048w61CnpidT1oKdrFbQPtFva2kMi
         M8I2wHSac71QoXzcCXfck5MjJjUfXcYHVWT6GIWjVdgQPesoGBOSq5Igy6yAAg5nD0RA
         Vr+Q==
X-Gm-Message-State: AOAM533aJ26Jyk79+R3llOo98q1NGQYt5euHi/t/xu7Sx2WWLGZka0X3
        X409YJAxX0Kc3Mf5BUFhGUJNGpqAMPk=
X-Google-Smtp-Source: ABdhPJxOXAiVKp6hbpLQo3pnFy82jR7ML5o0l2IcrS+xIAiirKzQXiYh0B4BRPTAJXD+t1CDiNFhJw==
X-Received: by 2002:a37:b57:: with SMTP id 84mr9097364qkl.364.1590781943556;
        Fri, 29 May 2020 12:52:23 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id y66sm8337040qka.24.2020.05.29.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:52:22 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] spi: spi-fsl-dspi: fix native data copy
Date:   Fri, 29 May 2020 21:57:56 +0200
Message-Id: <20200529195756.184677-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ColdFire is a big-endian cpu with a big-endian dspi hw module,
so, it uses native access, but memcpy breaks the endianness.

So, if i understand properly, by native copy we would mean
be(cpu)->be(dspi) or le(cpu)->le(dspi) accesses, so my fix
shouldn't break anything, but i couldn't test it on LS family,
so every test is really appreciated.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 50e41f66a2d7..2e9f9adc5900 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -246,13 +246,33 @@ struct fsl_dspi {
 
 static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
-	memcpy(txdata, dspi->tx, dspi->oper_word_size);
+	switch (dspi->oper_word_size) {
+	case 1:
+		*txdata = *(u8 *)dspi->tx;
+		break;
+	case 2:
+		*txdata = *(u16 *)dspi->tx;
+		break;
+	case 4:
+		*txdata = *(u32 *)dspi->tx;
+		break;
+	}
 	dspi->tx += dspi->oper_word_size;
 }
 
 static void dspi_native_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
 {
-	memcpy(dspi->rx, &rxdata, dspi->oper_word_size);
+	switch (dspi->oper_word_size) {
+	case 1:
+		*(u8 *)dspi->rx = rxdata;
+		break;
+	case 2:
+		*(u16 *)dspi->rx = rxdata;
+		break;
+	case 4:
+		*(u32 *)dspi->rx = rxdata;
+		break;
+	}
 	dspi->rx += dspi->oper_word_size;
 }
 
-- 
2.26.2

