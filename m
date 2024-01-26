Return-Path: <linux-spi+bounces-860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F383DFC6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B009B23432
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D452260A;
	Fri, 26 Jan 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybizXlmU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664DF224EE
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289367; cv=none; b=ummyO3sFvuYHEx/06xfAn/uVIA/2wmEQFlBcV4s/OJGbhOTC/L4WwsqXlqpNBrTP0tlZGUWlT5RNymKKapECrj+5mJCRiK/mbLQS4fFroudK94kxkUu7bKUjF6m5eEOIWST4PpopGR5y/hncC/7dSrR/5HcePBRm2ykCU30fl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289367; c=relaxed/simple;
	bh=qd5gH6HA0zeTl7vAn9ID3bQtUYcxhzqMjBdEahDK+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbyHii1o0rB7Ve0SRvs7JxovB/vql60iYWjOX+Gq+rucAqjmiRaHITpRXX/mF8bgpxyCZwGZyCnRy5DqbJuJaWU2U8b9BCF1VQXnirQpleySZjzHwW+Gj9HLIj56Ovt7s7B4owNltOEyxE54cjfK04W+n0rIyM3IteUIJVXCYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybizXlmU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ee82d040dso5844395e9.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289365; x=1706894165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGTNJGu0ukXFyt9xeb5mPdj6cnncaL6QD7HHX08zdSQ=;
        b=ybizXlmUgcZxVD2fq5vgJRFnwNeBDtqx74C7Dh2yPyZWojprfqebJoCwlAOHvgDXfF
         CPDvLC4+AIeRjHm9sQCQNY+BYaJz/VfY47C7j7kFg00COzsNwhi4RId73Oi18E3kdG6A
         02f1nBrYvVb0HlH6Apptg3XCOTKVY+Fmy40njzdaDXK5A6RwIj2JTf12gSHBwxivNfQQ
         qhLNzN6a+O6hCyC8znVrSJiHw9kKBUKOwwv7rSD84ibyBI4OaCHJHdws4kAEM8M108v5
         T4NzC+eAk4Ab0OmLPWl2x5BoBujX7WTZtIwd1RhKqU/oV7v2bh5uMEVOGLlYXzT95VXC
         hVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289365; x=1706894165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGTNJGu0ukXFyt9xeb5mPdj6cnncaL6QD7HHX08zdSQ=;
        b=UnYUushJsWiM6DZkyEb/ElYqjL+NlV3oA2nypm/E9RCABPSiPTP6aVUHuG1YqCSWun
         JPXD1bUm/26epPyQhJiuqOWLxWB7w6UGUT78+ifF0Ansvs9vMRFRnVMktF9LN/gkCEka
         neO8ltzRrvMMgu9924boXlpBE1VdbmlEC/llFzefHlNMZ5fEYBRKHOO2x6GMUpjAOA6v
         JQxcCYs+As5hUsEFh+m/vVkmcxwgCvmWUYPWwdZTCOhTTiH+97YG1WuGHBXnkJkDVYx0
         A8STHXTS+lVRRffH6RfaBli8HPuo8EBGq/czC/KkhMDAXQdOdbkX+z+16vi3yFGg93fP
         U+Mg==
X-Gm-Message-State: AOJu0YxcgQtYlMMyZ3plsAUKsQUUoo6Y37eeh0i6rYk8Vz3oZQEwe4rn
	scH7izZaf4doy8uqBbeDvi60zAEtR2HKs7aTAb7zIaU0tUEAg1yM6Pv4Gwpco4I=
X-Google-Smtp-Source: AGHT+IFm06n9bv4+cWRnJ/uDg+/bPG8VRaqfbnFy+FN0Vjs4qRwIYkxG124p37ZXa85vCR++v+/zDA==
X-Received: by 2002:a05:600c:22d5:b0:40e:863e:2f16 with SMTP id 21-20020a05600c22d500b0040e863e2f16mr76277wmg.128.1706289364833;
        Fri, 26 Jan 2024 09:16:04 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 13/17] spi: s3c64xx: drop blank line between declarations
Date: Fri, 26 Jan 2024 17:15:41 +0000
Message-ID: <20240126171546.1233172-14-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the blank line and move the logical operation in the body of the
function rather than in initialization list.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2f2c4ad35df4..08ba14adb428 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1320,8 +1320,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
+	int ret;
 
-	int ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
-- 
2.43.0.429.g432eaa2c6b-goog


