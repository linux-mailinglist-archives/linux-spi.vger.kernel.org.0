Return-Path: <linux-spi+bounces-10247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3AB98988
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E572E4BDB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9727FB06;
	Wed, 24 Sep 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRGsFYix"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93260A95E;
	Wed, 24 Sep 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699979; cv=none; b=o24iPE9hBAFfFYPF+G4awDiGjtsP4eXzZys/Z1JAUeINsaZDGLoXwbAi92OT5XCLx9ci92EfGPojHaMvJPPhJ996iiOpQJE0Vm6mChvPYqMOXfLzbprwMNdPEKmMigEk0S0YGoH1VzTq+MWbSxfH0Oo3T5fMTKKJ9Je3Yu2nSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699979; c=relaxed/simple;
	bh=JvDek3868I+EgXDu4lEVZh0rf97VIgk/Snbhy8YIQcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTCbjTBvsB7QIwg7uxKDGqDuDWd98l0CSt4Rt0K1iCBiG3CrPcyiwqOfIB5iYj94TMbzelbm2p7WpuHHp1bjLLNkNi2hNOR4uscmbE1HfQz7gWgP0nkBuhtSfn8B1tUNrXxOEf1ZkAweGhb0yryIBKVndSYGALFOJVdGRUcigLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRGsFYix; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699978; x=1790235978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvDek3868I+EgXDu4lEVZh0rf97VIgk/Snbhy8YIQcw=;
  b=cRGsFYix+th60d5bT9j2W5JeUssWOP5kIP2gD5kZlqT6YYx/nF6YbIZx
   62tZRhS9uQcSK5WObFq6aH5Q0vS+Tc1Dywe4OzFh+9aO+rxgBNNzGw/No
   gWgT5laNADXlhamO/1G3EUwXeelV97f/DSLQankUu4Nop2K7e4xhRvp+5
   owf8BZjN97gDe6ROCjS7yd3UGRuUcH59HJ5iQVybhkeWkHt1n/IynV1Hb
   qLHwrklpq2vr9xFMwkxthAyG8QL8v5TNGQVMEbbORkpVb2wYMO7/d45H5
   Muf2KNh1Sj3DmfurB0yw7Uy7WraIo/G84bOfekRCXbVPysZw0xHXyH2fh
   w==;
X-CSE-ConnectionGUID: QkFjiIWARxe36aJDpBOpmA==
X-CSE-MsgGUID: pjtkPmsURESCjazbaB+b2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72346910"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72346910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:14 -0700
X-CSE-ConnectionGUID: CScHHwNbR/K+jJNyCBGC2g==
X-CSE-MsgGUID: O001B7FtQBqXhllo8rLSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176552705"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:05 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8EB9D1213E4;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Hv-2IyK;
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
Subject: [PATCH v2 03/16] ACPI: property: Rework acpi_graph_get_next_endpoint()
Date: Wed, 24 Sep 2025 10:45:49 +0300
Message-ID: <20250924074602.266292-4-sakari.ailus@linux.intel.com>
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

Rework the code obtaining the next endpoint in
acpi_graph_get_next_endpoint(). The resulting code removes unnecessary
contitionals and should be easier to follow.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3e85900080ac..5438592dc136 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1399,14 +1399,15 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 	if (!port)
 		return NULL;
 
-	endpoint = acpi_get_next_subnode(port, prev);
-	while (!endpoint) {
-		port = acpi_get_next_subnode(fwnode, port);
-		if (!port)
+	do {
+		endpoint = acpi_get_next_subnode(port, prev);
+		if (endpoint)
 			break;
+
+		port = acpi_get_next_subnode(fwnode, port);
 		if (is_acpi_graph_node(port, "port"))
-			endpoint = acpi_get_next_subnode(port, NULL);
-	}
+			prev = NULL;
+	} while (port);
 
 	/*
 	 * The names of the endpoint nodes begin with "endpoint@" followed by
-- 
2.47.3


