Return-Path: <linux-spi+bounces-10260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62AB98AB5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CB18868DF
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CF2C326D;
	Wed, 24 Sep 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAbtFB1I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE32C026E;
	Wed, 24 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699994; cv=none; b=Pu/3Qpic5o8GzatG/bJ0EjLoZlIKS6lFvPaWjLUGnRBskI8WF121CDmohR9xTNjHl16lYwHAR1JT9kh0lZtlB+F15P10qQ7eSFruWX77bhaq3gqB+Q34Gb6y3GzDNS4o1P/FG+lY6xYHmXeWteCkAUY7WOvrOF23FD6Lb4xSGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699994; c=relaxed/simple;
	bh=m3EgVXjs4Dtr5qYQxifEIBFpl8KtZPRL3QVvAO6C2R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7OmRj+YrAZX7uP3/39GAt64RO0uYdobOwRc3hVN3PXZ0pgCJzdWkGH8dmhr0t2/w4YoRRb+7NaLQiHag7OXIoa7rnCfWaCGOES/rzbIM9AuzDkKBKSz0YgVorXnTk8PfKxFa5EnbR4sjrD6JIqrWUgJuW563xBI47VwrjaJ+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAbtFB1I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699992; x=1790235992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3EgVXjs4Dtr5qYQxifEIBFpl8KtZPRL3QVvAO6C2R8=;
  b=MAbtFB1IJr5uztp0GXxymYr+b9/iDbRnW6dVOcXLwd6NIoZYusILazl/
   339DpffhB96z+hODorOhK6GulS/5AdbX4gha4eBeTvyrBDv7g22bI8+KH
   1c4ws2Zy2anItxrwvOYquTCOjBmALmKcV+0lbKw9wf9sbfx/gpNF5oEWi
   1wrVxwKI2slsci4yVpKMVUz5Tl41tEiLGuz2mJxd8q8kPnlUuJ2cqecWM
   zlsmw+3VSHHfGx43CO4SHzYE9jG0H8GsNszaN6U/TQ9ibZaGOrwovJD3c
   nj8tJFCIRgBd26cqbJsVS1afO7BkyKoX3pKS/a+EDBvhB0yuFLy2kdWHB
   w==;
X-CSE-ConnectionGUID: ZhyUr+wYT62MBYmwqWQjfg==
X-CSE-MsgGUID: 23Rlw6bITlSZMNpBCf06hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101985"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: sc7S38WfRLCdn03e2z0hOA==
X-CSE-MsgGUID: VjiWZhgESNCz0S79ET0sfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668543"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B7551121F24;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Ik-30dE;
	Wed, 24 Sep 2025 10:46:02 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-spi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 13/16] leds: Use fwnode_for_each_child_node() instead
Date: Wed, 24 Sep 2025 10:45:59 +0300
Message-ID: <20250924074602.266292-14-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-max5970.c     | 2 +-
 drivers/leds/leds-max77705.c    | 2 +-
 drivers/leds/rgb/leds-ktd202x.c | 4 ++--
 drivers/leds/rgb/leds-ncp5623.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
index 285074c53b23..a1e91a06249c 100644
--- a/drivers/leds/leds-max5970.c
+++ b/drivers/leds/leds-max5970.c
@@ -60,7 +60,7 @@ static int max5970_led_probe(struct platform_device *pdev)
 	if (!led_node)
 		return -ENODEV;
 
-	fwnode_for_each_available_child_node(led_node, child) {
+	fwnode_for_each_child_node(led_node, child) {
 		u32 reg;
 
 		if (fwnode_property_read_u32(child, "reg", &reg))
diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
index b7403b3fcf5e..1e2054c1bf80 100644
--- a/drivers/leds/leds-max77705.c
+++ b/drivers/leds/leds-max77705.c
@@ -191,7 +191,7 @@ static int max77705_add_led(struct device *dev, struct regmap *regmap, struct fw
 		cdev->brightness_set_blocking = max77705_led_brightness_set_multi;
 		cdev->blink_set = max77705_rgb_blink;
 
-		fwnode_for_each_available_child_node(np, child) {
+		fwnode_for_each_child_node(np, child) {
 			ret = max77705_parse_subled(dev, child, &info[i]);
 			if (ret < 0)
 				return ret;
diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 04e62faa3a00..e4f0f25a5e45 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -391,7 +391,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
 	int i = 0;
 
 	num_channels = 0;
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		num_channels++;
 
 	if (!num_channels || num_channels > chip->num_leds)
@@ -401,7 +401,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
 	if (!info)
 		return -ENOMEM;
 
-	fwnode_for_each_available_child_node(fwnode, child) {
+	fwnode_for_each_child_node(fwnode, child) {
 		u32 mono_color;
 		u32 reg;
 		int ret;
diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
index 7c7d44623a9e..85d6be6fff2b 100644
--- a/drivers/leds/rgb/leds-ncp5623.c
+++ b/drivers/leds/rgb/leds-ncp5623.c
@@ -180,7 +180,7 @@ static int ncp5623_probe(struct i2c_client *client)
 		goto release_mc_node;
 	}
 
-	fwnode_for_each_available_child_node(mc_node, led_node) {
+	fwnode_for_each_child_node(mc_node, led_node) {
 		ret = fwnode_property_read_u32(led_node, "color", &color_index);
 		if (ret)
 			goto release_led_node;
-- 
2.47.3


