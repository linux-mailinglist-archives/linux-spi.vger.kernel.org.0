Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C183171
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCLNbi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:31:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLNbh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so493588wrw.7
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQB/nJ2X838Fvt+sBkmGr/0pMCoouvYo1EdeUXM4YMQ=;
        b=BJ0XuBYV3ToSPW3UIl6Isc2lumsrYzXzC9pIKP6HzoLx2m5H8VgaPnkaYEyU3nSSyY
         1tLzCAypjVjCczuqqKDKV1kSM0jlkColhbhQeyFQVhbrpWHVd+cqIdpfBucm5Cs8CUNT
         g2JsfKMI1p2KNINJQGW/uTtMsJczcoyPXXZnlpjb8lmdv/EKBNzm0oLEWDR+wc3cC7Qf
         DMCctXTjXci5kB54gBeQKBFgYHiFdJuJ8DwI2USTDOz+pcXtLVEBQNuo9vJANXAlIU0c
         /cnYnC4QN9G/AkoiOE6XME3Ja/GQJj1cvbdw9h8QOh351jbLfIus+wLy4M2iFBemZPwy
         BIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQB/nJ2X838Fvt+sBkmGr/0pMCoouvYo1EdeUXM4YMQ=;
        b=RjUSrusjL/hzXVxUgyCgRdzQ3Rrkp5loVT+b1mFlASqlhWm3hRLTGXi7612Kcm6hU9
         8bCtZrctICDcLvArKR5EZkRv6i7XSxPsxowXmWVEeZjClKz6t9Xd5xhB0DzUxNZXnqpq
         9+W5/juUbJ4QUU4tyRu2WRVAgJ3CxBuzJqcp9y0vH5ctbhwa8q4JIii+oi5KepIG5upf
         9Ma2j6270FJkkvFe1uGGtfcxWZ8lrLIaWf1j+SIgPaiAhiUMezX05U4TDz4zBuETeM88
         vtbWQK0DoJfHkp986Db4lWUS9VVhXutroulh66FxVCPUBnXRct0CghrRSYFkg9fNsTuP
         HFUQ==
X-Gm-Message-State: ANhLgQ0z5WJAPv7GSnyPFn1n01zLU6Jd9Z9v7AHLSq/nCGQ+8obj+17X
        Aw6rQezko+DWlEUtEMd0eZIBeA==
X-Google-Smtp-Source: ADFU+vttYTaI+DCiNmB1UvQy1EL7nMlpTXWyEiRnY5WHDphDcEObnDSPJFvd3uSrVxGbrKBpFiiYCQ==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr101991wru.137.1584019895265;
        Thu, 12 Mar 2020 06:31:35 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] spi: meson-spicc: remove unused variables
Date:   Thu, 12 Mar 2020 14:31:23 +0100
Message-Id: <20200312133131.26430-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove unused variables from spicc data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f5680fe2568..8425e5ae1273 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -130,9 +130,7 @@ struct meson_spicc_device {
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
 	unsigned long			tx_remain;
-	unsigned long			txb_remain;
 	unsigned long			rx_remain;
-	unsigned long			rxb_remain;
 	unsigned long			xfer_remain;
 	bool				is_burst_end;
 	bool				is_last_burst;
-- 
2.22.0

