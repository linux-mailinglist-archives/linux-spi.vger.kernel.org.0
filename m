Return-Path: <linux-spi+bounces-10256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCE7B98A5F
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD572E6365
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909429CB48;
	Wed, 24 Sep 2025 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBbmdSws"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D728A704;
	Wed, 24 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699990; cv=none; b=LUbZ5cGlrwv+Ed0DcRSBvRKKARO57ErAM955wJ6fnsrZFeRModefdJvyBAFGXKhX4dATEfBonqLZMQ6CXqNib8evWuJaQSBT01YCpTWYcFOrwLBdALriLT35d6OHUKh3UPkEv1wJ7eeNehaZavKIjOn/Z6Pgz32VnmJimprUfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699990; c=relaxed/simple;
	bh=SOIIxPHN0pMKXry68YzKaQyiVojN7g77KKyrfmEqRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tngQCqL2hE+J145/hhNcJtBEdAQzJnjuv7Ps0zuMc/DsMBF9Nat7ETt1ejsq6Onm41jpvdLuiXjvhVngL2x5hT8A9t0rLiWQoeHsRsE9UwPKZtPezXsAKhdZgPPt8u29Y5Yje3sG5T2dqDH8/jxavAIH3iFtOm9gahmZQsnmBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBbmdSws; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699988; x=1790235988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOIIxPHN0pMKXry68YzKaQyiVojN7g77KKyrfmEqRek=;
  b=VBbmdSws2F7Xq2g3tM1I8OtSVtPSE0yAgyjSnM/s5ICqKja5kWF/JOVh
   VNjQaCyMXgGMZvhT4lYUt5y3LekGF3H5a9PjY8lAfvx2aFquqxyADwUuM
   3VZt3P5AtOr5Ok8rse4ZXZrWig6zDk7n1TwG4fTH/XQRK0Zm3ernLnkqE
   iT7wyckQYTuQhhwYumQqVgNeyoP57rpY0GWCm1A4PP67uoXZ2hhb8EtY3
   +sbk4rk2Fyqb1/CSYgB+jRczNWF6eFzn36ke5ghQcoeKzNCpqpY3iqqp1
   HmQ1P3ob9YEX7pDBGPd9qhm+tVxH7lp6sPVWh8d+AGB07oZuOTrMANeos
   Q==;
X-CSE-ConnectionGUID: UWxWn5F7Q6qSSVrHENMwWA==
X-CSE-MsgGUID: vYzl/ogdRjueZon6rGbd0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101939"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: kOvLmrUXR7mewE4Ks/imKA==
X-CSE-MsgGUID: nEYBz1pHTYG/vba7Qv0hWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668541"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B3757121F23;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017If-2vJX;
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
Subject: [PATCH v2 12/16] media: thp7312: Use fwnode_for_each_child_node() instead
Date: Wed, 24 Sep 2025 10:45:58 +0300
Message-ID: <20250924074602.266292-13-sakari.ailus@linux.intel.com>
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

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/thp7312.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
index 775cfba188d8..86208a47f472 100644
--- a/drivers/media/i2c/thp7312.c
+++ b/drivers/media/i2c/thp7312.c
@@ -2064,7 +2064,7 @@ static int thp7312_parse_dt(struct thp7312_device *thp7312)
 		return -EINVAL;
 	}
 
-	fwnode_for_each_available_child_node(sensors, node) {
+	fwnode_for_each_child_node(sensors, node) {
 		if (fwnode_name_eq(node, "sensor")) {
 			if (!thp7312_sensor_parse_dt(thp7312, node))
 				num_sensors++;
-- 
2.47.3


