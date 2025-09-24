Return-Path: <linux-spi+bounces-10252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AFB98A05
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76A32E5215
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC852877D8;
	Wed, 24 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBgOw7Kp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53412868AC;
	Wed, 24 Sep 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699986; cv=none; b=DVw+3yd6hWyOLVrhdPGCJ+CcbsgxwfP/uL9NKeRfH3TmfPJbtynj/YWJXmOBv62E13sULayxZCJtUrbplEhuUzWyDovPKIqOxBU93z6AjqgPG+HOpEntj6gzvk2X1wDvJ9fhKSMXc1yorQbXFm4ZX9OpAhiGz5rV4Osb4jzB2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699986; c=relaxed/simple;
	bh=Anz3rO9Mu9zPQ1DZfAdtLVxWTChRDh4jAfuNcWRNf9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWyM1mJLI+LG+CetRG3DvUVVRyxrXKQqZ8VpDU843I0+eIz6PzsDi6wOz1Qg5a87jomMBUGUxMQpe/XtV57n334QuVCfCWE8olEJiS5JmmSGxNRYedkYIUYN9EezLsIuWK/QdiMGmcSJbKrA8jRGDM1D55AXRwmT3vysg6snom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBgOw7Kp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699985; x=1790235985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Anz3rO9Mu9zPQ1DZfAdtLVxWTChRDh4jAfuNcWRNf9Q=;
  b=kBgOw7KpcL7sQ4cv8jb2oyJ3zpjusb/+T2WRJk2tOzNTJaVg+1BnbCrK
   PSa2GRP3HQ41OW6YPU8P1Eqpz/Xn0Ug/SrnuzdTj8R3Eyqb1T0a59pXjM
   dManixSJGV65kZwulujqE9H4aDeyzKfZS6+OK3bbVSRlR2CuqvcJpVWVD
   9rhAqvxni8lCl/A2kdmhdPp7eLM6h10Jh77xqVHNMsIS0MjSrQE2ihws6
   BN0S6XEfcBTHT/edl7RG1cOi7uDOtZfhS59My58aH+XgkpKCiAZyyEwHT
   CiA+R92KAoo6NRL8BDrmThUnOdNv1cTBL5QK/Y8m3F6hHFLZ15aW/7FAG
   A==;
X-CSE-ConnectionGUID: 2Wl2ugOGRNmPzvxvv1kh1g==
X-CSE-MsgGUID: az2/zTAsTGSMryuZem64og==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101840"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101840"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:23 -0700
X-CSE-ConnectionGUID: oUqsEg2RRQ+bTeq8JHf0iA==
X-CSE-MsgGUID: 6FjHMBvbRmGDkR2nahiHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668532"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 95C37121ED6;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017I6-2RYT;
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
Subject: [PATCH v2 05/16] property: Move Return: section of fwnode_graph_get_endpoint_by_id() down
Date: Wed, 24 Sep 2025 10:45:51 +0300
Message-ID: <20250924074602.266292-6-sakari.ailus@linux.intel.com>
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

Move Return: section of fwnode_graph_get_endpoint_by_id() down where it
habitually is located.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f626d5bbe806..b52f7b3bbf84 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1235,15 +1235,15 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  * The caller is responsible for calling fwnode_handle_put() on the returned
  * fwnode pointer.
  *
- * Return: the fwnode handle of the local endpoint corresponding the port and
- * endpoint IDs or %NULL if not found.
- *
  * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
  * has not been found, look for the closest endpoint ID greater than the
  * specified one and return the endpoint that corresponds to it, if present.
  *
  * Does not return endpoints that belong to disabled devices or endpoints that
  * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
+ *
+ * Return: the fwnode handle of the local endpoint corresponding the port and
+ * endpoint IDs or %NULL if not found.
  */
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
-- 
2.47.3


