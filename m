Return-Path: <linux-spi+bounces-10263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11931B98ADB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0394D4E220B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665822D5954;
	Wed, 24 Sep 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIWEnti9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9E28A704;
	Wed, 24 Sep 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699996; cv=none; b=P/HeOC2oxmusNpUWP/GFJ2tM7+WKXgxVUfJ2K+AqHwIMWZXSTOpfCWEcOY7LA/7b1uOKnkCXxU1y8iSyP7TrTYAU60weMgQQ/+Irkq5QlvlmiS16o8pZoIiMJPaLVpy9jEwyjHvv7ZBV+ypFz/WnYDIgouHu/Et7YMequB90T8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699996; c=relaxed/simple;
	bh=DEsvqN+aBMQ45x0c2XUTSeXzx/ACOxvknwYyxF7Xw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+EMumFjEM0YbWr3jEwAkC0NxG6YnoQ4v/HvnTvWXRMETwHHMYWrPfYb9DFuATWlNbDgfZSIL0xkzvAZ+cqw8GtwNVIGItNab8X9g8Clg02FXcu+gTnhU4n17UUyS1TdUEgglTkhk8riaScXU4d0h+YCwaSIkpnuGuiTav+usH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIWEnti9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699994; x=1790235994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DEsvqN+aBMQ45x0c2XUTSeXzx/ACOxvknwYyxF7Xw/o=;
  b=ZIWEnti9PkxWG5NjanxU9XiSS/C2o4oe8wz7+b3JrQMkRy8iC+EGCavB
   vZ6rChS6yUYXq/D7kR4ci62VA10xVCukycNmuEukInxVRy1EbbF7fnjpT
   M43xWI0lmB/DdXTrdBM9G92Rszq/SdfeUYS9LKhExxysPaX1GxPCuxjEm
   BwpSMrMF9x9HyBaJnllA3WLxHuYHt3cJFpcTw/4+9ncHDP9UGpdU+8H8V
   3yMEpdIGXUzgNSXN50rEHfzDEhqeg5dOAbkkmdVWeSjGX5Uy03ncXj3qI
   ld1/M203tYc9vUrdYEVUy2tQcaWDIWUE8Q+lOL7HSi8By9ipbSwUtlwVH
   Q==;
X-CSE-ConnectionGUID: 4vAcmkrgTFaSz+rHpl9Fdg==
X-CSE-MsgGUID: ACLFPF5oTg+P6NSeO0W4Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61102022"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61102022"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:33 -0700
X-CSE-ConnectionGUID: vj85M55sQOGjQui+XduTvQ==
X-CSE-MsgGUID: jG8ldA/TQO26Wu5fr7J/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668598"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BE3F3121F4D;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Iu-39En;
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
Subject: [PATCH v2 15/16] property: Drop functions operating on "available" child nodes
Date: Wed, 24 Sep 2025 10:46:01 +0300
Message-ID: <20250924074602.266292-16-sakari.ailus@linux.intel.com>
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

fwnode_get_next_available_child_node() and later
fwnode_for_each_available_child_node() were introduced to mirror the OF
interface operating on OF nodes. Now that these two are functionally the
same as the variants without "_available" part, drop the "_available"
variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 30 +-----------------------------
 include/linux/property.h |  6 ------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ff440456af7b..75c3283fb5ca 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -802,35 +802,7 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
- * fwnode_get_next_available_child_node - Return the next available child node handle for a node
- * @fwnode: Firmware node to find the next child node for.
- * @child: Handle to one of the node's child nodes or a %NULL handle.
- *
- * The caller is responsible for calling fwnode_handle_put() on the returned
- * fwnode pointer. Note that this function also puts a reference to @child
- * unconditionally.
- */
-struct fwnode_handle *
-fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
-				     struct fwnode_handle *child)
-{
-	struct fwnode_handle *next_child = child;
-
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
-	do {
-		next_child = fwnode_get_next_child_node(fwnode, next_child);
-		if (!next_child)
-			return NULL;
-	} while (!fwnode_device_is_available(next_child));
-
-	return next_child;
-}
-EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
-
-/**
- * device_get_next_child_node - Return the next available child node handle for a device
+ * device_get_next_child_node - Return the next available child node handle
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a %NULL handle.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 8b8bbbe6b5b7..da6202053862 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -161,8 +161,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
-struct fwnode_handle *fwnode_get_next_available_child_node(
-	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 
 #define fwnode_for_each_child_node(fwnode, child)			\
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
@@ -172,10 +170,6 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	fwnode_for_each_child_node(fwnode, child)			\
 		for_each_if(fwnode_name_eq(child, name))
 
-#define fwnode_for_each_available_child_node(fwnode, child)		       \
-	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
-	     child = fwnode_get_next_available_child_node(fwnode, child))
-
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 
-- 
2.47.3


