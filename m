Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E952990B09
	for <lists+linux-spi@lfdr.de>; Sat, 17 Aug 2019 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfHPWd4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Aug 2019 18:33:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38707 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfHPWd4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Aug 2019 18:33:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so2997733plt.5
        for <linux-spi@vger.kernel.org>; Fri, 16 Aug 2019 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVHqpfahoARpAJG52ZuuoX9QL0nU1VIcF3Aae9cHyHs=;
        b=R866kRE0Sa8owq1xi3wWL7ytKHBpsBHh4JlmJv7gwsms4li1YAT19D8imu0NAthKPz
         xo7+FJ8wNuT714cRin4HXm+nFumirDXKD2uUiNLdDE/ZfKRHD+XH/dKt19OqpNCraFgu
         5rHjzrdBn/Aoiy6IonqE5/ORdEWlT+BWaCa2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVHqpfahoARpAJG52ZuuoX9QL0nU1VIcF3Aae9cHyHs=;
        b=jEZvhBsJg5tqUONf9I4hRiXZr5OTy6JPQkreDsgEsmnxWRuYEKWQ0NnmYIrduynyOA
         Eg5CkZItJSVDAWSNfCQ4oCVKjL8RBHVdQsehu2Sra70jFLw0vpV6Hg+9IQ72xKJTxvYJ
         yh6xbTnNAQcyaSFPxvVzcPKQ1JAPb7geuLG77KCn/Jpr+6I9MnT+uhD7tyt9MLY/KoYm
         QVlSQGh+FuJpO0nmv1XDmJquTm/WHv894WWLsNFY99ldsE/La+JCzs0IZvGFosSERtc+
         UuSrzb5F1WQiV63A930TOFuPY2FrZ00DtWb5vObdX1X04O31nH4kogLnK0XP4SakIZYt
         CJpw==
X-Gm-Message-State: APjAAAXVVvCusE+56jMPXmqz3KKPRSyDjaDoedHVag8j15GTqWpBnKoM
        nyaYfD4UKvfoPVSll6VvN75J+IEAMQ==
X-Google-Smtp-Source: APXvYqwncmolMEMBHR4zAYavy0ufv9ZKuLZ7fURlKVW/6pp2xpXcZco4NI8basuNflcOHLn/PpXYVA==
X-Received: by 2002:a17:902:2ea2:: with SMTP id r31mr11605265plb.200.1565994835260;
        Fri, 16 Aug 2019 15:33:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
        by smtp.gmail.com with ESMTPSA id h17sm7185395pfo.24.2019.08.16.15.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 15:33:54 -0700 (PDT)
From:   Curtis Malainey <cujomalainey@chromium.org>
To:     linux-spi@vger.kernel.org
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: pxa2xx: restore lpss state after resume
Date:   Fri, 16 Aug 2019 15:33:33 -0700
Message-Id: <20190816223333.144924-1-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On broadwell machines it has been observed that the registers do not
maintain their state through a suspend resume cycle. This is given that
after a suspend resume cycle the SW CS bit is no longer set. This can
break reads as CS will now be asserted between transmissions in messages
and therefore reset the slave device unintentionally.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc7ab4b268802..3f313a9755640 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1913,6 +1913,9 @@ static int pxa2xx_spi_resume(struct device *dev)
 			return status;
 	}
 
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_setup(drv_data);
+
 	/* Start the queue running */
 	return spi_controller_resume(drv_data->controller);
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

