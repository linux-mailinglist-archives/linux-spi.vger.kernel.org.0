Return-Path: <linux-spi+bounces-6738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4BA2F7FF
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED653A1F29
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0825E462;
	Mon, 10 Feb 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="D1LJX8Ik"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD025E450
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213774; cv=none; b=rkKqd94hnNtC/K4j9lsN6XJJOZAD8kXYhi6Dd9vAPOprp7f42tJfWHeXeVwdAShJwHRK5Vyz0A4wZ40s8JV+whhmbsbTln1NdziWjqFrviWGXW5BE0z1hrdbQbZCJpaPckvEO73Cjjs9mtQpMkKf6iILbXBFfn5H1p6IVRoVfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213774; c=relaxed/simple;
	bh=K1HErE+9n2ttTiWhv7TgYV84MOR53YCObeEEU4wqJ34=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:CC:From:
	 In-Reply-To:Content-Type; b=rWIozAeccRqaQA7RCDIV44t8LUlIePI44Huqs4g4hLxHUxjcwKj3LsipNYKQOM9uTtuoQ3mUdz5lOBGCKgImgMLg6a8fid++tyrcqnEe/hqPF89sRpdGSn2HUEdXfbxr5CLhoAu9B+kbPvMg1hLLARBY+ywFS9GHlVOyQAJNuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=D1LJX8Ik; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 790AEA008F;
	Mon, 10 Feb 2025 19:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZeA1tKZEOWBrfGju6V3i
	M5DXTUBJw5xJ1RYXprcK/rE=; b=D1LJX8Iklti/N171dY3bsAR7LJ1dyYti+rr+
	+8o74dc8GfHJpoP6Jojx8Tt0pgyZx2AC1By6WLnOQ5wnAHzN9RHQcigfCfKsUUns
	gIJVm75WPEw6nmvTt97XNEgNuljybRKuVAaCllzCGFpVws1VQsdqAu5fSOGEJuW9
	2iqU17i/dV5CD0E1sGXinFKzx/EcfIG6qDbvpmDsABgpdCCt3Bbf7BHq2w+H7DQl
	1fZyZrtKcoYp0c9ed+Lf6rPhlRqNymqSr1gRVfklTPBD1uKM1VyjqV60nqxgpC74
	mbtq96BNuE2XuAtgjHK8d4en+Ir+76+VKkxoGIOSbte0loo/mA/T5gCHSyZs+TqI
	wCIzs2gaM6CJAVMe/39Zmr/mBv9yKH0/MkK0DkkSUH8ZYKgDswpYgNIfVE4iF51i
	oG24O3fzo4ne8bZJiudCkoNxVGw+ql6+4Bfaxuvie6TgbfzeyBYOHuLYPTc6vySn
	3IoDtuvOF0e8bmwX+8LFCPsqTw/PKDtmoVd0Ixjt2wyPOW8V1q3tSXmPc4zB9gnM
	ZiYFMMIDkuhHOuF5TJ8ne+MVAvgede+NmTvwbaWV0+9pqhx68kU14YC4DSvPb06N
	N5OyFtASJop01Qz2p/qvKfpd1z3FlsyqTqyVXmzLj/QuJK7r2Dq8aL67kX9QlisL
	QeCc350=
Message-ID: <a5998b5f-f03b-4d9d-8e23-a7d688406371@prolan.hu>
Date: Mon, 10 Feb 2025 19:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH for-6.14 v4 1/2] pm: runtime: Add new devm functions
References: <20250210111008.248929-2-csokas.bence@prolan.hu>
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Alexander Dahl
	<ada@thorsis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>
CC: linux-spi <linux-spi@vger.kernel.org>
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250210111008.248929-2-csokas.bence@prolan.hu>
X-Forwarded-Message-Id: <20250210111008.248929-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852617666

Hi,
This is the PM side of the series. As you can see, it just adds two 
functions in the style of the already-existing `devm_pm_runtime_enable()`.
Bence


-------- Forwarded Message --------
Subject: [PATCH for-6.14 v4 1/2] pm: runtime: Add new devm functions
Date: Mon, 10 Feb 2025 12:10:06 +0100
From: Bence Csókás <csokas.bence@prolan.hu>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Bence Csókás <csokas.bence@prolan.hu>, Rafael J. Wysocki 
<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek 
<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
Danilo Krummrich <dakr@kernel.org>

Add `devm_pm_runtime_set_active()` and
`devm_pm_runtime_get_noresume()` for
simplifying common use cases in drivers.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
  drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
  include/linux/pm_runtime.h   |  4 ++++
  2 files changed, 40 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..f0a6c64bec19 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1545,6 +1545,24 @@ void pm_runtime_enable(struct device *dev)
  }
  EXPORT_SYMBOL_GPL(pm_runtime_enable);
  +static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active - devres-enabled version of 
pm_runtime_set_active.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active(struct device *dev)
+{
+	pm_runtime_set_active(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, 
dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active);
+
  static void pm_runtime_disable_action(void *data)
  {
  	pm_runtime_dont_use_autosuspend(data);
@@ -1567,6 +1585,24 @@ int devm_pm_runtime_enable(struct device *dev)
  }
  EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
  +static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of 
pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
  /**
   * pm_runtime_forbid - Block runtime PM of a device.
   * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612..d7eca86150b8 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -93,7 +93,9 @@ extern void pm_runtime_new_link(struct device *dev);
  extern void pm_runtime_drop_link(struct device_link *link);
  extern void pm_runtime_release_supplier(struct device_link *link);
  +int devm_pm_runtime_set_active(struct device *dev);
  extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
   /**
   * pm_suspend_ignore_children - Set runtime PM behavior regarding 
children.
@@ -276,7 +278,9 @@ static inline void __pm_runtime_disable(struct 
device *dev, bool c) {}
  static inline void pm_runtime_allow(struct device *dev) {}
  static inline void pm_runtime_forbid(struct device *dev) {}
  +static inline int devm_pm_runtime_set_active(struct device *dev) { 
return 0; }
  static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { 
return 0; }
   static inline void pm_suspend_ignore_children(struct device *dev, 
bool enable) {}
  static inline void pm_runtime_get_noresume(struct device *dev) {}
-- 
2.48.1



