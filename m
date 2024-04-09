Return-Path: <linux-spi+bounces-2237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A389D1FB
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 07:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2900286178
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1171742;
	Tue,  9 Apr 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWtLPJcs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DD6A8AC
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712641036; cv=none; b=bIO6UWy8Dorvv2HLN2EPQ8KOEpF6s+XIFLu9tNpMXxe71J+k6C5cesFM5uIEunjiDvb8LbQs9HukpC3qV4EpsGac/dY6M3yM2E1o6cY/eMq4mX1QFpbkL5le8lE4qmRKjdk2JTn2+fD2D3sZc+AaYTvRtyBrVNVxXY2vtnrPG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712641036; c=relaxed/simple;
	bh=UeZnCjsFlLic2qaSZoKNxomMdFYr768316T0wajX8u0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=YzYglEmW7ViNAzd65r8PQiEEZcn6cHlu44lygdVrfA1uxeYanqr0PLUw4F1bN6rvpSv+ZRFhoLV0HPaKIELTDmLKIBk7/PGqoBlHCPp5XX3RBtKgmg4YkRhULSiviQaziDnGQNpU+3BNx5ZOb/GvUDd17n1plAXVD0XHu6tCiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWtLPJcs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd62fa1f9so81252307b3.0
        for <linux-spi@vger.kernel.org>; Mon, 08 Apr 2024 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712641034; x=1713245834; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHsEtZCKaHOJpKzkmFo1QTaciQX5xyBED5wwHFx24rA=;
        b=sWtLPJcsrRU+YOrqZK01sNtI9pW3V3U7bUI+SItreqz9yVw5Pwkie3jc9UNJSZKhh6
         wnQ2nDy5HdaA1/wWziZ9iHOZHaIVT/DYAvjni4u9hjkpNQb8hDHiDUdYxOnI1bAlExt4
         grwskoA12q+PVBqCs+s/DB+aX52N4MEbM2DP/XQvJS6VsgyykwYKvE5EiWBfo2MIu0p8
         nWP+VZQoFheCXV0FWv3ShqMHRE4lWMutJIEQnZx7tniAsh3Uk2YI9pZmsa+v8sdqpR3Z
         gJd4mDscFaspsczU2XAEWsNPUBahaC8QSvH9ld/+mCuDCPddSc9I27NVAQcoPhW1LWTv
         6bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712641034; x=1713245834;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHsEtZCKaHOJpKzkmFo1QTaciQX5xyBED5wwHFx24rA=;
        b=idLOiuBPtaztBilsCpVmsmrRaoPOGCO/xxyfBRQpzyltcH0c4qoVbL7MyL/S4uZZ7Q
         bmgRQoryQg2LxflMCndZxKFWQ2SDdWmc/71UAAngnlgl+jJv2U8b/p/FKAttcaLPIx8d
         LgLwWrA8ZEGJmEDd+6FH7zQz4S5p/zq8IWWnP0VCrvajfHM8ZlzGZ2+O1ND8JefVD2OB
         QBx+IJmYSkaDzVzwvzncxJsHIpQ6bNGEevipoKs6ZyZdBcuZTzEegw5bw0HMkqC+auni
         pq/szO39SQ00RRX+4xSs1qibl3UMf5r4OMM1DOFm6BSpHlFGh2gKjLltrSQF7N4C61Sf
         vLaA==
X-Forwarded-Encrypted: i=1; AJvYcCX+GAT3Pv9SkkvUdRP7fXgVByz05ItcL/5HvPGXY93Smiro2HdoxFj+j9NrGAgn2PO2/83P5nIW7QW7Ut9qsAOETLmxPyw0sbJ/
X-Gm-Message-State: AOJu0YzS9WrzJbh5EdDBJn7TbxON5Vs0z5eMwiIaY3bPpgkb2fXwy6wc
	v2drkBsVRdOk6B96rV0XYYLD7VNdgMv4uFaGmXQxDtT675WivTqLyrdko68Zr4W/1cuhoMj+H7/
	ACPqKUae2JgZHLA==
X-Google-Smtp-Source: AGHT+IFVWQRJuqt+RfUsHPn8GX0evGqrx/pn1nt0eRiDqqPwuJeYG8bIxyrI0zUOLfzh2v9qJA48jtkZ7a+SQoA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:96d3:321a:67f3:5322])
 (user=saravanak job=sendgmr) by 2002:a0d:d983:0:b0:615:dce:e3e with SMTP id
 b125-20020a0dd983000000b006150dce0e3emr2755710ywe.9.1712641034295; Mon, 08
 Apr 2024 22:37:14 -0700 (PDT)
Date: Mon,  8 Apr 2024 22:37:02 -0700
In-Reply-To: <20240409053704.428336-1-saravanak@google.com>
Message-Id: <20240409053704.428336-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409053704.428336-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [RFC PATCH v2 1/2] Revert "treewide: Fix probing of devices in DT overlays"
From: Saravana Kannan <saravanak@google.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
---
 drivers/bus/imx-weim.c    | 6 ------
 drivers/i2c/i2c-core-of.c | 5 -----
 drivers/of/dynamic.c      | 1 -
 drivers/of/platform.c     | 5 -----
 drivers/spi/spi.c         | 5 -----
 5 files changed, 22 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 837bf9d51c6e..caaf887e0ccc 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -331,12 +331,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 				 "Failed to setup timing for '%pOF'\n", rd->dn);
 
 		if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
-			/*
-			 * Clear the flag before adding the device so that
-			 * fw_devlink doesn't skip adding consumers to this
-			 * device.
-			 */
-			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
 				dev_err(&pdev->dev,
 					"Failed to create child device '%pOF'\n",
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index a6c407d36800..a250921bbce0 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -178,11 +178,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 			return NOTIFY_OK;
 		}
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		client = of_i2c_register_device(adap, rd->dn);
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 4d57a4e34105..19a1a38554f2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -224,7 +224,6 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..efd861fa254f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -743,11 +743,6 @@ static int of_platform_notify(struct notifier_block *nb,
 		if (of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_OK;
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(rd->dn->parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..17cd417f7681 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4761,11 +4761,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			return NOTIFY_OK;
 		}
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		spi = of_register_spi_device(ctlr, rd->dn);
 		put_device(&ctlr->dev);
 
-- 
2.44.0.478.gd926399ef9-goog


