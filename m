Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8154A103C
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2019 06:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfH2EUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Aug 2019 00:20:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35691 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfH2EUr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Aug 2019 00:20:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so970514plb.2
        for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2019 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qQI5iJC9ehaYt+kRey+tPIwzQxEitpVjxbpR7mvkHRQ=;
        b=RqZ3AJJ+5jSfK0VrydP0ijjVTMsqIdOjiqw6T9p6jny4M01N3lT8xm4rJrkhMpeJ6K
         8FPa6Y5Iyrt8EEVuc+Svsn+U0NCMwzfNvDeEvPvPe/RoTy3o3hAH1qmihyQG8dn1Ia//
         YUdZTUilVu3q7hCuB6iWkRn93U/GwNuuOXQ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qQI5iJC9ehaYt+kRey+tPIwzQxEitpVjxbpR7mvkHRQ=;
        b=E0d23hR/WDfOJkL2fhkmEdh6elk58G15oPfs/RuBy2JYXseE4bdZlbdj5+qWyoXR48
         7wA3ZzjUOHVkNi/acnIfubuvTgMjFvlUp+eMaDeG4CNo8SOHBlBvDTs+obqTkKp0KVT2
         2o85JFIAoxKhFWSOGSwo9bEFJaBYcm4YSqIS8T4bu0eA2Z2WUaPAGC+maCl2QPhfBl2j
         9s12o19HDyzUDqlsB/pa8BEX/f4rQ0IxRrsWyNDKQ745vLC6XRZCwMyOdDehKHtTxBRN
         I9NaODovp3bhG1WCY+S991wtWxysLSapBdKK2wJAUcGq0XyxmV7NlvZr+aKu5wWrhgjQ
         yXjw==
X-Gm-Message-State: APjAAAV9nm/8to4oK3eJ3Wym+ROwtdxxuU56ZvjSiD9wgAIFYXl9Rs/T
        pUWe7t+aJWIBf4I/H2iiUYAIyw==
X-Google-Smtp-Source: APXvYqwlUu4LUSIqSJrsGi0ecG4deNc5qSiF+a7rYr9acICsCkxuqeztmmPDOUjSVLbfOu3Oi7W0MA==
X-Received: by 2002:a17:902:fa5:: with SMTP id 34mr7897357plz.285.1567052446342;
        Wed, 28 Aug 2019 21:20:46 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n24sm821653pjq.21.2019.08.28.21.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 21:20:45 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Thu, 29 Aug 2019 09:46:13 +0530
Message-Id: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Changes from V1:
 - Address code review comment from Mark Brown.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..46a811a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
1.9.1

