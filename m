Return-Path: <linux-spi+bounces-10261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D3B98AC1
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BE71897499
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513352D0C9C;
	Wed, 24 Sep 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dF6r6VkU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D52BE632;
	Wed, 24 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699994; cv=none; b=lAz7+47RzeqmjizUblAlRhD4lc6+Ggps2tETzsqOrelmYtE9JfdjTjQLR2n05lKJz597fD/ytcU1GtPFT1HZJe7LGZKa6fv8RRe27iTfgGURol62iagwb1qoURxJnJ5q9C76kbsELy9/YjT6LWNbN3ks2fNWsWi2wbWD7mKxUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699994; c=relaxed/simple;
	bh=Z7kbp96iiS7jPxB2qIweq0saq/r/Z6ptZfNljAcJzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqkP+ME9f92eeXXU0WVBSf1Er/0M+kWW9PaO7f07RcbquP563CZ+6tuSEeJM7+tF9ShRzrdAzNiLnzEb6Mv4d3nJ3xJwf4JDRL1iSwJsXWN6TwA0dviXNR0I7K7DZ0A90fsQAFlWMHEX9ZB/OHxVDd3SfaEt4DZ5fg8JvWPhmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dF6r6VkU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699991; x=1790235991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7kbp96iiS7jPxB2qIweq0saq/r/Z6ptZfNljAcJzG0=;
  b=dF6r6VkUHC/93mVjElTg8sg/tTFSz5QHa2uYLsnGBlNQ9KmlZaAJA8NJ
   BWMnAu5DXGzSZLHKZi4DFCQhQdxxeUZWiJdNy9MSsACU6zXoEH3Y7qxrt
   vHQQRXwdA3jroyfcqQ3MAiC8keGIkgsokFeF1PnAF3Op+OLFXGiJOStrQ
   2M/Wm1F8QjQ+VWZmJDSZmWSpkGpoq5o7GAd/1/B8XN9w5e4OmwA2rjE01
   XKc7aMrrqokXlOWKiKId2njnXLhbprjxwNQkQziiBKbnIAwF4dGw2QG92
   LS4oIQFSjdOAFHqBfNG0ArpgKOMG/2Jsj+m3ZB3OGskXa/9tZJoiUnQg8
   w==;
X-CSE-ConnectionGUID: 7C5b6ea1RyekuECc7Kb6Kg==
X-CSE-MsgGUID: CeaiMyOWT0aG71hut7YtSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101986"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: eJlUmF9/Qte7PhGtsPvMxQ==
X-CSE-MsgGUID: /p0bHzVmQ5mQK1KNwYzcAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668544"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BAC75121F25;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Ip-35Qt;
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
Subject: [PATCH v2 14/16] leds: Use fwnode_get_next_child_node() instead
Date: Wed, 24 Sep 2025 10:46:00 +0300
Message-ID: <20250924074602.266292-15-sakari.ailus@linux.intel.com>
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

fwnode_get_next_child_node() is now the same as
fwnode_get_next_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants (device_get_next_child_node() in this case).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/flash/leds-rt4505.c   | 2 +-
 drivers/leds/flash/leds-rt8515.c   | 2 +-
 drivers/leds/flash/leds-sgm3140.c  | 3 +--
 drivers/leds/flash/leds-tps6131x.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/flash/leds-rt4505.c b/drivers/leds/flash/leds-rt4505.c
index f16358b8dfc1..18fd5b7e528f 100644
--- a/drivers/leds/flash/leds-rt4505.c
+++ b/drivers/leds/flash/leds-rt4505.c
@@ -365,7 +365,7 @@ static int rt4505_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	child = fwnode_get_next_available_child_node(client->dev.fwnode, NULL);
+	child = device_get_next_child_node(&client->dev, NULL);
 	if (!child) {
 		dev_err(priv->dev, "Failed to get child node\n");
 		return -EINVAL;
diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
index 6af0d2c7fc56..f6b439674c03 100644
--- a/drivers/leds/flash/leds-rt8515.c
+++ b/drivers/leds/flash/leds-rt8515.c
@@ -304,7 +304,7 @@ static int rt8515_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(rt->enable_torch),
 				     "cannot get ENT (enable torch) GPIO\n");
 
-	child = fwnode_get_next_available_child_node(dev->fwnode, NULL);
+	child = device_get_next_child_node(dev, NULL);
 	if (!child) {
 		dev_err(dev,
 			"No fwnode child node found for connected LED.\n");
diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index 3e83200675f2..dc6840357370 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -214,8 +214,7 @@ static int sgm3140_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to request regulator\n");
 
-	child_node = fwnode_get_next_available_child_node(pdev->dev.fwnode,
-							  NULL);
+	child_node = device_get_next_child_node(&pdev->dev, NULL);
 	if (!child_node) {
 		dev_err(&pdev->dev,
 			"No fwnode child node found for connected LED.\n");
diff --git a/drivers/leds/flash/leds-tps6131x.c b/drivers/leds/flash/leds-tps6131x.c
index 6f4d4fd55361..f0f1f2b77d5a 100644
--- a/drivers/leds/flash/leds-tps6131x.c
+++ b/drivers/leds/flash/leds-tps6131x.c
@@ -544,7 +544,7 @@ static int tps6131x_parse_node(struct tps6131x *tps6131x)
 
 	tps6131x->valley_current_limit = device_property_read_bool(dev, "ti,valley-current-limit");
 
-	tps6131x->led_node = fwnode_get_next_available_child_node(dev->fwnode, NULL);
+	tps6131x->led_node = device_get_next_child_node(dev, NULL);
 	if (!tps6131x->led_node) {
 		dev_err(dev, "Missing LED node\n");
 		return -EINVAL;
-- 
2.47.3


