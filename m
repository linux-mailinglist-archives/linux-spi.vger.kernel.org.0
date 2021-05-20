Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFA38AFBC
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhETNOX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbhETNOW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 May 2021 09:14:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BFC061574
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:13:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w12so11586617edx.1
        for <linux-spi@vger.kernel.org>; Thu, 20 May 2021 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfeZuj9x+F+IOQGvDII5Rw/+DdFZ2cFpL7ax2dtu5+w=;
        b=Gp/cn9U/FqapfBfEDzGYl61NRekjvJMrQTdjzecrmxMl5qWD4GgWsEYyX1pHTI9axq
         pz9JNuLxspYOQHJD62hX03Z3ggy587vNHqBogMNc0eV1wK/6sOvOFE1mH6PfMlmEHj/E
         opndfQPJ9/icCMKKIKrXpakx0xZF+V7WwkoPjNsunP3Z2e2mzIpFvvRfHEf3CA57h35L
         l5FcDzg3E+EPcwWgubd/nKu0OWQWEBnysmKUIUAMAq/UuV+j3lOth9aPKjZqF+LDo6nZ
         2GJDGUg16M3ASEhSZkyUY/PxhvDfOquEbUaLiVXIeShOG/S3oN1XARQxHjwU32+BROQT
         uZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfeZuj9x+F+IOQGvDII5Rw/+DdFZ2cFpL7ax2dtu5+w=;
        b=jJFPtrfRo1MHQ3EqoLqztfuMlY49KZYUvyYCEKKtxvTVLGgBx4S8GpXM130LM0rXAo
         cZIFWKuq8BLKTtynUub76w/7fNI8Hjh2OUBKN2iIJHcMqNF7VY6zO5hMYu9Iew+NJcHA
         mL382brLtUai6VZ/dh3fr6VMzQcib1n+S0p9PGUoEDXhSuiv2e8ApYC+/BqmzEXN09ZY
         EXgWTSFTJ2j8DdH1q7XNuMZhpJ8WTOk+iK/PIrszZBkfoVc1zhkhaF/mDSNJKVqwZJz0
         tr0nGJ5quT6IpeH+7PSzFs5GHQRlyvcDZvCMCAa6GcPLOoDi7iqRMYvmOmlocZS46S3v
         XUBg==
X-Gm-Message-State: AOAM533b5cNFXu4llvtx2nk+55HTR2SuVPHT8qTRiu2DC88E5p0UeGmz
        JrGPVp6yoDsHolYO0yA6qdY=
X-Google-Smtp-Source: ABdhPJyxZ3gAWRn8nfm3SbTUL3Qzv99dr45kRIUQXPwq4WmCAoTfBfkcwFU2stRYygjAfG/eE1OkeQ==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr5057359edv.174.1621516379869;
        Thu, 20 May 2021 06:12:59 -0700 (PDT)
Received: from localhost.localdomain ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id gt12sm1362505ejb.60.2021.05.20.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:12:59 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v1 2/2] spi: sc18is602: implement .max_{transfer,message}_size() for the controller
Date:   Thu, 20 May 2021 16:12:38 +0300
Message-Id: <20210520131238.2903024-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520131238.2903024-1-olteanv@gmail.com>
References: <20210520131238.2903024-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Allow SPI peripherals attached to this controller to know what is the
maximum transfer size and message size, so they can limit their transfer
lengths properly in case they are otherwise capable of larger transfer
sizes. For the sc18is602, this is 200 bytes in both cases, since as far
as I understand, it isn't possible to tell the controller to keep the
chip select asserted after the STOP command is sent.

The controller can support SPI messages larger than 200 bytes if
cs_change is set for individual transfers such that the portions with
chip select asserted are never longer than 200 bytes. What is not
supported is just SPI messages with a continuous chip select larger than
200. I don't think it is possible to express this using the current API,
so drivers which do send SPI messages with cs_change can safely just
look at the max_transfer_size limit.

An example of user for this is sja1105_xfer() in
drivers/net/dsa/sja1105/sja1105_spi.c which sends by default 64 * 4 =
256 byte transfers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-sc18is602.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 37871edc7962..5d27ee482237 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -219,6 +219,11 @@ static int sc18is602_transfer_one(struct spi_master *master,
 	return status;
 }
 
+static size_t sc18is602_max_transfer_size(struct spi_device *spi)
+{
+	return SC18IS602_BUFSIZ;
+}
+
 static int sc18is602_setup(struct spi_device *spi)
 {
 	struct sc18is602 *hw = spi_master_get_devdata(spi->master);
@@ -293,6 +298,8 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->setup = sc18is602_setup;
 	master->transfer_one_message = sc18is602_transfer_one;
+	master->max_transfer_size = sc18is602_max_transfer_size;
+	master->max_message_size = sc18is602_max_transfer_size;
 	master->dev.of_node = np;
 	master->min_speed_hz = hw->freq / 128;
 	master->max_speed_hz = hw->freq / 4;
-- 
2.25.1

