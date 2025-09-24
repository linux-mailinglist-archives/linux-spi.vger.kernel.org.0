Return-Path: <linux-spi+bounces-10248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF893B9899C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58421B20F01
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CC4280CF6;
	Wed, 24 Sep 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnUmOSH7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E527FB1F;
	Wed, 24 Sep 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699981; cv=none; b=eOcNXkOHRI5ic20zWTlKX5AB8zvknsik1FqewDs6PCpOdOQM85BkgGsozEMFzSZ14Ohu+xsryEg3yeHow/sTPlD0xp7MLy9RS/N/lwHrLefJU9st0JFAF0VbAca/IEG5sQph98+u9gWhx2s/Yf4uddgKSfNbTk8fBpbrmnduuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699981; c=relaxed/simple;
	bh=SVJiG61AeCGYEGwMyYhoNXYuyHeGsyQ90cGkNId9RNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzWkP64Yl/gHwN5Leu48+oXTON241hRpAtMgnlK5McJb8TsE/6ZYn2j4M5DfWafa1I2ghLBRtPWdeX7M768sYLVwncO5q/iPdZvT2fDtwgd9CnyDO/p0yBR/QEa4/JfkoSK5IyXT/d9eFemG8Wa4maGnEsY/cSrd2OVLS6GA4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnUmOSH7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699980; x=1790235980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVJiG61AeCGYEGwMyYhoNXYuyHeGsyQ90cGkNId9RNs=;
  b=CnUmOSH7QgjsbWrcH9d7rRxnCnnyile2cA/F3kKnSQAbOc2FMImApZV0
   e/O6aZdxfRBPipvCMrsrBMVp/KWtEY3LHifYZgMfNryxCfURk4Wut/vQy
   ynRoXmRsPeoPQUNGWMxYxtm026xvbUAGsWhM37hAI66xbVQr/nvSFSVK4
   IRLT+VZ/yLL8c1CQ4J3BGx7BM6b4JV+D0dQVgll1OSJ/Wp6BQ7xMP19gK
   iaRfmzPdahbGxpWF+BOtCWZstkYOHWzGu7eOG4Oxm70JlL4RE+/LGWSyu
   Cvq5JDnQoaMH6dY3q1HJXPa4+N7jQdBKvOguLeX59n5EgsCd+FmFqASLY
   w==;
X-CSE-ConnectionGUID: kOSG/UbgStq465NXsPswYQ==
X-CSE-MsgGUID: XHekQQ2ZQ7Sk94SRJliXUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72346954"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72346954"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:15 -0700
X-CSE-ConnectionGUID: TbSKI+o5RlmZhcDwedR77A==
X-CSE-MsgGUID: 5s/EPqjSRJWLbnHoFkaz3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176552708"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:05 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8B5BE1210EB;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Hr-2DCP;
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
Subject: [PATCH v2 02/16] ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only
Date: Wed, 24 Sep 2025 10:45:48 +0300
Message-ID: <20250924074602.266292-3-sakari.ailus@linux.intel.com>
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

Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
property API is somewhat problematic as the latter is used in the
impelementation of the former. Instead of using
fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
acpi_get_next_subnode() directly instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5435628c67e7..3e85900080ac 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1381,7 +1381,7 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 
 	if (!prev) {
 		do {
-			port = fwnode_get_next_child_node(fwnode, port);
+			port = acpi_get_next_subnode(fwnode, port);
 			/*
 			 * The names of the port nodes begin with "port@"
 			 * followed by the number of the port node and they also
@@ -1399,13 +1399,13 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 	if (!port)
 		return NULL;
 
-	endpoint = fwnode_get_next_child_node(port, prev);
+	endpoint = acpi_get_next_subnode(port, prev);
 	while (!endpoint) {
-		port = fwnode_get_next_child_node(fwnode, port);
+		port = acpi_get_next_subnode(fwnode, port);
 		if (!port)
 			break;
 		if (is_acpi_graph_node(port, "port"))
-			endpoint = fwnode_get_next_child_node(port, NULL);
+			endpoint = acpi_get_next_subnode(port, NULL);
 	}
 
 	/*
-- 
2.47.3


