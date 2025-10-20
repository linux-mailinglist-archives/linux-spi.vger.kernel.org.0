Return-Path: <linux-spi+bounces-10728-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CCBF2880
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C52F18A4D67
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7239330B06;
	Mon, 20 Oct 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2d3D0YC3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83532F76E
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979122; cv=none; b=sLm8NCk0Zj2Ljuz54edSIdPKPfdGCKUfJreGH+qF0AYIz5H75AEKXZVBEBmxzjN/j510haI2v0iBL43D5iTZlhhOf1ti3yKtG0gYcRkjj2MaDaCreBtpjLI3p/b34Lk3zjykSDgZ7LeRoSKerOkSc7u3JXIWrmTAECn9Qumqsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979122; c=relaxed/simple;
	bh=gzZET6mP2OucMjDQ4thYViOeZ8/OsV2OQsQvxJj19l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7uOvOfzWuGpLe4Xlb+E5BDeJ+68zhU5Yl8U+wrv/7z9tq5569EbNR5whYo0JJH4Q6cD6eU5Mt1hSY1B2qbTcZNGoflPPHDQw5I31K6MwVR4x47hGogPcuB26BE1az6nfzIYMVylOgGKE5lIlIWS1Z3tbCdHCEZOXBaSna2YLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2d3D0YC3; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430d0d37fd7so11746135ab.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979120; x=1761583920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAFHx5Fe28+JucgqjXAxBLPfwtGRK1k39/wAp21/umo=;
        b=2d3D0YC3K3FJP52bQYr6pQ6xtsimF+G9blY4Uwb3rne5njWGKZYidz14jLmTgx35SE
         X1UM8sCtqPdT6O3UuI+fzsGAQfzyEzEEn1VkrpkGsBTNPx4aWPs3y9R9ZfFm4ukdtP8e
         ZFyy/bSPrh4joBEe/zIp86kJjkar58fwzeK9ewZYONp8BtpS6pHhAdqyMfuTFWpEMNUN
         6FcsKWaLclMDpxnsvYt2n5fY2ufVFr0VYwuoWm99AVaJZdedHMYB+wlTfpINKmgaImR/
         9lPEsp2DKOCwTFRp4t0olR/2Vpq82fT8zeuJOVSyR5WIOm0k95oN2zsCM8ILpbWH7F4Q
         47mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979120; x=1761583920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAFHx5Fe28+JucgqjXAxBLPfwtGRK1k39/wAp21/umo=;
        b=a3m3sCp+N59Wk3vk91qJvwbOk6zuexcnd5nXIZMQaXrGE1OCre7lzgLAWc+MUthoVN
         qRiGH4QqoeFqpHmfUo7tW+KZMcQiY16YvjsrKZ2x7CJW/o42BTRfIZa0dm5tbAuu7vQx
         ZGa7WobyjAB/fyCsso9tltm6SD7JN3cSFTTVW7MEH2XAY8RxNXKK9YCnbwnvR41pavRe
         X+dBYoN0xVGr5iXnnM7zI+UUeXBBQrRksMmRQxDb7LxuYnIqEoJywGwz/rKql8gun9PO
         P/cknieDxGGUjcuNyg35MMBJ+M6xnQjsZkHyyvcwXLaYt1aRtx55SKjRwa7y+6C4OwmN
         qnqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRY1BacCe0oreF+Rg7GQRGt6FQA8n3oOqstAbt+kCYtAvw67LHGg3/on13B1lX9ZjOoo60W5k5Pj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAThpKvl0u/5H1aa+2mdj7VnhABphaTtJPPHpH56Z5HLsgf4Jc
	KFHROvJzUz9T7scER0RIua7t6pbeL95pTg390h2H1FqN/FXm+jMiYz5CLOy3r2ivpxE=
X-Gm-Gg: ASbGncs/OHgnDCnMZF2e7Mvd4zeugpJpS8Qpen175LTX98DqQj9SZ2OvQ2XyK0K1ZHs
	SFA8oJGTAD9CM2rXjfv3MDs0swHCbnI2IlG5XY7FUy1IyGkFIW4r1JgG81fBo5gscFxZNsyj17I
	exum/iL0Qz7Ya6/qvGDZO++vK1Z5nUF8fD4CsiQaPug0+ACxak/J0xdNJKZRt5sLcmrz03vvdch
	tHRUxMeKwC5l7+ZPuV28tAF+FwXXLXqRMoDBvxqccF3p9LL5OdP9b0+KhbC2hxn09vVPsbQZEkE
	KUD9DnKHI4NJ5J/Djvoj8/iNcvG6c/vsATXpoqo9bbByfG5e9VFnvnxO01w/gWiwUPYKBmEd4i2
	9Jbm0tFR/0HoI3XEQwpogV8nmXGNZjfnIuQqIR2nAZBbj9fOck4001JzvQB1UBu8A6jOwSQhZRc
	a28zG15mI+gvGkBVKKJYczlbdgW+AWVKQek4kptm6Wub1m0T5+SjYDcQ==
X-Google-Smtp-Source: AGHT+IGrysi/n+6wy3sDQX5W8PX80X7sxp0qMRXdkSjXbUhQItP2k8/GDMxk0YCbp0Wy5FwbdhktFw==
X-Received: by 2002:a05:6e02:3e8e:b0:430:ce63:4180 with SMTP id e9e14a558f8ab-430ce6342cfmr168487305ab.8.1760979119873;
        Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Mon, 20 Oct 2025 11:51:45 -0500
Message-ID: <20251020165152.666221-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 0315a13fe319a..5bbda4bc33350 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -22,6 +22,7 @@ properties:
           - fsl,imx6ul-qspi
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
+          - spacemit,k1-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi
-- 
2.48.1


