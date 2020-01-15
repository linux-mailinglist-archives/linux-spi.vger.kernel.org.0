Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A813BD0D
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAOKHM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 05:07:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgAOKHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 05:07:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so15116250wrn.7
        for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2020 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWhhUMaBzzeiUoeBzfyQmq6oaW1O0Vgm0QQMX6SxfPY=;
        b=1McxP66alkCjzO5JYFeuI37lmMwZaWL9vcFHI64lKojl955VriJJQqmIEHZ4ZO4WFq
         i2q6sC4rTE0aU1EJWbO0FfcjjNSh3Y6PZZUrdMUs4Sl9wEFFeftUhG6ZEqeMk2vspaMC
         AFsg8aUr1rmy7Zlrn8GQyIHaiUAnFgNWw99EpAv5N4MElgZ5debCE/e6cNKNexJUfPbO
         gEjlZt92h9/O5HuOPSYwJZ29cEjTGGRh4zyh36THCsDxuN9JGz75AHY45pkBLKnGKh3P
         5PvgXBsBcC2aL4QNKnS3YKVCgz66l0oMmuIkedeG8lB4ANTV1RiTojJOLbnNqrVexVqp
         6woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWhhUMaBzzeiUoeBzfyQmq6oaW1O0Vgm0QQMX6SxfPY=;
        b=AFJ34rV7LtUS9qs7vI20TO+A/r9B4RHDX1qMTN4iYgF0vbzplSRYV6pYN40+zRf3hK
         M3M9ub2iMC/ETohevV74EcUvIH2bE1V4glHR2Z01sWLQdwdoBFjL0w2P837dk0Thdp/7
         DwYGphLoqMQ2BJ45kFLq7LP/Wy/RCzIzsZSJMQtds47LgCvK5X9JHJdFI4B/V7I3KEm5
         aPcIoMDvD4TpcKvH+DwyhjHx960Tw7KTbeynyuQ3nKglHkUaNrbIgoJyTM0hB2NDasiO
         RP3OfznFb/+nNhvQtoxzeHhUqKY2cr3FjFcpB2EYAJv2pFQnAdL3OiStJO8s/lMnd+SP
         iT1A==
X-Gm-Message-State: APjAAAVRKT7BYyU+WUPm1QAcwJ9IeZ6kmD53T2p6eEa/KlWqvnWjDxEe
        IKVEY6MHgbFU8dORM2ksn61MTw==
X-Google-Smtp-Source: APXvYqwvRw6+JyKrfxzudEndmpvvsCu2P+4BpTxWFC16jDeI6xo62qmoYW0SNy01PWc2bdTZ/+vujA==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr30843740wrm.394.1579082830466;
        Wed, 15 Jan 2020 02:07:10 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id p7sm21948775wmp.31.2020.01.15.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 02:07:09 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, linux-omap@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] spi: spi-ti-qspi: fix warning
Date:   Wed, 15 Jan 2020 11:07:00 +0100
Message-Id: <20200115100700.3357-1-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

drivers/spi/spi-ti-qspi.c: In function ‘ti_qspi_start_transfer_one’:
drivers/spi/spi-ti-qspi.c:392:8: warning: ‘rx_wlen’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  392 |     if (rx_wlen >= 32)
      |        ^
drivers/spi/spi-ti-qspi.c:318:12: note: ‘rx_wlen’ was declared here
  318 |  u8 rxlen, rx_wlen;
      |            ^~~~~~~

The warning is a false positive; it is not thrown by all compiler versions, e.g.
Red Hat Cross 9.2.1-1 but not Linaro GCC 7.5-2019.12.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 858fda8ac73e..366a3e5cca6b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -332,6 +332,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 		break;
 	}
 	wlen = t->bits_per_word >> 3;	/* in bytes */
+	rx_wlen = wlen;
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
-- 
2.24.1

