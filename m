Return-Path: <linux-spi+bounces-10254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0EBB98A35
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D67F169024
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23C28DB71;
	Wed, 24 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMPlNoXR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640C2877EE;
	Wed, 24 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699988; cv=none; b=A/9LUwvokkGM5w4FD/HGkb5GlgFBfon9rwrNKJmEhLR8HVl+mWbN2P6oZdYdQ1yV+I3uzfFfSZ2G7Ew3ewotMrAc/Dbdstr15D4z2YM/5klUTOq4fcBnIgKdGUCEC1rwJOeN6C4fRhDSKCeftXGixp5IntDhlE8umWHmAKsIIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699988; c=relaxed/simple;
	bh=pXWEgYXLU9fXaadHSr8OOdbMen5ZCVGmiu6kQZwpv3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRwfo8yrZup+sr1MbfbppEnk2vpDX0jJLrRqY5+Tb6IstIQFOcBiGs2cB2Oe0Ez1PDYGIJkksLCtlInK3PFqjFunem+RYnllW8Vnss84JCpAlvH7T5l7uUEA3oYew+wQZR6nJB2pyTgwhJ8yV5TcpZ2PKSj7PQrGcldgv9rE1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMPlNoXR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699987; x=1790235987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXWEgYXLU9fXaadHSr8OOdbMen5ZCVGmiu6kQZwpv3w=;
  b=LMPlNoXRHWQhg6uZay3isy8PVrFd22T+JBTwlU0+9P5eCE92Qo9XV8yz
   g1wbALhINQ9gQpLql9RznX9FkGHpk/+yeQAYugNJMIVWMLZtESVJTGFZm
   XL10GJC9OMc1Ak42M282bnGmsGpVOIxwSJc8/zQQo/3PdWmAA/fACtXow
   6z9OPlFEsiJtwZKm9F3xswnecAe1x1CLsbZsqrd1DnLQEue8zonF9k38A
   JXSHC3pIJPsMaZGrA8nbB5uFAILiuMoYVDtMlVcAraGG2+eiTY6cAKoAb
   DDknPO9Y2lLB9MVePiwsavKMmMYhx59iIvpemKYfs1Y2kApUBoKS9IjPA
   Q==;
X-CSE-ConnectionGUID: 89xpmAfJSXi5OFobKpcz3Q==
X-CSE-MsgGUID: lCqknGwiTeOyfO0yGzUKpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101894"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: +JlRilW3Qbq323C1oDG+GA==
X-CSE-MsgGUID: 3H72Q930THGvSOjZgEHIow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668534"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9A02A121ED7;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017IB-2WYI;
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
Subject: [PATCH v2 06/16] property: Drop DEVICE_DISABLED flag in fwnode_graph_get_endpoint_by_id()
Date: Wed, 24 Sep 2025 10:45:52 +0300
Message-ID: <20250924074602.266292-7-sakari.ailus@linux.intel.com>
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

No caller uses FWNODE_GRAPH_DEVICE_DISABLED flag when calling
fwnode_graph_get_endpoint_by_id(). Drop support for the flag entirely and
remove it from the documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b52f7b3bbf84..7fc3257f223d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1239,9 +1239,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  * has not been found, look for the closest endpoint ID greater than the
  * specified one and return the endpoint that corresponds to it, if present.
  *
- * Does not return endpoints that belong to disabled devices or endpoints that
- * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
- *
  * Return: the fwnode handle of the local endpoint corresponding the port and
  * endpoint IDs or %NULL if not found.
  */
@@ -1252,13 +1249,12 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 	struct fwnode_handle *ep, *best_ep = NULL;
 	unsigned int best_ep_id = 0;
 	bool endpoint_next = flags & FWNODE_GRAPH_ENDPOINT_NEXT;
-	bool enabled_only = !(flags & FWNODE_GRAPH_DEVICE_DISABLED);
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
 		struct fwnode_endpoint fwnode_ep = { 0 };
 		int ret;
 
-		if (enabled_only && !fwnode_graph_remote_available(ep))
+		if (!fwnode_graph_remote_available(ep))
 			continue;
 
 		ret = fwnode_graph_parse_endpoint(ep, &fwnode_ep);
-- 
2.47.3


