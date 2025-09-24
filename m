Return-Path: <linux-spi+bounces-10249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CDB989AE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBA1B2104B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5319F2836BE;
	Wed, 24 Sep 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiunuxVv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830326E717;
	Wed, 24 Sep 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699982; cv=none; b=Fa7aD9GrYAxZihPRjTUs4zEFI0Nnt8F7LwKmNgmbWvJqPcfTT5d4HGdAQSHt7D2tHtTfAk3X9eL99fjhQA08K5zRrA6N+0cuxvJrj/7hreeP1fwPCmpEh+EEov9IcIS1DPfaiGo90GXjaJLGTKVG+5MbD/wPf/a5vN2WSjbjH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699982; c=relaxed/simple;
	bh=VTnJG0rKo/2WpkQDLq4ioVQABdICcc4+Ec4Y9M9EGQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ6tjZjiZwhaSS7CLfQn7dASLhzhLiLAZdLpYr8gqujCl4GZImY0ZSUWIs4G3LZpIfJXf54B2FGnKVz6/sv4l5KwNss1y9jjyN/WQjNPePxGhEd55TIws6Dk6u2/mA+HVbpGHNyKK6CkTc3v4ckqXStiQwp7U4LBDX5LVmlZcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiunuxVv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699980; x=1790235980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VTnJG0rKo/2WpkQDLq4ioVQABdICcc4+Ec4Y9M9EGQc=;
  b=SiunuxVvwIx5wKm6/715I+d/juET58nesC3SpNLDNDaiyd5N3nLx8h8C
   GuA/f/VIY5v269M9jIvrQJmkycbD5iRchqyALEQrdRoWkpcaOTqv8dqkN
   P6wbS1GH2KE9VwMhLqGBYkxEk4GNOD6+7otBrlnNwxIq617hfUE1zC5x4
   MRB2e/e/f64sOdjVtKqz5y11IACVE0bjvqckN2TnPQzaTlk1LMdcVjosY
   DfqYdmMkgVLEn1r0ylJIuWb1kcXyFbCRPCa+797bukhg7QE5NuPRtvdIm
   Vkk7GS9mIGC3dJSnaqtsofDs8kaGf0qhO4H+JlxhaQhLiANqnlyxUz+WF
   Q==;
X-CSE-ConnectionGUID: E3ydl5tZQOq3vjhEC6eD0Q==
X-CSE-MsgGUID: 7YKxFwPoRCuEKidfrExnTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72346942"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72346942"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:14 -0700
X-CSE-ConnectionGUID: JPTGSjhPSfGfYalvmYHYlQ==
X-CSE-MsgGUID: UgSjWPDDRnaNqCy21dnkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176552707"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:05 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8B4371201E6;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Hn-26KI;
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
Subject: [PATCH v2 01/16] ACPI: property: Make acpi_get_next_subnode() static
Date: Wed, 24 Sep 2025 10:45:47 +0300
Message-ID: <20250924074602.266292-2-sakari.ailus@linux.intel.com>
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

acpi_get_next_subnode() is only used in drivers/acpi/property.c. Remove
its prototype from include/linux/acpi.h and make it static.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c |  5 +++--
 include/linux/acpi.h    | 10 ----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..5435628c67e7 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1264,8 +1264,9 @@ static int stop_on_next(struct acpi_device *adev, void *data)
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child)
+static struct fwnode_handle *
+acpi_get_next_subnode(const struct fwnode_handle *fwnode,
+		      struct fwnode_handle *child)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead..703323b9fe0c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1349,9 +1349,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
 
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child);
-
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
 						 struct acpi_probe_entry *);
@@ -1450,13 +1447,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *
-acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-		      struct fwnode_handle *child)
-{
-	return NULL;
-}
-
 static inline struct fwnode_handle *
 acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *prev)
-- 
2.47.3


