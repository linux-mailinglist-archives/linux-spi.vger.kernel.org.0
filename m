Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7AF8846
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 06:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfKLFyT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 00:54:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKLFyS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 00:54:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so8920217plp.2;
        Mon, 11 Nov 2019 21:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfLpTXwmTko+wTungBc02PKeDQN7UmUMa4lSWShWaZw=;
        b=g8smE6MUyrhWi+O5jT2tC9pxowb4qn4mvEpn4T2Ps4ARa51BvJvvwNDVbFfrgzehOE
         dDPjz47NDeo0D25zWiWzlepCPlCt/Edlx+4ls7viapwtvf3VlIk1S8OazqbLpEXmciP6
         lcyqWuX/P3Z4v/irj4tncveAn/kJ87aGMkG5X8HrqFTtdUNYzb3q4KRzWrIoOClj9gkl
         5H2sqPUSww16MOmZ1G2Fldav3orxtwev1eZHxavYd4hoIk9yuPHQ2IiEn6Zq2rqAuODb
         62y35ef5CH39Rg15KuRhuQBzYTBpAVENwxcy3l6+i8oVXGS+kFiSQXkOJHpjNOQdqGol
         v1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfLpTXwmTko+wTungBc02PKeDQN7UmUMa4lSWShWaZw=;
        b=qQPqqw+/Z96OdpX34acRjdUk4g8AzAPCbH8/5oNEhxU46MRKgplH49jweXBxrJn60O
         7nReq7GWdlcEejwxmHisbkWHTqD7amrB7o8ya4OcBKPchEi1hWScEe1N6Rnt7hjSXiXY
         ti0XgR1jL4IWrxHLiyuv6zvgRF7HozVOqHl0HkDzpbpdNrh38mXB4wPrwRxp3YW6Qu97
         xxpRqZFgxRsqSamRjB2HRECYeEGsvnilhquER6h9tu7nDqtmQnmsLjqw+tb9eFHxx+Re
         duIwlMFpJ++BvuOvqDY1wCV0ioNLkw4D1rfEA3DE6s7KDcEuR9n060tVN7J720+W4eLw
         4phQ==
X-Gm-Message-State: APjAAAWoDVAyLwbncrL8zysaVJDBkayRaQkGOzidXVAFjeMvrYXdvhle
        dI+wdcuRGObZuLYfHp8XfVI=
X-Google-Smtp-Source: APXvYqyRtF8pUyuEwxg+/DQ6H/oW0ptK8vemrlPtYyErFrLgoAQb7atWgILkZafNapbyUiYM4fJyrw==
X-Received: by 2002:a17:902:6e02:: with SMTP id u2mr30148678plk.234.1573538057420;
        Mon, 11 Nov 2019 21:54:17 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d139sm23160178pfd.162.2019.11.11.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 21:54:16 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: wire up wakeup-source/wakeirq handling
Date:   Mon, 11 Nov 2019 21:54:11 -0800
Message-Id: <20191112055412.192675-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Many SPI drivers need to configure their devices for waking up the
system. Instead of forcing them to reimplement wakeup handling, let's
mirror what I2C core is doing and handle "wakeup-source" device property
in SPI core.

Also, let's allow naming device's interrupt lines as "irq" and "wakeup"
and automatically configure the right one as wakeirq when device is
supposed to be a wakeup source.

Implementing this is very helpful for drivers that use both I2C and SPI
for transport, such as tsc2004/tsc2005.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 drivers/spi/spi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50769a8475d66..baa7aac300d9f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -22,6 +22,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/export.h>
 #include <linux/sched/rt.h>
@@ -394,13 +395,37 @@ static int spi_drv_probe(struct device *dev)
 		return ret;
 
 	if (dev->of_node) {
-		spi->irq = of_irq_get(dev->of_node, 0);
+		spi->irq = of_irq_get_byname(dev->of_node, "irq");
+		if (spi->irq == -EINVAL || spi->irq == -ENODATA)
+			spi->irq = of_irq_get(dev->of_node, 0);
 		if (spi->irq == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		if (spi->irq < 0)
 			spi->irq = 0;
 	}
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		int wakeirq = -ENOENT;
+
+		if (dev->of_node) {
+			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+			if (wakeirq == -EPROBE_DEFER)
+				return wakeirq;
+		}
+
+		device_init_wakeup(dev, true);
+
+		if (wakeirq > 0 && wakeirq != spi->irq)
+			ret = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
+		else if (spi->irq > 0)
+			ret = dev_pm_set_wake_irq(dev, spi->irq);
+		else
+			ret = 0;
+
+		if (ret)
+			dev_warn(dev, "failed to set up wakeup irq: %d\n", ret);
+	}
+
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret)
 		return ret;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

