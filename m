Return-Path: <linux-spi+bounces-10250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33CB989DA
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC6D16361F
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048C2857FA;
	Wed, 24 Sep 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9sqPnn3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207728136B;
	Wed, 24 Sep 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699983; cv=none; b=sVRNHZEiOX9rX95sjkYd5XHnkX800HhNAGDgkZuWuBWrWBwH7qCFGY9lkIJZAPMf/l05le4hxfcedySX98+3fYH5+nQLp3ekimJ1INV59A52tw8DBy23zvNPV9o/oNV8KPbeisaC4BcVGB6zPqQUDxBB/iWEXOpzfX/A92hmxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699983; c=relaxed/simple;
	bh=hGCimekiy4lQWMYOVtyy0ZshjTYtVpRm+lGYihUQeGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMFKnkdXYijgRQBUMVIVCv6jUHPG8yoEp0CZ2UE8md4NONdowNdIqHmkMG76EL97B6b9iHYncFzB2LtWI4+mvjETt8E5WTex+Iql2lUyDuUX3zINntUVQbWXG/m8REEZK2RZGR4xTsDS2uXJnjI8/Poupqytkm35xWg4VTiYauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9sqPnn3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758699982; x=1790235982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hGCimekiy4lQWMYOVtyy0ZshjTYtVpRm+lGYihUQeGA=;
  b=W9sqPnn30gIHTFYaYE8l0kwlCC71UJebi3jhMCh2PQkHtFq/BeZ66V93
   hssEQ6pGVzQ31cYQiidAGg5nn37BBL2QnpZiqL3PWxDDAa8hb8mkVnBTv
   oBmuuy4k/erkaNDKVaOELfgW4/Nlp0Ej4VEERDvRcfDlbheg80LsVCAfl
   DyQYfv8Iih8/iR4HMZvcL9kO2EUTIJZo2heF4UFyt9uwq+3maz+zA7T8R
   rMcTzCS9NZoI5Qs/Nzot6bGJg5//Xy8lEMRR8/mFdZ0w/FBnmewTppOUD
   8aAHfM5luk09sQctGJ9h+fVkEgaWVKaFgUgo0kX4Zj3mX4zoTa2Fd5tvb
   A==;
X-CSE-ConnectionGUID: Dq6cbfYpT8aOLFhtbYikzg==
X-CSE-MsgGUID: KW/ie6EPSxuBlRRnWXoKsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72346960"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72346960"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:15 -0700
X-CSE-ConnectionGUID: Krifw9XSTJ67QEUJYh4R3w==
X-CSE-MsgGUID: KWcSzU2iTFWd0zPn4BtXGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176552706"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 00:46:05 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8A20F11F8D0;
	Wed, 24 Sep 2025 10:46:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v1KCQ-000000017Hk-1wde;
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
Subject: [PATCH v2 00/16] Align availability checks on fwnode child node enumeration
Date: Wed, 24 Sep 2025 10:45:46 +0300
Message-ID: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Historically the fwnode property API has enumerated only available device
nodes on OF whereas on ACPI, also nodes that haven't been present in the
system have been provided. Both OF and ACPI have similar concepts of node
availbility, on OF it's the "status" property present on device nodes and
on ACPI the _STA object evaluates to device present, enabled and
functional bits, of which the present and functional bits are currently
being used to determine whether to enumerate a device.

Two additional functions, fwnode_get_next_available_child_node() and
fwnode_for_each_available_child_node(), have been provided to enumerate
the available nodes only on ACPI, whereas on OF the implementation has
been the same on the non-available variants. The motivation for providing
these has very likely been to provide fwnode variants of the similarly
named functions but the difference isn't justifiable from API consistency
viewpoint.

This set switches the users away from the "available" fwnode API functions
and later on removes them, aligning the functionality on all fwnode
backends.

since v1:

- Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
  first.

- Add missing parentheses and kernel-doc Return: section in
  acpi_get_next_present_subnode() documentation and move the Return
  section: of fwnode_graph_get_endpoint_by_id() to the end of the
  documentation section (new patch for the latter).

- Use device_get_next_child_node() instead of fwnode_get_next_child_node()
  in flash LED driver drivers.

- Rework iterating port nodes in acpi_graph_get_next_endpoint() as
  suggested by Andy (new patch).

Sakari Ailus (16):
  ACPI: property: Make acpi_get_next_subnode() static
  ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
    only
  ACPI: property: Rework acpi_graph_get_next_endpoint()
  ACPI: property: Return present device nodes only on fwnode interface
  property: Move Return: section of fwnode_graph_get_endpoint_by_id()
    down
  property: Drop DEVICE_DISABLED flag in
    fwnode_graph_get_endpoint_by_id()
  property: Drop DEVICE_DISABLED flag in
    fwnode_graph_get_endpoint_count()
  property: Document that fwnode API returns available nodes
  driver core: Use fwnode_for_each_child_node() instead
  net: lan966x: Use fwnode_for_each_child_node() instead
  Input: touch-overlay - Use fwnode_for_each_child_node() instead
  media: thp7312: Use fwnode_for_each_child_node() instead
  leds: Use fwnode_for_each_child_node() instead
  leds: Use fwnode_get_next_child_node() instead
  property: Drop functions operating on "available" child nodes
  spi: cadence: Remove explicit device node availability check

 drivers/acpi/property.c                       | 42 +++++++++----
 drivers/base/core.c                           | 10 ++--
 drivers/base/property.c                       | 60 ++++---------------
 drivers/input/touch-overlay.c                 |  2 +-
 drivers/leds/flash/leds-rt4505.c              |  2 +-
 drivers/leds/flash/leds-rt8515.c              |  2 +-
 drivers/leds/flash/leds-sgm3140.c             |  3 +-
 drivers/leds/flash/leds-tps6131x.c            |  2 +-
 drivers/leds/leds-max5970.c                   |  2 +-
 drivers/leds/leds-max77705.c                  |  2 +-
 drivers/leds/rgb/leds-ktd202x.c               |  4 +-
 drivers/leds/rgb/leds-ncp5623.c               |  2 +-
 drivers/media/i2c/thp7312.c                   |  2 +-
 .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
 drivers/spi/spi-cadence-xspi.c                |  3 -
 include/linux/acpi.h                          | 10 ----
 include/linux/property.h                      | 14 +----
 17 files changed, 61 insertions(+), 103 deletions(-)

-- 
2.47.3


