Return-Path: <linux-spi+bounces-380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994B826D6D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jan 2024 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3995AB21A44
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jan 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6622091;
	Mon,  8 Jan 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="NuLkP4Xk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0A25750
	for <linux-spi@vger.kernel.org>; Mon,  8 Jan 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so404707b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jan 2024 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1704715726; x=1705320526; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nhSNer/yVL2skacLugz8NMKxcIl7PuX2VC9t+mugzE=;
        b=NuLkP4Xky7lTFL8ERqiw7ClleT0DOrBKlgFK4Ton8mnIXQuhexKy4kYETnNz9AEY2t
         eOaNZei3GnzWqYMpp2Isx47nnlGr5Jq2Kun6PbUmg/fSTuQCAPV65zLj7zk0ZmVyUVbt
         Ds4QjnM4PmyzEpgcsxMmKBYYiVxXYvYDP4X5ZM+d/zm1NRkBk3Y+GapwrmWBqCUbjaWL
         lnrqVFUetAa9zFFaS4HcDPIJvBqPPyExfcNscm5GekEYT6XVIsqUV68rvw6CRaB8hFa3
         0kwnXwLPXj9Ew038R++CGoX2MyubpZY9hyS/jFC3YxkxOYkETSRn3fT+yPFeXEO5iJ0v
         tHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715726; x=1705320526;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nhSNer/yVL2skacLugz8NMKxcIl7PuX2VC9t+mugzE=;
        b=RiEXWkE8Ce8umtuSr7j6uNqRGvkY89aKXCpILu0MXBUOKmnrIRFpnpZrVElMVqWYeG
         X6lcsmecmhqTyqgd39+RpDXZvA1buM66HToFYB1ucQ6FAZjP4HPZeSdkjit9cx5kFlS6
         vq/LPPTyPwNIQW1iTNM/7T/e6d2aA2Gopl15mQNfSwAPNj1hLLNUWTsVjUEiTcUnVmq7
         zGb/Nmvyk2p7FyTFo3/lDtFFZvTjEg5IVTJ6RfbvnemxaqL7SElK5J7RUHw+mbzeCmkM
         WHRwdACrcLlzIt56//pwEfdbFCDwF8Skp8NLqJj7qtfD7cgSr0nY5hUMXf/H/nKmRkHW
         vqMw==
X-Gm-Message-State: AOJu0YzDg+Ua8PpssYWuGwOmhUTIQa1OjSgWjFbskmJSVD8xa9daPJE0
	+VprTClCYS4HqOIab/bl9JyLcoEGE0twK8EP9qxiwRor5Y7euw==
X-Google-Smtp-Source: AGHT+IGoSAHza6f/gGxUz5CpIyLUVbg/lQJL20KAwRWxJsjEjnYmktGVhaUdgtsbKhHhbOmGjmZD1g==
X-Received: by 2002:aa7:9215:0:b0:6d9:bb52:9977 with SMTP id 21-20020aa79215000000b006d9bb529977mr1033162pfo.11.1704715726415;
        Mon, 08 Jan 2024 04:08:46 -0800 (PST)
Received: from chromeos.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id fb13-20020a056a002d8d00b006d9aa6592d0sm5822588pfb.82.2024.01.08.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:08:45 -0800 (PST)
From: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To: broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Subject: [PATCH] spi: spi-mt65xx: Support sleep pin control
Date: Mon,  8 Jan 2024 20:08:02 +0800
Message-Id: <20240108120802.7601-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Supports configuring sleep pin control during system suspend to prevent
potential power leakage and additional power consumption.

Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
---
 drivers/spi/spi-mt65xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8d5d170d49cc..8d4633b353ee 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/spi-mt65xx.h>
 #include <linux/pm_runtime.h>
@@ -1316,6 +1317,8 @@ static int mtk_spi_suspend(struct device *dev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -1325,6 +1328,8 @@ static int mtk_spi_resume(struct device *dev)
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
+	pinctrl_pm_select_default_state(dev);
+
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
 		if (ret < 0) {
-- 
2.17.1


