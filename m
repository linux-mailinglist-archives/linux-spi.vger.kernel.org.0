Return-Path: <linux-spi+bounces-10257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EEB98A89
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C228C2E4FD2
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F12BE622;
	Wed, 24 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="favdTWGj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262028EA56;
	Wed, 24 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699991; cv=none; b=AW37chp3KiC51KvVHLhQ8QZ4Xj7UwJKv1B20rXBv+7v/vpG51cU3Ms+qSRTj3kJE0/gRbxxhWJcya2iDs6qoBpAGcP1wLvuuC2Z7xGIBGSP7u3WEfzmaEFrcUnb0Pz9QWmD2gZ4kWdxIxsSmGW9H0RMIpGrPp7fYjMuGvb+PVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699991; c=relaxed/simple;
	bh=YEMoVFGRIKr3yaB/85GG8MMYozAqXqP6oP6pAgVZzg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQqp9uPqDFk+7ee7ilLU0tAbN2jMbeK0+qk/ZfWyWw3+tUBT0q4ILp8M+Wj+oilWtJ5TrYUM2VgmxBo6KlmZVTzrklt7P5kDdRLs1WiGd7G1UYg4TyYMwOwmdHqHn4YwJY2Jz5I94A6nnyGDEXirlE4wE6KfSMUNBRIvD3qx8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=favdTWGj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699989; x=1790235989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YEMoVFGRIKr3yaB/85GG8MMYozAqXqP6oP6pAgVZzg4=;
  b=favdTWGjx8arqDGV7E8eEGMvvPAC5fsP/Hw3BmgrvY4RJodzXfqCvf9L
   Muz8qmSJTEE5lqI8kOp1zQK9xSkGkdBgqaQ/KILXGm8hAiAWx8b+aNtkI
   qgZ7GX6NCLKc/qycdDolI1of+0y1q3rE/JE1GYkjYM9wpxMnkoUNoPbee
   VWwVO/hZIAmkMXlqXqxYpW0syycJ/djyGubZs8CF7ywbCVPbfg+hfAA5a
   VpLwCUSINuC+xa7InO5WLDXOc39ecdnPtsqHXsZtmQMzlSauTQEjsMl0c
   +YHqYipQ0vHVQF9hbB7Nx+uj8jgTlVQM9kT63EHe/oOsmrmUNtSTYEA4W
   A==;
X-CSE-ConnectionGUID: 5OHhM+N8RxaLGFM/QrVm+Q==
X-CSE-MsgGUID: ChS9j1pxQLa99MLutlcfiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101964"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101964"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: /Q0sT1IITEK5WggO2sxDXA==
X-CSE-MsgGUID: nWAah8PQRUu8rgp1kZfFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668535"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9F9DE121EE6;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017IG-2aP6;
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
Subject: [PATCH v2 07/16] property: Drop DEVICE_DISABLED flag in fwnode_graph_get_endpoint_count()
Date: Wed, 24 Sep 2025 10:45:53 +0300
Message-ID: <20250924074602.266292-8-sakari.ailus@linux.intel.com>
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

FWNODE_GRAPH_DEVICE_DISABLED flag isn't used anywhere, drop the flag and
support for it in fwnode_graph_get_endpoint_count().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 10 ++--------
 include/linux/property.h |  8 +-------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7fc3257f223d..4bd64e729431 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1291,21 +1291,15 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 /**
  * fwnode_graph_get_endpoint_count - Count endpoints on a device node
  * @fwnode: The node related to a device
- * @flags: fwnode lookup flags
  * Count endpoints in a device node.
- *
- * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
- * and endpoints connected to disabled devices are counted.
  */
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags)
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *ep;
 	unsigned int count = 0;
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
-		    fwnode_graph_remote_available(ep))
+		if (fwnode_graph_remote_available(ep))
 			count++;
 	}
 
diff --git a/include/linux/property.h b/include/linux/property.h
index d1e80b3c9918..8b8bbbe6b5b7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -503,19 +503,13 @@ static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
  * @FWNODE_GRAPH_ENDPOINT_NEXT: In the case of no exact match, look for the
  *				closest endpoint ID greater than the specified
  *				one.
- * @FWNODE_GRAPH_DEVICE_DISABLED: That the device to which the remote
- *				  endpoint of the given endpoint belongs to,
- *				  may be disabled, or that the endpoint is not
- *				  connected.
  */
 #define FWNODE_GRAPH_ENDPOINT_NEXT	BIT(0)
-#define FWNODE_GRAPH_DEVICE_DISABLED	BIT(1)
 
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags);
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags);
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode);
 
 #define fwnode_graph_for_each_endpoint(fwnode, child)				\
 	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
-- 
2.47.3


