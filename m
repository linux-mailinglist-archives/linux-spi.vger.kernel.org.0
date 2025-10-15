Return-Path: <linux-spi+bounces-10636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8487BDCEE4
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 09:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB043188F09D
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732131A7E7;
	Wed, 15 Oct 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ELVreD1t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDD315D47;
	Wed, 15 Oct 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512645; cv=none; b=XLRt7dQr4xNOIDs4y44mg/JSLNAEG5+XQfMpKorhKP48/KlVfl3PqvNsWMMfv0pipWm8uE6w5jyFFbz8OYJbYtUyeU9To2SQwm9vJDPc+YCB64v/ROtMcq87ZI5eP8lkY/xcA4qFk5spBA59e9gqkVwAtvBtz58KSg5btZwUD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512645; c=relaxed/simple;
	bh=v6r3hs1mb66me+cWIfzLa1TK/xr9HX/g04TSkIpx5Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5eHyvUN/TCwMKRFGNOJXD09CFJbFVwZrdJ0FiNe8jz287TY3v6s1L+cDEoazkkDPsyMsIpuVRI4HJO1bJGYD9vefake3KM7T3vRL5lYCtFaCTVg0VkhjTeVzlS+IvQWQ4RL9u6cnqGOG/HGIaP2UR0K37/3S8Ib0OLvMUceGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ELVreD1t; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4D71AC09FAA;
	Wed, 15 Oct 2025 07:17:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B572606FA;
	Wed, 15 Oct 2025 07:17:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2906102F22BE;
	Wed, 15 Oct 2025 09:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760512638; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RYTwgWPJ/+mU0YRT6no/oY8laFth2jeihvKHFCfEfvg=;
	b=ELVreD1t0lBnATGKitGPB0GWBtDZ4eFZf8EexZBFNQxckl3fFduzSHeHZhdMdjBnAyWXp+
	1HT21z4qROCeXn8m90cOZU0SQcNEHHKx7G/L0WEScQMZbfxw1kc3TuyLk/Y5QoLygfHwgi
	OultajfeMi8iVCh6INRcaZcP8IExT9hU+rQ3p4/X1BWi4WJS75TvO4a1f7r8g36IUlXh7i
	Y2cPr4/Muyh0r5b9QPSAa51rW02Kxa9V+3l6uMig8WLebJXQQI8VZFbiy8nJ2RqgG6VYL1
	YnIuwroRj0Kj4s8jt9BTVBHt4eRwSJSAIoRaCmlc2IvjbR8Z2o3frCxre5sEtA==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 06/29] bus: Introduce simple-platorm-bus
Date: Wed, 15 Oct 2025 09:13:53 +0200
Message-ID: <20251015071420.1173068-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015071420.1173068-1-herve.codina@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The simple-pm-bus driver handles several simple busses. When it is used
with busses other than a compatible "simple-pm-bus", it doesn't populate
its child devices during its probe.

This confuses fw_devlink and results in wrong or missing devlinks.

Once a driver is bound to a device and the probe() has been called,
device_links_driver_bound() is called.

This function performs operation based on the following assumption:
    If a child firmware node of the bound device is not added as a
    device, it will never be added.

Among operations done on fw_devlinks of those "never be added" devices,
device_links_driver_bound() changes their supplier.

With devices attached to a simple-bus compatible device, this change
leads to wrong devlinks where supplier of devices points to the device
parent (i.e. simple-bus compatible device) instead of the device itself
(i.e. simple-bus child).

When the device attached to the simple-bus is removed, because devlinks
are not correct, its consumers are not removed first.

In order to have correct devlinks created, make the simple-bus driver
compliant with the devlink assumption and create its child devices
during its probe.

Doing that leads to other issues due to the fact that simple-bus is
closely related to of_platform_populate().

Indeed, of_platform_populate() can probe child devices if a simple-bus
compatible node is detected. This behavior is expected by some drivers
such as some MFD drivers. Those drivers perform some operations in their
probe() but rely on the core (simple-mfd, simple-bus compatible) to
populate child devices [1].

Avoiding recursive probing in of_platform_populate() and let the
simple-bus driver probe its child devices will break some system.

For this reason, keep the current behavior of the simple-bus driver and
of_platform_populate() as they are and introduce simple-platform-bus
driver.

This driver doesn't interfere with of_platform_populate() and populates
child devices during its probe() as expected by fw_devlink.

[1] https://lore.kernel.org/all/20250715095201.1bcb4ab7@bootlin.com/

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/bus/simple-pm-bus.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index d8e029e7e53f..e975685d2b07 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -158,5 +158,42 @@ static struct platform_driver simple_pm_bus_driver = {
 
 module_platform_driver(simple_pm_bus_driver);
 
+static int simple_platform_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (np)
+		of_platform_populate(np, NULL, NULL, dev);
+
+	return 0;
+}
+
+static void simple_platform_bus_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (np)
+		of_platform_depopulate(dev);
+}
+
+static const struct of_device_id simple_platform_bus_of_match[] = {
+	{ .compatible = "simple-platform-bus", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, simple_platform_bus_of_match);
+
+static struct platform_driver simple_platform_bus_driver = {
+	.probe = simple_platform_bus_probe,
+	.remove = simple_platform_bus_remove,
+	.driver = {
+		.name = "simple-platform-bus",
+		.of_match_table = simple_platform_bus_of_match,
+	},
+};
+
+module_platform_driver(simple_platform_bus_driver);
+
 MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
 MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-- 
2.51.0


