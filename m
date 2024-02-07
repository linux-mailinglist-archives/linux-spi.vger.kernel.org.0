Return-Path: <linux-spi+bounces-1155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21C84CA4C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D081F29F2B
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97E5C5FD;
	Wed,  7 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHC9BZ2V"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C35A7A8
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307496; cv=none; b=TUGwTQ2bGeEy7c/HmmiOUudODQ8xurQvcECZExXpfBokZGVBcVOAgasynIufpyenaK4R8X2ZkP1YpsPhViLv7eEo00LJHwUwddSnYxrnSh+Hhn677TaLsBScGR0hJ2Ip3ndfiXRBrzA7FzuxHr8maLxgofrXlfp39DzeK7Ukavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307496; c=relaxed/simple;
	bh=UUTdIh3Xj1RnoDrVpRDf7wnRZi1N2KMZYs/hAqRGeLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7ib1Fhyx9Q3fH/3V93rzl4ceMbTiEb16KwwdmlXnVT2xuzBjUZRRhy6TcKcbUbLbFYD9xYDiIHLS8CoO9YgRGapc9E4OZXSierj61PTxEQvu0EqHf3h/UCjo5Svy4h1K3qYk3ETCX2wuI9JITgGSgIw76xaavecMjtbGjEPscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHC9BZ2V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394ca0c874so440264f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307489; x=1707912289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyB/rIEWzg0qFsjqRP7XGwF0lM74d/iwYjphW748AMs=;
        b=zHC9BZ2VYIAuvCjT7sGQrvpL5XP0IlBLVfn+E3qKoNvV0C0ItjsMO1huR7mlFp4AWM
         xKhR7vsFeoVDOo5Sq6VVE/YAPtl6mwcQ+SiJ6HEbh1np9Cody/ChjoygE7mKI0CUfKvL
         DWjBbhSuZS1ywJJH1UwWerJEd89cWx5JtZ9wmJ20Sh/D+UOfLcIi5IEoFazw1ydR8zea
         1v6QZYGrU6LnH2lOBJLJz1Cx+FQmruUAhvzgLTIFbWhLl4vESbbyEzkIkeKv6BvLA5ny
         lJMtOGzWSWZjd2gGlUlFZv71ttPkcWnb2G9JtWjVcE/Rspq/w1sc6Ora+w7z+0BpXqwD
         tRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307489; x=1707912289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyB/rIEWzg0qFsjqRP7XGwF0lM74d/iwYjphW748AMs=;
        b=ISF0nltonpXhkEjHTjsOVE70mWkL6WkhH4r53aXPQwcwbtV/LbVWkV1DBcIE9axcFk
         W9m2woOYcn+BVNA6EedSpnNwrMOB8hYx3zY9LDUVzCllxVSb9ig/1hjLf1pCAWBDln5Q
         UiPai1DWkdl7kt+JRF3yxpLr38n5r/pvaEBPQrInf+dMyzms+jNcseEKltMi2kIy1V24
         9mrxccvN4vtImj+ICbEK6uwsVDIPiggnlWNlbM+x2RaAOeVdpwlJDHyJbiy0pqV6rO6W
         aK4YQ7pjjbHnhzCdGWIy9Xp+wskgRLrS+3jANe5kyq0no+28FCTk1Uod8Vu53b+zZxnV
         y1bg==
X-Forwarded-Encrypted: i=1; AJvYcCV4wfY5kKFSbnGk+X+0Wc8P7Lwo9zLH8vfyIyCRDLdggO8KdRlk0AoYmd50dnRwMXbR8hoNvhOoLB7RZPxlL+eyHn4rkEAxfjAw
X-Gm-Message-State: AOJu0YzA+igMi7NrlOKk61Y3ak/5+15qvyFwSh6FXnJyaOWCpKwQpONV
	la+wjqzyVmqBTTSWj1mIhcw7lzwL8VM+47BfNnoyPa6ZWANeZr4aXGpN/r61r8g=
X-Google-Smtp-Source: AGHT+IHLdYTOpuM6YVl5VQ8KSmozpR6YZJf1vCyR7Jm7pldciiKf3Zxcsp8BxcHt6HVkzpmmahJfLA==
X-Received: by 2002:a5d:6989:0:b0:33b:1ae4:10be with SMTP id g9-20020a5d6989000000b0033b1ae410bemr3112553wru.46.1707307488917;
        Wed, 07 Feb 2024 04:04:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPoi9waljrhcc9Du9f7ChdJiFb7bX6DdMzhB6TZiVx1S6gG/nPe729BwNqPKcVyZuuPdA0jWoPjSZwBlPwgoGv4/+7VcutaOWWT7HZ/3E8KzjuD0LOtpjL0KJJBvdcnNnl7DjKH9MgkFM+oOQxMagBpYbUSNp+A0jDqH8NN2oxDXjkv9Czp7X62NXW5WDOIraHpUkXlQrhFTumVMhvNi2/fuvQOmrhzuwXTN5b0Xg+BD8zux/iMilXXTbwuTHqAP03e4h0gtwf0TXw8YZnH5aDaUAcLltEVIOw3dI8iuambt30B7iLPUkTQcl5whcPC6+OBnzA0glExTxAon0OgcvfTnCNygZplHw+HOEJkdkfLPNEFmao4a8VIZQiPLVaARwFsy4ppTJHvaD9+xssFBf4zYZUcC60X4vqjIWfKWGON6SA6CBFPOQg56CTSps8XueWb71vVnuDitaohl0PNzBRtFUQfoQZtyrmFl5+hfaKawwtkHi2Hh19s739xw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:47 -0800 (PST)
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
Subject: [PATCH v5 11/17] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Wed,  7 Feb 2024 12:04:25 +0000
Message-ID: <20240207120431.2766269-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA submit should just add the dma descriptor to a queue, without firing
it. EIO is misleading and hides what happens in DMA. Propagate the
dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1f7356f6e5d2..ba17c5a04eef 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -324,7 +324,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.687.g38aa6559b0-goog


