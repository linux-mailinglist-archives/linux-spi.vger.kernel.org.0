Return-Path: <linux-spi+bounces-9025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29BAAF7232
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4305F3B7710
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7A2E62A4;
	Thu,  3 Jul 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NWaPrfeM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60C2E49A3
	for <linux-spi@vger.kernel.org>; Thu,  3 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542074; cv=none; b=puelApjV9sHPqwNqdpdbEJdS24WKJkOabHlwtxutfA65VqlAWZDa3hOWBk/cPofDGL/qGZidy1lp/IAzjhKWdLl7WesSOjWTOERnDgiDm/fWtWicxVYsf21hTbxkQv6qKsnhhlU0BN45fTV0OLiK/tOvkWEYVqjqPCzzNGYfeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542074; c=relaxed/simple;
	bh=X1Oyr9vFTxLX3A2BuvfxXazNPEQYM31gD4YJTucU+Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLa1EVPzPzIDlfZ6YE5nzrkO85/Llykwz79hfXIhmhFFgXfBxAHlSn4HV7kEOV1vv8IhtDBQpag6i2ue/NXI6JdsUWCffXREghDYZWq6Q77KYXm2BRgi5UDXUWzEVlb17GXCe6pmaI29BWyYrAAUgGrJ8/8Hgu0fsHnowpeKVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NWaPrfeM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so1203134966b.2
        for <linux-spi@vger.kernel.org>; Thu, 03 Jul 2025 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751542070; x=1752146870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=NWaPrfeMNu6lzcL6odLfZsNPLmYpVaPVg30El2x0eGSaccOcXkGqo1EdMEBm1zC5GI
         UWaqm6d88selempizMTQdl90luJ/o+HoxhIRBcnWkeaVoOAWZ5OPgM2yecuG97Pr3HJk
         qS96Ys4Ra3HzmYQX/1A68bF3kcz0O6hpK2bGHsmMkmPhgrbC18rNVDAvvopGIFVsu/1D
         LZHIOwrOvbHodHlqKABBqMCqB/qUr4Ndf25U9wWhGVeY6W8qK6Zb1JmladgI6A9GLm8M
         hHIviZwE4iTBFIbTFTNuii2SNcEwqd8Jb01yMnVWxLifPGewD6MrP5QTZ1wX5YqjBED6
         GrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542070; x=1752146870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTGALKZoVheypQ1QT5i2+A3Y7/0VfJ5YTQvSLmEPSq0=;
        b=dwrT/ysi2/VZzTLq2Xx0c3XBGzeLBFvzjphsVU4by7H8OdAadYaS3WXztSqXIS8p3d
         ZpSsjs58L7HiBgngZNFFKrk4uy5MSEGxMt7hkfvlNle3cEWJT0I1J20sBi1hvedAyqxp
         GTDVZjFDU0uXqeWpLkMII26Y+Kk6OnpS5eNBAQjVALyPuiXjVnHRn1imRpYpcbOGvW36
         47Xi8wfEkBbH6P5+7vStqm+QjzMaPUFx+NVkt6IahIl5xq7bptxmWU7d+x+dKUdssqct
         8tO6BnYqT5ivBPnugjREr7n1W4lWrR8V1/xw765+WYO3vCAMIId91eDlv5KXEPMTJE+2
         sarg==
X-Forwarded-Encrypted: i=1; AJvYcCW1kPUz2aLqulvvWnpa5FhZg/4ZoVCneVorPBMoK+svcCIBOUa7k9ZI6hDapIyHOKNEps97Qajmcs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+u06/Q8rP2yYSH6vTWXPRi6KX53qZUFwnMFK3harL3F7i3ez
	ruPcDU+8JOuTVFBJIPmBD/N9zPkroZosTbnVb41PvPGfjnOnfVvlXRqp6y8fUEkPtq8=
