Return-Path: <linux-spi+bounces-10251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E23B989D0
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD6D7B13C6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B628643F;
	Wed, 24 Sep 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjR/Z1gT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CA28313B;
	Wed, 24 Sep 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699984; cv=none; b=o5NoIeiokVrs0Byz3SVqbmzZaUZLuFy4lmGLeM5fPtYc+5JlZ68oW63U5nFxtV+Teg3T18qpWDFijCvbt95VNvohAa/fet8vrrmZb7ypbmg94PnbE38B2Yrq8f9GqhawhlPv/pAvGi+gh44XI9RpOeJYWpQW7+Td1f8dAQjMHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699984; c=relaxed/simple;
	bh=9gKh4zZHKRjG5O5xZKeZNVKtn+qWdxGPT4mjimC1a7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD909wt6t52inUMCgmrdXZS13gveTy2n1neIBvpujDdZkxzOmA/lV2746bJNOZV4m40J+SGlgOGwaoyf2MjhQGGzKvTACUDZIWvjeVilXcE24OCi0krDPjZRpbo47cmHhmaHP82tSX/uTjPmd/AjzekUKdsOeoAg2ndE7j8QYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjR/Z1gT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699983; x=1790235983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gKh4zZHKRjG5O5xZKeZNVKtn+qWdxGPT4mjimC1a7Y=;
  b=FjR/Z1gTHo8TVIzyIJsxEvFB8JSEGgabG2CRtYGOl7OUGGpGRlYCzH5t
   WkhwElbOjFfx91+31RwEppx4U+magjJpQjXuLHqBfRWstecORj6iB3wPu
   7dTPpklMgL6NLQCh299dViKbob78ZKMf+0g06VGVMlOkuab5ZOWJA7pIk
   mAcBR4h2ybpjB6rmux14+mvtNJnehmqDKXbik9bNKqiWIxCcs5fwgSdRJ
   YKAT1UjgFvfa58yKrLjk9Il0Qwlf44XVyZoL7vGCpBYM2V+AazxYBeS93
   sz+pog1sX+5ZNWjtYBI0KnI2B1CilHfa/TURebo89vhuG3q96ugH/70rZ
   w==;
X-CSE-ConnectionGUID: AierEKxORdKx0mYNtvHnig==
X-CSE-MsgGUID: DunrCuN6Tpe3K2r+ZfCtCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72346962"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72346962"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:15 -0700
X-CSE-ConnectionGUID: HHoOIoHtTXqPU44JjbpKCg==
X-CSE-MsgGUID: lLct0mbRRc6YVlxCXgiEiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176552709"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:06 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 925E8121ED5;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Hz-2N7c;
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
Subject: [PATCH v2 04/16] ACPI: property: Return present device nodes only on fwnode interface
Date: Wed, 24 Sep 2025 10:45:50 +0300
Message-ID: <20250924074602.266292-5-sakari.ailus@linux.intel.com>
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

fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
nodes and there has been no check these devices are present in the system,
unlike there has been on fwnode OF backend. In order to provide consistent
behaviour towards callers, add a check for device presence by introducing
a new function acpi_get_next_present_subnode(), used as the
get_next_child_node() fwnode operation that also checks device node
presence.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5438592dc136..01f3880ffcce 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1319,6 +1319,26 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+/**
+ * acpi_get_next_present_subnode - Return the next present child node handle for a fwnode
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ * Like acpi_get_next_subnode(), but the device nodes returned by
+ * acpi_get_next_present_subnode() are guaranteed to be present.
+ * Returns: The next sub-node fwnode handle.
+ */
+static struct fwnode_handle *
+acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
+			      struct fwnode_handle *child)
+{
+	do {
+		child = acpi_get_next_subnode(fwnode, child);
+	} while (is_acpi_device_node(child) &&
+		 !acpi_device_is_present(to_acpi_device_node(child)));
+
+	return child;
+}
+
 /**
  * acpi_node_get_parent - Return parent fwnode of this fwnode
  * @fwnode: Firmware node whose parent to get
@@ -1664,7 +1684,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 		.property_read_string_array =				\
 			acpi_fwnode_property_read_string_array,		\
 		.get_parent = acpi_node_get_parent,			\
-		.get_next_child_node = acpi_get_next_subnode,		\
+		.get_next_child_node = acpi_get_next_present_subnode,	\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_name = acpi_fwnode_get_name,			\
 		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
-- 
2.47.3


