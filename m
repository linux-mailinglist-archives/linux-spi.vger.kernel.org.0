Return-Path: <linux-spi+bounces-10258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500BB98A5C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB3F4A68FD
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E272C0267;
	Wed, 24 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcYAS+Ha"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752B27FD56;
	Wed, 24 Sep 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699991; cv=none; b=UyQ9i6/Wg3QV3qDDvT04+G4A50lSfd6soqbeo/tmsW9x/BKe11KnhHlqlIAm+tid649ZbgXWSbp2qBbkQVB+7COzl2Ohg/CI0mTCSbKxFFHew9x+YbU5gqzvw4Wb7wiOQm8k1E1Bly1X1aB2Jm7MGxZyHAXrFvzmESfTfFbCELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699991; c=relaxed/simple;
	bh=PJ/0flzXVWcNhnUEcXMEKNKkeTXGBw9Rsb6c3sMfa+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCWoCyyrPweehVH7IWogAGCLnfiU4x5pQCZfjvLW47T7+1CB5ocVE2mXfU866U1OSWnfJIOiFhY01OljU/HMx8v3GcO2w7hyXPTzPwHNXwCoZtKpeRul2l991bVz3O0jY3HCInjMZdrE21NawWRrrKQc1Ua6Cm/wtt+5HJAASZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcYAS+Ha; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699990; x=1790235990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJ/0flzXVWcNhnUEcXMEKNKkeTXGBw9Rsb6c3sMfa+U=;
  b=WcYAS+Ha6cl2RlsOhyzBKPMIW+tukrKXj6I4J+4wlnSTASVZocwhldgk
   G/cF4xSd7vd29OVkyhwpZcuhxVTe6neH0k+lazoCG4Rj2zg5g00Ais44f
   Po8oTe++5X/i5SaiDfcVKTHUw4iC9bSxKZirg/D23HzH0SRczbIbHcVVt
   ya9gAzPGfIbBywKSKZjvk+vfLT4DBZapbjxp8UrigV/MkTh8k05FIDxYh
   613NdrrrxZ98LG8i8a0+NsoNUxQJ/gyG4bP4xAYpAsqqaDPn24fswX0vA
   Gu1xk2++QZv+i3ZJDzPEvUAcqKyhp1QrHyWa9uFUs/0j+KEp3e8/KkZlZ
   g==;
X-CSE-ConnectionGUID: 0OcDQgPkTDuTyTfaRSOY2Q==
X-CSE-MsgGUID: KkNQUfZPToSmCftgEpQGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101970"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101970"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: LX4BoujZRLGq+JWqCpaCfQ==
X-CSE-MsgGUID: 7uNsXV0cQn+ZjY09fP/IdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668531"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A2508121EE7;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017IL-2ew1;
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
Subject: [PATCH v2 08/16] property: Document that fwnode API returns available nodes
Date: Wed, 24 Sep 2025 10:45:54 +0300
Message-ID: <20250924074602.266292-9-sakari.ailus@linux.intel.com>
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

The fwnode API has historically provided two functions to iterate over a
fwnode's child nodes, fwnode_get_next_child_node() and
fwnode_get_next_available_child_node() whereas all of the fwnode API has
always worked on available nodes, apart unavailable ACPI child device
nodes could have been returned by fwnode_get_next_child_node().

Now that the availability check has been added to ACPI side as well,
document that the functions in the fwnode API return available nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4bd64e729431..ff440456af7b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -785,7 +785,7 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
 /**
- * fwnode_get_next_child_node - Return the next child node handle for a node
+ * fwnode_get_next_child_node - Return the next available child node handle
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
  *
@@ -830,7 +830,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
+ * device_get_next_child_node - Return the next available child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a %NULL handle.
  *
@@ -858,7 +858,7 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
- * fwnode_get_named_child_node - Return first matching named child node handle
+ * fwnode_get_named_child_node - Return first available matching named child node handle
  * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
  *
@@ -874,7 +874,7 @@ fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
 /**
- * device_get_named_child_node - Return first matching named child node handle
+ * device_get_named_child_node - Return first available matching named child node handle for a device
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
  *
@@ -928,7 +928,7 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
 /**
- * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
+ * fwnode_get_child_node_count - Return the number of available child nodes for a given firmware node
  * @fwnode: Pointer to the parent firmware node
  *
  * Return: the number of child nodes for a given firmware node.
@@ -946,7 +946,7 @@ unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
 
 /**
- * fwnode_get_named_child_node_count - number of child nodes with given name
+ * fwnode_get_named_child_node_count - Return the number of available child nodes with given name
  * @fwnode: Node which child nodes are counted.
  * @name: String to match child node name against.
  *
-- 
2.47.3