X-Gm-Gg: ASbGncuuQRE5sj9Ji3FEKdXfxNMN/43x79Qul1VQd9dhUY2wGsPo3mzTxVlfZyodFIr
	jbqMXOMTFVHwGA5m4L/w4mGQECn2JiA/1ByOWay18vBPUQmZKiQhXEjo3x8y1utQJryXfKXvUzz
	6jBdIN4CWO82Vj+J/luVgUZIRysjBiNQHOFmDJ2cn/sGWdHzWZPOVt8S44B6W1W8DWgYBVemboc
	FWBXvn/C2k3DHaCkOAENw4cGF6sQb+mT9Gv/zOKJc0twYFvBjL2IU0vGWiqbBAbaEgErzVyuBU0
	DzD6lRbgRNK/heAKOsUmWfX6J4DerCO7dwlR+OsxK1RXtdeGosre3cjM+f0FNaUnmWXvPjBFnDa
	SiH2PIQadCppOYhQ=
X-Google-Smtp-Source: AGHT+IFkYQwbGErnKmAXbXp56IWazGm9DvxurIRdNCD1GAvBXxqd+zW8SE1e2XD1WudHDmEIZdYoAw==
X-Received: by 2002:a17:907:1ca7:b0:ae3:6b52:f7dd with SMTP id a640c23a62f3a-ae3c2d69de4mr612468566b.46.1751542069470;
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a75fsm1247016966b.67.2025.07.03.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:27:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	robh@kernel.org,
	jirislaby@kernel.org,
	saravanak@google.com,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 2/3] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  3 Jul 2025 14:27:07 +0300
Message-ID: <20250703112708.1621607-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The dev_pm_domain_attach() function is typically used in bus code alongside
dev_pm_domain_detach(), often following patterns like:

static int bus_probe(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);
    int ret;

    // ...

    ret = dev_pm_domain_attach(_dev, true);
    if (ret)
        return ret;

    if (drv->probe)
        ret = drv->probe(dev);

    // ...
}

static void bus_remove(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);

    if (drv->remove)
        drv->remove(dev);
    dev_pm_domain_detach(_dev);
}

When the driver's probe function uses devres-managed resources that depend
on the power domain state, those resources are released later during
device_unbind_cleanup().

Releasing devres-managed resources that depend on the power domain state
after detaching the device from its PM domain can cause failures.

For example, if the driver uses devm_pm_runtime_enable() in its probe
function, and the device's clocks are managed by the PM domain, then
during removal the runtime PM is disabled in device_unbind_cleanup() after
the clocks have been removed from the PM domain. It may happen that the
devm_pm_runtime_enable() action causes the device to be runtime-resumed.
If the driver specific runtime PM APIs access registers directly, this
will lead to accessing device registers without clocks being enabled.
Similar issues may occur with other devres actions that access device
registers.

Add detach_power_off member to struct dev_pm_info, to be used later in
device_unbind_cleanup() as the power_off argument for
dev_pm_domain_detach(). This is a preparatory step toward removing
dev_pm_domain_detach() calls from bus remove functions. Since the current
PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
already set dev->pm_domain = NULL, there should be no issues with bus
drivers that still call dev_pm_domain_detach() in their remove functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- added flags argument to dev_pm_domain_attach_attach()
- added description for struct dev_pm_info::detach_power_off;
  @Rafael: I kept the detach_power_off flag outside of CONFIG_PM as it
  is used unconditionally in device_unbind_cleanup()

Changes in v4:
- save dev->power.detach_power_off in dev_pm_domain_attach() and use
  it in device_unbind_cleanup() when detaching
- adjusted patch description

Changes in v3:
- dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
  and use a single function devm_pm_domain_detach()

Changes in v2:
- none; this patch is new

 drivers/base/dd.c           | 2 ++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..13ab98e033ea 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index fecb85fa85ac..6ecf9ce4a4e6 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, u32 flags)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..be824dfc8577 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -720,6 +720,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


