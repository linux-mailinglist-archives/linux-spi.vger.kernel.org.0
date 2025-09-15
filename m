Return-Path: <linux-spi+bounces-10033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C623FB584C0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B74B4C30EA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222A324B1B;
	Mon, 15 Sep 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aevUUoVH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB31315D5D
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961468; cv=none; b=DsatRmZPeTCArsBEudfYBK7+mlOAf1qbQcJ8JHcrVLRTmOCya5ZNh8Hmzak7Ql53irGDcbM4gvaYy600XAXD9GzV+AeFx+SQMk3+0pRHHn6wI7eYBgISRAJv9mvAint4gU9KzIN0rAocZx7eiaA38IcUiCKykWndpIzJH1jWnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961468; c=relaxed/simple;
	bh=QAbUqWkSjFj8vv8re1gL9uKqrXQ0aq6hKWDoZOQJvFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSUF8PxJRhMx+26ixiM1FSxi5DM/ltnDqy2eNyo8YBU3q2BV4vQ7ifcCiSmv5s4WbYk8iNefk1IArz1wFRr0oxdvP09LelA03DgH1vl9HOgDzo2shpsp4MI+e2wu7ym5u7m/YV9EhLdHWX6FZ+nr3VhIRszOx6aZXNmdm7Hock8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aevUUoVH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0787fc3008so671010066b.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961465; x=1758566265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmTJoZFxd/UizIvu0+o0FQEf2UBZJpqtSSU3Va1l+q8=;
        b=aevUUoVHBmIA9VPTJJNym6BAw/UGnToVjolgsCMnPHcho+It9JFjgh/mQpXrINXpaq
         PgXDDgZlrKcWboxFc3FQSr81VkzZNVcXFnJzZF9H03HMQb4hPlURP/ctHq4yWK9hudWF
         8/Hr3y5WVknCbMJrArzKdJe9HjkUvucW0T2nVliCzxVnu/QyzxcD5eMq1OE7C0lITNCJ
         o6y82XfCj3a75Rg75WA0XYG0SHgogbtYunGzinpsrOobmGw+dqHuAHfRfP87pn5MspQy
         5LeUsc/3GDLySWPUaKT9Ql4YSKTNrrMfYszE0U01J/SMl23DmKRvXE3yGee6m1CXQTCl
         lGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961465; x=1758566265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmTJoZFxd/UizIvu0+o0FQEf2UBZJpqtSSU3Va1l+q8=;
        b=XQiUPDuRRmN5KqZ+WS9gpNxAF7Njb7rAk5G7MqD1Lwjm15zh+VLA2JG3LUa+3lNwHZ
         VbIuTsawwTCGaz80KZ0LGV2ouyry8prM8Mpe4dZTZj8j9a1Doez9h7iAQg9dwS8ezomo
         OAkrivzYiQdVv4Mr3hAVbKAKiauo79GEN5RfQt++CHYzVcCyTPSC++5QE730/SMIh6yn
         CEG+XNVZOp8SdQezsBvQ4/PMqiTdvDi/pDcz808hWc2YbYvyP61pNgwWQKcxHSHXAPVC
         vbxK0dy6WD5kBbP9LnzW46uaq79zi7AhWtBFvtwKLwCMzzVxDFcs99/4w5Y/EHEQFtH/
         +obg==
X-Gm-Message-State: AOJu0Yxt6GBj9Br5RIgk3Gr55G6sf6tfwvsh3Fnar3Cg/TnBXDR85mt2
	Y7Ffk1d7cGIDwsJNPKZ5Py4T7AsbOkqpw+cNQSFo70qUCc6Upy2mkxVL
X-Gm-Gg: ASbGncsLMKKSqJuqjZc+clK/uKHt5JC5rxdE10BXuvrwVPv9+FSbIv6DEBtTyN+2jIX
	fWsp4reRUkj1YAoNKtyoT7K+8FCVCaGx/sNuPhv65W+j6wrtgPvmUp+HymN2c9NScrk+U/ZLWY5
	usjz6H2M3T76jZZLS2g+Swaoiviq8PXma6l9dqE2kooxDtyF/KoDIFDj5z5nElg+eayjqa1RR7R
	poaobkb8IlEwNG+UZRwZC0xMEUqr7Hle4zhphJM0jiLP/wyxL4Ec16jp1xXaXEePuax0FfwcYDh
	ngVrQ9N2inyIJUaonKSc+9DF2t3anyebtdHewTivv7JfW7eKW4upBFq2ApTUpGx5HubhQ1JL7Ne
	ZvgPsaTX2gPE/qDHPxnXx/fAj+JAQmCLS7J9fh7P4+UMXAzpmfctkZr2oqme2i8y/ZHn1AXG2iX
	OiiHM=
X-Google-Smtp-Source: AGHT+IGWgnAO5l3hIYL3IEZLVlHRwLHiJ4By/g9hfpqmnTd2frdisat/kWwywXjBeT9mDnq7CCvwzQ==
X-Received: by 2002:a17:907:6d29:b0:b04:85f2:d26f with SMTP id a640c23a62f3a-b07c35bd9b4mr1581764966b.25.1757961464914;
        Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd309sm991919966b.53.2025.09.15.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 6/7] spi: reduce device chip select limit again
Date: Mon, 15 Sep 2025 20:37:24 +0200
Message-ID: <20250915183725.219473-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spi chipselect limit SPI_CS_CNT_MAX was raised with commit
2f8c7c3715f2 ("spi: Raise limit on number of chip selects") from 4 to 16
to accommodate spi controllers with more than 4 chip selects, and then
later to 24 with commit 96893cdd4760 ("spi: Raise limit on number of
chip selects to 24").

Now that we removed SPI_CS_CNT_MAX limiting the chip selects of
controllers, we can reduce the amount of chip selects per device again
to 4, the original value.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* reworded and rebased onto newest changes

 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 49c048277e97..df4842abbc6f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 24
+#define SPI_CS_CNT_MAX 4
 
 struct dma_chan;
 struct software_node;
-- 
2.43.0


