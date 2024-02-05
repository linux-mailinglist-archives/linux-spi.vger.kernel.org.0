Return-Path: <linux-spi+bounces-1031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26693849AB3
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB811B267DD
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06D1CD1A;
	Mon,  5 Feb 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/ec5aA6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367061BC4C
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137124; cv=none; b=PJOv7ngkG+PorpqaMq1E2TgPJulalRJL1ItCcOB2M+acpz4w1qxYoe/bVnZQegY78Dq5GF8c8UnRNvv63PWvkdNjtNHdxVvJO2THZ9Iy/hbfH3AqNTriZaS9KyDf2cU3S1HHSDM8hL80b/DnxM9l12CSLRrnyxg4dRSTZ4dcNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137124; c=relaxed/simple;
	bh=Z4Ew4nyDpzzGo1pM+lRVxGZLGFkSY7f2fYJqWCwnhYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZSCBR0CfwU5dtC0M95csonjkCgHY32pMlBnkchD6Q4NgVCpuy45kUNsCQzxVArpV+XnGeqZ5PPK72wyAuE+GVPqkA4Gp7RAcgkGjfhHVzT6bcUgAbouhnQ53+U2K6ixeiB/f26B75TZJ4kecg9ha2A7O+V3/BrQhiLViMPVPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/ec5aA6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b402116e5so346174f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137119; x=1707741919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0iJZWpnXVMwkvXpPgSJew7EEo1nTNBnfpPHvIQNpUQ=;
        b=S/ec5aA6xqbeO1ETXeGMa00Wm505ZPWRGAPg52nwg7JZOmu+piZT83yVfeNev9Q71K
         bJ3wzhL/M3xn1sbrlmz/sDd9Q9PuRKplPTYuts2WVE+zo+bs9+OoMAv7y+2MozG3Wnxw
         VIHz7AN2NYDfqArq+kOTd1bOC8VvP5QkWMeQkDGSfPNCKZjrVFR1PwxCjBSZrfh9apiZ
         qvkIN+3nW631VEgCgsHHHZRWStCIToQgGNEC7qX0z/WkZdiwkWbmMFLoN13DBx3KAjjx
         pQawH0EWQ7X1VHZV4YttzkP99ewrsRT8AbUVhoCRyJdyQI/2hBFsv7A7d+r3jgcZ7Rjc
         3seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137119; x=1707741919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0iJZWpnXVMwkvXpPgSJew7EEo1nTNBnfpPHvIQNpUQ=;
        b=ICWEWwCvesmlwEMw0qARZ+fLilA2/Qqs70XLFphBQBhg/XlKUPESdpzhvR5dvmwSZ2
         LxXhfMG3Zo92avDBWXGh+N2TBzalx/aHREorjNpsH6EiIy5oZIqgqoVnSb95PP9yW2yK
         V5QYGBNXn8hlis2kyxx4lAf/U9tKz/BfVAgqW/1ra/NsrlXGmHda1uNJAQiw89cUwlXt
         Kq3aF98tXohXqfuYEg7BmCI4lrg7MRlXNLkGcKLqCGCRITqKjzl31oMrVTBpwOz1dcms
         a0GJD2UpF+CwPPtdsc3wuEF8Ex9gDIRd91zLaza9IqtoyoF9yJ+bcdoxxDUm5T8ST869
         QFYw==
X-Gm-Message-State: AOJu0YygwJ5iu/yJtmAPxhh4pPV9FoISvHmE0n60Ime6xBA/Uku3oUFx
	6fdryjSqJP1QdUw1knV7Q/ZRiu5PIyrqSSUm7q843W/ulSGV+2F194U/FvmWyu8=
X-Google-Smtp-Source: AGHT+IEUTeDGMe9y9Io7d7vPFXq0/9oe6SH6ovhiw0963u3mRGK3Ub0ZC51fMHi6OyYN0hVu+gFbCg==
X-Received: by 2002:a5d:5889:0:b0:33b:421d:bc01 with SMTP id n9-20020a5d5889000000b0033b421dbc01mr937267wrf.69.1707137119533;
        Mon, 05 Feb 2024 04:45:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUahAXSvTsGA1585DKwqXFbQPhNA509hGouEFV78sopzS6Q+jluFeON2uLS/6ymTrU4IdZf56owEpKf/7Xq5dTT2fQTav0F9l/XLuL2m55hmDV1Bo/H4owLu/xUAiXgKIHz3Sy+4cAr4wAKB4ie1RWdUAQC+Y6eTIluyUepqtaPTR5Ip6RuWjdCy5jzQSzEfHOIPPAOOal1XQzCPXaJbtH9N5geE7MB3mjL0MtAL8bNebGI6+HzhEFrAR9+IxbPlAGf78worWYfixaftWPQ+YUogMJy92aAqgos1bmCRmWeyCLrlcsoqr+J9zD62Z1fhET61waZ4kgPlJxq5c8Bl/6PlfsLSDSFnE85zeKOqCrlSbcUN+ztFYZOfid4qeWX9oW6jHVdO0AXMpEFlm/jmiU92IhIw/cwRAB5UXAa/SHFVGDfusu2ZEDM6/75bBZDG0js0t5focKja7CPw+6gyZP5TCdxUf0xszz7mnWypT5jC6PosY5XchFNLKmlUg==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 03/16] spi: s3c64xx: avoid possible negative array index
Date: Mon,  5 Feb 2024 12:45:00 +0000
Message-ID: <20240205124513.447875-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform id is used as an index into the fifo_lvl_mask array.
Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
thus we risked a negative array index. Catch such cases and fail to
probe.

Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2b5bb7604526..c3176a510643 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,6 +1189,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
 		sdd->port_id = pdev->id;
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


