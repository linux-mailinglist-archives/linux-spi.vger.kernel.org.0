Return-Path: <linux-spi+bounces-10259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB8EB98A71
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B74A6B93
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748BA2C0F7E;
	Wed, 24 Sep 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4RyIyvN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B729D26B;
	Wed, 24 Sep 2025 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699992; cv=none; b=VDSjG6QFcfO5EEsTVLiW5mDeJ0qOdl3+kCX3eeNrqspMqRiT5s3U5JFM+FYY6jTEm0LBkan+/WIX3OVq8qOtENrytTqgxl5JAE+x/Xblcbo7lKJ10xHVTbgLTXkF0LDEJBPytMAdJ1Lhi9QhC6gok250oa7XPERV6bwFRRrOhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699992; c=relaxed/simple;
	bh=jCyeJsf2r0hmAqCSjDUfebbgI9PEHOizoRXrfnF8aSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=malT8EdWfdSCh1V88j0oX1ZcPu3tijCJot6TLp2MKWaoaPyMy3Jtli1I53udbE56Bb9dOvGF1+Aw987WfkBAW76wqUHnQNm+T/wHdBeeV7kxhbbIP1DL5K7i0QxPj+XezG7CZmBjOsQfXqWL3NspbSJiF2jurF3MCTd/v5aTGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4RyIyvN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699990; x=1790235990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jCyeJsf2r0hmAqCSjDUfebbgI9PEHOizoRXrfnF8aSA=;
  b=G4RyIyvNFwJliUP5JEOjFEy+LBQKhyNjSx7J+LeOJBmnZUU1FmvVyh3/
   QBsRNFTP6fjKi49Ak+gs1silCsxFyJ79BLM6IyagO0F+65VlNEeOPaDbb
   +Db8utBj2Wk05JU1vnWc1tmFSA+7kHQFBASUFwU66Y8KIVl0w9xdBZqJh
   FlyWhAfqT59SIkH3+MEIuHrehNB2FN71jwJy85hfKNx11rQwOZ7j5e9AC
   3ciXFOF1xgg8h9ewRDWEnsIv71iYkFfQErECCeiOvRJhgjF4m1WXloYo0
   dEAat4eqxWf5tA67i1YaD1Au2MHCRbLyxQ3Z4WKPtVx7xdZuDuxZvy75/
   g==;
X-CSE-ConnectionGUID: 1D+s+atCRQ6I61KOG3+X+Q==
X-CSE-MsgGUID: uNxlcQ1eRKOKXFRsvvFf/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61101968"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="61101968"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:24 -0700
X-CSE-ConnectionGUID: 6OsWXskpThWmG08nWd7ZNQ==
X-CSE-MsgGUID: vp2lfI5bRq6us49iugMGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="200668542"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:16 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B0988121F11;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Ia-2rXt;
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
Subject: [PATCH v2 11/16] Input: touch-overlay - Use fwnode_for_each_child_node() instead
Date: Wed, 24 Sep 2025 10:45:57 +0300
Message-ID: <20250924074602.266292-12-sakari.ailus@linux.intel.com>
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
 drivers/input/touch-overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
index b9fd82c4829d..7eaaaef1bd82 100644
--- a/drivers/input/touch-overlay.c
+++ b/drivers/input/touch-overlay.c
@@ -82,7 +82,7 @@ int touch_overlay_map(struct list_head *list, struct input_dev *input)
 	if (!overlay)
 		return 0;
 
-	fwnode_for_each_available_child_node(overlay, fw_segment) {
+	fwnode_for_each_child_node(overlay, fw_segment) {
 		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
 		if (!segment) {
 			fwnode_handle_put(fw_segment);
-- 
2.47.3


