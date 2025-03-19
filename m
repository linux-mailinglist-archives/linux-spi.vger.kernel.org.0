Return-Path: <linux-spi+bounces-7213-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB7A683AF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 04:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F1619C6573
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139A24E4A6;
	Wed, 19 Mar 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+1ErBMo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DA524F;
	Wed, 19 Mar 2025 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354594; cv=none; b=A2Z5TS2VO6wOjsZf6lVDSiUpD8v/RZlX942ShwkBWeYkdT+p3SU7tIT7ECniAHi6ocBxPcejS/OL/IuZlYVlFKh/l2pgLHP4ESlFQ8lNTDttOjoR65RW6n+9XDJQdSyhSoj65oeTirHzTakXyKzcSURbdQ6r/ynUxCLTyGxKMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354594; c=relaxed/simple;
	bh=kKjAvj/AN5gYTkbsbr9Dtg3vdgdIpD2AgBSDbtGlOmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0N1kIFC9vooGh7MkIxOycxsPXl5RqI+mfYSQVacmomV4u23zZ3oeSbbam7kcTEdANItKkUI6qpngHwHfngJTR5zIfr4XGjmA5L91S4P5dn9TJ0XuKqLGEKEuetV3calhjfAcAVqP+f8v34vwW7P2nqsB9IULRVne8sqY9HGE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+1ErBMo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22398e09e39so136672335ad.3;
        Tue, 18 Mar 2025 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742354592; x=1742959392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTfA5EvYDZdhGTqIyHcGqcsQRwK5RGXcRhBZWZJHcs=;
        b=a+1ErBMoscIi1XI5N5b0W6JrVMN08uCWxoxk0oCTxH4K/f9Tado3uAfTBVYNzBaF1a
         KDeHkiCBSEQzJ/hoX65E8n0jQjNBgxr9dBpdkRzFcAoMU1ylWS+frm40nMguRQQcNcim
         M13/iPwo2mhLLl5MeUXEMB9/R/tu0Ws0LAi4YK+aja7872LOj1tZi0KWJBuwleexQTPZ
         1RxxA79sRYDpQwdK/fC2sPreQ//fbh4hWTM6CQmCOE/PudPs0gJ6s+hWBvPLzDpXSMV0
         DP9TVKMU9P/b0g/BKA8OL/cMFCJy3h+u9i5p6IspLYMkQaJ/ZPxSsOgWgex4C4ynvs6j
         CATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742354592; x=1742959392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeTfA5EvYDZdhGTqIyHcGqcsQRwK5RGXcRhBZWZJHcs=;
        b=OQvydOzjpVd0P2iBlLTwhWDETiT2oFr5jta/6UBOZj+J7JarAa1Ut5DHWE5xDVV6az
         xYF+cKItUTkqdLiyMsauAFBLFMEdYw1DHWq0+qtxXScFNRLcyD66gkWSkeaS1vbnTimQ
         yd+ySB+Xbp/6GZPT/flVHtD8IxVo5nGFC2GnEfXH5d/Vew543cbVUZT8/5aRq/qDkiJS
         nE6fu6U8QZEPOWBsfoIohu2/39/uUNwQ8GBoHlv7hMyKhr39g3aGNkwsfeAiA6uC5Qfu
         jMjPn2ovV8ZVu1t0JbjMo9X6zIebiF9ZHirYo4OnXLki/qnViPhPhiVWD0tZicMvke/D
         PP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVDjHR/axM+Ij12RdWi9FS43hqKd41RZs3SZH8xfPcgXz2V6EhJ+0a8UMnGJ2wFajxAg7q11Asyjx1w@vger.kernel.org, AJvYcCXaKnoN+8inXKcP0WXC9lbS7hZmf6wijzeINI/SkVjioQYuCvashSIFkjsTiiMVzaNxGxm62BzLYWTu/MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYx5csXnve+pDd1bovOqCuRS/VftXiO6aSvpfUiuc/3c1+R5h
	BaC6tyT4nrNmIky49NarIfvH0J+nOw3D38VafxQBKZzJy+yqIFKS
X-Gm-Gg: ASbGncu/WxC8NdtiY5OXuCLob8GHmcyrWFm3GIbuiYJnmPLQbXdooSOBW6I2zMzZjZF
	NqnnMFtGty4FTFginEcwH+oXdVDIs52zDA7jF4nqXVw+m0l+cDPPrvekn+64C80QrFO7hUGP8uz
	uWfJlIvMKIf0XkOQU5sT1c/8/PS/X8NTrTiBRWrZwo8c42eXDu23NDIWZzZT8V6GRQU+K40VM4V
	6dpuSao5Y/Q+GTo9iX6lAuCE8tB2WqB4zRRoH5A+XoX5xQmxoUt6N2ywLQlh6FKah0VbChQadQA
	i0+0eAIjJcFOYqJIYMYB0hjrlARPUDPcKJ8pz+6hmH0kyKkIbuQsbWELcNC9HpenSA==
X-Google-Smtp-Source: AGHT+IF2HGClT2t/YkULY9YGPj3N+zFEFj0PL3eDhpw9zJ/zZ1YETqaRj2KCXx2TkxDFDpecXKOS9Q==
X-Received: by 2002:a17:903:2310:b0:224:256e:5e4e with SMTP id d9443c01a7336-226498228b4mr18231035ad.16.1742354592020;
        Tue, 18 Mar 2025 20:23:12 -0700 (PDT)
Received: from localhost.localdomain ([114.254.9.37])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-225c68bedd4sm103109595ad.105.2025.03.18.20.23.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 20:23:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] spi: Fix reference count leak in slave_show()
Date: Wed, 19 Mar 2025 11:23:04 +0800
Message-Id: <20250319032305.70340-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a reference count leak in slave_show() by properly putting the device
reference obtained from device_find_any_child().

Fixes: 6c364062bfed ("spi: core: Add support for registering SPI slave controllers")
Fixes: c21b0837983d ("spi: Use device_find_any_child() instead of custom approach")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a7a4647717d4..ff07c87dbadc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2954,9 +2954,13 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
 	struct device *child;
+	int ret;
 
 	child = device_find_any_child(&ctlr->dev);
-	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
+	ret = sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
+	put_device(child);
+
+	return ret;
 }
 
 static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
-- 
2.39.5 (Apple Git-154)


