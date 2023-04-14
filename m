Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A86E22D1
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDNMFe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDNMFd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:05:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13E13A
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e6-20020a25e706000000b00b7c653a0a4aso11059563ybh.23
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473931; x=1684065931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=MileTBwtlL0qqRT9AiQfm9JMqrnFA9bJsAcMj7ZZ9KppF1hAzoRuBJa+Y6TzrKhNh9
         0zpRMfy7KoXKTtjw/1phr1Ju8Q7MUC3Pv2KXsUmij4naENHQWdy5ESjF2rESYm0/J1nH
         ZnXqByO+tcKc/Uosx35Kpn+fCdC0j9wB2QkGB8bZgQAQQ0gPupXYv3MWdmOAItIRdjlp
         wtWbEs8sADYLMeffdzvE/pty1M/x1pgUZbGEUahJgaG3Q4TzOWLa8UGhJfh4ER628TTZ
         M7K0CE9thwSsjjvv6lkLhAR6VG4lMylReBNHP7mHOm+66jtDweWML0O0f9DBsbI3hIWD
         HkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473931; x=1684065931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=d547h8SzJRpZTEITgNj/MA35W0TF4wVbrS19Q+RbuiTt6/YCFBKLxcXJeNUcJcqmU2
         qj93B4V7309gLz+HHoaDlcdHPxgfQviUdZ+pXM+UuBvFN5urBXnbKiP7GO0G2HTRyOiJ
         AouVL7Y/h+ikILyyj9HH/0dhRsIGU5335mht60mjz3V1snIvN7voz6DaZNbXH1ry0jZK
         VQjlIKxF1QAjr+ATxuiWcjyk9scaA+T36k8m73kEmgzi2tWkEyV6ZBJpVU6HEhOebKNx
         JT7ukkHh41Wz6M7WN/cpPH+xe4UyikdIGg0x0aOzsKb+2Rj0/0bETGD7SaokkSaeVvkt
         C3ag==
X-Gm-Message-State: AAQBX9cXUQnvjfWnGB6nknZiWkFkKofi+7MsKw5EjtFXYh5JaN+hRcLJ
        1R4sRI9KnTD921/9cfmEGUNYmjAm2VRNQQ==
X-Google-Smtp-Source: AKy350a9gF3w+RP8mepYYKXHkZEFXcxJEDXBIq8pWYHsarXhytOBxhA9HNZ+Zy6tUQ/ULgM9WREsIAd858B47g==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:73d1:0:b0:b92:1f57:8d03 with SMTP id
 o200-20020a2573d1000000b00b921f578d03mr355881ybc.9.1681473931261; Fri, 14 Apr
 2023 05:05:31 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:16 +0000
In-Reply-To: <20230414120520.360291-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-2-joychakr@google.com>
Subject: [PATCH v6 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.
Hence, for bits per word values between 17 and 32 n_bytes should be
equal to 4.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..c1b42cb59965 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,16 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.634.g4ca3ef3211-goog

