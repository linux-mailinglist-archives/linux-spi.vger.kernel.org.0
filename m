Return-Path: <linux-spi+bounces-2238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49E89D202
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC08C1C221D8
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ABF762DF;
	Tue,  9 Apr 2024 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAj8J9CR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7A138E
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712641039; cv=none; b=UQAdQsT3F7F2ISzTgWN/+iHmNwAMUDc9QAl7R+X6rKFeVYrYNRMx1oQoZxbgUzcd7ZDVVnXo9vcqQD7XrXUc00AiuQqJv06f6VNS+ygXa4UbtnJrCDcbxrsre4cQpsgeLO0gz53fZ/vivfX1DYzc6SP8wOG2BZbjt3xGi+7k7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712641039; c=relaxed/simple;
	bh=wkLOEX+/YulnkTfcEPKaLhHUYq2+5Yqcely2pOg3H0A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=L52XePVBvUw7ke3ehDHJp4fNOw3XdzRpJrVdnVhLDY1p7CkhJph3eUeJC5Gl0c69RET1Tm5BrhfwDgEQ8jEMe/yBgrupx7h907cmzogNA73mSP9k7zzGxzr1mcXVG2cD+bhBLN552SliKW7ZKXkpgL2wONXg9NCbi36RBUiIxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAj8J9CR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so8219057276.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Apr 2024 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712641037; x=1713245837; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1+matSQcfLvW/X39T9zNDkLhGrOhW1miO9PFu3HhWQ=;
        b=dAj8J9CRK7jnTlePkfHw6DWCeHQlWXV0svgu9pc2HNeFt7WZ6VKpDvjYwRCU5G2r2p
         3EotlFDLBLscOqLS5TueGxmmOEFrs1hGBxwjhCogwZkBA1z3c6c+mkUJEo8Vb5GlsYRL
         AfdDON5cRkwGo0pm+bUA2Vnm/nRNjS6jjvX2/bP/RUISSpo331pBNeUx/9GQwlrCHgNx
         DURGuyagqjetgdxNs6yJ2hakbcIbuDUIZSPeobMOAQ8l6r6vG06BS3UVvwF0Tf6Xis2r
         Ux0BotzHji1oCT2m7zUn00LzBYuODhbRn/IaQ6MXbk8ae0ZDrJBe/abk3Ncb3CP4g6R2
         rqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712641037; x=1713245837;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1+matSQcfLvW/X39T9zNDkLhGrOhW1miO9PFu3HhWQ=;
        b=wfak+7FCCoOPDc2RuTVW/uyB5hy/Q7z8siEXZpVCxFlx1B/MhQKr8YPnuw4JLx5Dpv
         uLnrCJ1WSRSd63zNkDH+FYRO89MA1uKAdCqCeLrL2L5teVRyqJKbvEVmiFa7rpuQCdjE
         jzW5k2dtidEgV6h+4KIReZCW00FsEcnO5prtc/bCkW5fKWReJrf4oW8bY89ZDDcRwIlY
         W/h4FJNWR3xRhDtg90/d5TfyH8wLs2nbRS0nhlxvK+zDEkWiLSczNABGymyuWC1nt7La
         ffBmicWdI4SXRL7Eb+RSZfjK4OF0w0+Esan6Wu4/Dol35ieVlgxOYnC53NY5w0jCkzeb
         RqXw==
X-Forwarded-Encrypted: i=1; AJvYcCVnw29fMVsGnfIhBfMg2d0Qx4vYV8nQwG3L+v/EyOpeBLYfqMRvHXnC2VEDN2ts9oP8EddHR3OXPRKxqcvKWm0xnchKcSixSbAL
X-Gm-Message-State: AOJu0Yz7faclLB4vrp2MKf3iPkMQeEA9lh/O6Tiyv0AAbuMyYFZ+xuCl
	hrzy5KFys8uQ5cGdMu20rIN3tTX7IlLiqp7QDxQoYbVj21ODYr7EsGhw2bRR3Ef+IthUGdDNy8i
	arhqllsTWQQ5bqg==
X-Google-Smtp-Source: AGHT+IHRQA3n5GfF0BAtqxsFhNOUIMEXcJ7+XDV5u7QRPNR+Gdp77qx8MK2Ot4WCnaL1W/7lk2smyonaDUUJGAU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:96d3:321a:67f3:5322])
 (user=saravanak job=sendgmr) by 2002:a05:6902:708:b0:dd9:1db5:8348 with SMTP
 id k8-20020a056902070800b00dd91db58348mr3605580ybt.8.1712641037031; Mon, 08
 Apr 2024 22:37:17 -0700 (PDT)
Date: Mon,  8 Apr 2024 22:37:03 -0700
In-Reply-To: <20240409053704.428336-1-saravanak@google.com>
Message-Id: <20240409053704.428336-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409053704.428336-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [RFC PATCH v2 2/2] of: dynamic: Fix probing of overlay devices
From: Saravana Kannan <saravanak@google.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Get fw_devlink to work well with overlay devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 23 +++++++++++++++++++++++
 drivers/of/dynamic.c   |  1 +
 include/linux/fwnode.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5f4e03336e68..5ce33dbd7560 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -237,6 +237,29 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
 }
 
+
+void fw_devlink_fixup_new_fwnode(struct fwnode_handle *new_fwnode)
+{
+	struct fwnode_handle *parent;
+
+	if (new_fwnode->dev && new_fwnode->dev->bus)
+		return;
+
+	fwnode_for_each_parent_node(new_fwnode, parent)
+		if (parent->dev && parent->dev->bus)
+			break;
+
+	if (!parent)
+		return;
+
+	mutex_lock(&fwnode_link_lock);
+	__fw_devlink_pickup_dangling_consumers(new_fwnode, parent);
+	__fw_devlink_link_to_consumers(parent->dev);
+	mutex_unlock(&fwnode_link_lock);
+
+	fwnode_handle_put(parent);
+}
+
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 19a1a38554f2..a2ad79ea9a06 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -581,6 +581,7 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 		memset(&rd, 0, sizeof(rd));
 		rd.dn = ce->np;
 		ret = of_reconfig_notify(ce->action, &rd);
+		fw_devlink_fixup_new_fwnode(of_fwnode_handle(ce->np));
 		break;
 	case OF_RECONFIG_ADD_PROPERTY:
 	case OF_RECONFIG_REMOVE_PROPERTY:
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0d79070c5a70..230aeccef6f3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -220,6 +220,7 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
 		    u8 flags);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
+void fw_devlink_fixup_new_fwnode(struct fwnode_handle *new_fwnode);
 bool fw_devlink_is_strict(void);
 
 #endif
-- 
2.44.0.478.gd926399ef9-goog


