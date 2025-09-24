Return-Path: <linux-spi+bounces-10253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07445B989FF
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EE41B20EFB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F62289E13;
	Wed, 24 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NL4kY5gb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9C287515;
	Wed, 24 Sep 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699988; cv=none; b=NhKjY29UK90KDP4Uf2SO5Mk3IhyHP1U2UDUZe03+YTUlqouu48omhOcFBO3ySc/sGN6VRn93wv8tixFdrYREhJtc6H+bDyg7Qq3W+DGlJ3A597kPVUygLenlO+8uTGV/x57pVIqKMuABEC6d8OTxL4VfdyP5mI7mFlM20r90Nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699988; c=relaxed/simple;
	bh=/leBFCw4LZOfJtYhFEIL/GjAyRMTnUr/74r6sRTj9lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8BlN/ye1kuBkkEdTwBcDfkEMgSi2i4nf8dNnA5IHoSTw9wjuTOzeeccwCPaD/IhoSJWVLVzB2rZa8/qlSzKdfNPkq2Y/pZqbT/LF5aZNigsZf3chOSeawjqY/aONIeVCAnLLCtdm4PXl9YIJ03hc2XuqFWvgqf1h6OcZ8aIyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NL4kY5gb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699986; x=1790235986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/leBFCw4LZOfJtYhFEIL/GjAyRMTnUr/74r6sRTj9lw=;
  b=NL4kY5gbDsSsuZipuXDi3KerZ7+y44wBcJtbxNsptJq/KP7E9m/JQY+6
   vZwhmh63TFIRm3Ttaz51ODPjtx9dS7ZbzavndbX6pgYSETmcVsyo7fFvM
   /sbsjPEKOY3q2W+ktixklZdmdIzmjd8+Y2dNeb+s8qnXX1kWv2ANijZYY
   H8ZLav+Na7oJuBpAT5qhQ8Umw7Uq7x9px8wsQ6JVBjf9RR23RceQBeR15
   rXjyjba3tQ4yTlEMfWujhAxxPj3Go2oNEkCIqgMq/QOPrvrF6mRQZfxGm
   ANk2mqXxIxnCisjPukGEDBhp5hguTtVOiKdXVaLndxmAqOq/Dt1/JEdKV
   w==;
X-CSE-ConnectionGUID: 3f+EyDJ+TVOSOHSO+XMlDw==
X-CSE-MsgGUID: gcLtTAdvRLy3vFT6iuHFtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101868"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:23 -0700
X-CSE-ConnectionGUID: M1zj3XpKTDyaHMROBz1OuA==
X-CSE-MsgGUID: Bj4xj9R7SeuVCm3d0gjGWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668533"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A6506121EEB;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017IQ-2j6B;
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
Subject: [PATCH v2 09/16] driver core: Use fwnode_for_each_child_node() instead
Date: Wed, 24 Sep 2025 10:45:55 +0300
Message-ID: <20250924074602.266292-10-sakari.ailus@linux.intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..4bffd347e2f9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -185,7 +185,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
 	fwnode_links_purge_consumers(fwnode);
 
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		fw_devlink_purge_absent_suppliers(child);
 }
 EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
@@ -231,7 +231,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
 	__fwnode_links_move_consumers(fwnode, new_sup);
 
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
 }
 
@@ -1318,7 +1318,7 @@ void device_links_driver_bound(struct device *dev)
 
 		guard(mutex)(&fwnode_link_lock);
 
-		fwnode_for_each_available_child_node(dev->fwnode, child)
+		fwnode_for_each_child_node(dev->fwnode, child)
 			__fw_devlink_pickup_dangling_consumers(child,
 							       dev->fwnode);
 		__fw_devlink_link_to_consumers(dev);
@@ -1736,7 +1736,7 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
 
 	fw_devlink_parse_fwnode(fwnode);
 
-	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+	while ((child = fwnode_get_next_child_node(fwnode, child)))
 		fw_devlink_parse_fwtree(child);
 }
 
@@ -2309,7 +2309,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 	 * case where the supplier is added before the consumer's parent device
 	 * (@dev).
 	 */
-	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+	while ((child = fwnode_get_next_child_node(fwnode, child)))
 		__fw_devlink_link_to_suppliers(dev, child);
 }
 
-- 
2.47.3


