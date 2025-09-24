Return-Path: <linux-spi+bounces-10262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF1B98AF7
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071EF2E78C9
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D32D47F6;
	Wed, 24 Sep 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHmEPVPn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA62BE04C;
	Wed, 24 Sep 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699995; cv=none; b=DDMQ7nF70KnF4VQJRSzvKwqlr/TK+Zglmv6GrJpwZxuKUDa4ip8MfNbR9bj+NwYyFVu7ncAyUDvcNTwy1yVIkpU5IIiu78irToTX1XGCvvzaO/ldvzm75fkKwMJdljEZRU53tkI7plNLJTUtUluTw31i+d3LGaQi+rM4ZMhA8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699995; c=relaxed/simple;
	bh=B2qYXoILk/DYIyxK+5+jce29Axc6iUgAh2GsD4B1DdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eItqpirYLLDTlOWPzR5jWTPR7ash2fEa+WF73ymkZ++ZfAMpFSYBOsZ7GvtzrLBtqW0k0CeNvPoBfGJnW29Px5rN1DP0BmzHp9zVEXwHE7tLXigPp7eHSWO54GmuOXX0NdpeuR27c1HUxJn8RGrbLvvDDomT63VyyMg7gK8+W2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHmEPVPn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699994; x=1790235994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2qYXoILk/DYIyxK+5+jce29Axc6iUgAh2GsD4B1DdI=;
  b=kHmEPVPnN1aP2hC5rnfJ+UADE/DxFGyskCfyWBdZionCrB0qWvvTFLXh
   wiH7uPJdbcOC0ggQu6tBYVA4esN/LbG0Hz70k0D88SB/bUwYy26rptcLv
   kGHkN4uAE3SKHrhMHjlLqsfXYh18xTQfASz+3dGz/lyHhJ2FEs/A20rqx
   2oxAz0WNMQHlfaRrnQBnfcPTE1JI9mPR33u+jDzFEYELoEGQyKnUMkEs+
   EHI48a/qZFj2Gjy9wX9OqJ6G2XMkvORwKmN1yayOb0NGaW9cFSPFH/55c
   x0YJ26pi51bna0L0hHGIxJTvQ4sbTJqLmpztujpEoI4lct8z011LzyTks
   Q==;
X-CSE-ConnectionGUID: BAjlYahOQkW9/VEoo1vA8Q==
X-CSE-MsgGUID: zXaj7L88RyW9j/RRUbw92A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101995"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101995"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:33 -0700
X-CSE-ConnectionGUID: aQ/ramG2R9C1HZvxu+uodw==
X-CSE-MsgGUID: YLDbUcQOSiCcEGj8VSTxeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668599"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C27EA121F51;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Iz-3D1s;
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
Subject: [PATCH v2 16/16] spi: cadence: Remove explicit device node availability check
Date: Wed, 24 Sep 2025 10:46:02 +0300
Message-ID: <20250924074602.266292-17-sakari.ailus@linux.intel.com>
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

Don't check the availability of child device nodes explicitly as this is
now embedded in device_for_each_child_node().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/spi/spi-cadence-xspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 6dcba0e0ddaa..23e426ef9b9c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -908,9 +908,6 @@ static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 	unsigned int cs;
 
 	device_for_each_child_node(&pdev->dev, fwnode_child) {
-		if (!fwnode_device_is_available(fwnode_child))
-			continue;
-
 		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
 			fwnode_handle_put(fwnode_child);
-- 
2.47.3


