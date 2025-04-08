Return-Path: <linux-spi+bounces-7444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9061A7F6F4
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 09:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4769D3B9D16
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA427263C68;
	Tue,  8 Apr 2025 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Rq9GXA5S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7362638B2
	for <linux-spi@vger.kernel.org>; Tue,  8 Apr 2025 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098002; cv=none; b=BnTppcdiPKGCmY/aLrCXmtaWRivYSaBLbAtfBSTRodvjmujeboAqiWcveRyJaeOloxigWFFkbbsNML+iLC3Ckqf6GcpM4uIGmg7PRgXBlhkJYUxETpiMFpgNKfolsQPLkUEs7axdrEvV7fM5+oPvf3JFlWjp4yqQ8QCZGNOGXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098002; c=relaxed/simple;
	bh=yY1vgyDd8wMt1OyJ1nZ5GgiLWpilaKVfdLDAwj4zDMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HR7ywlVTlmSdUtt5XOrklPN2f46JMOQq31uV80ND6xAT1q5s+KQiSo87B6Ac7rEVQORnKynsSul9nKT4DI8m6qa4XaIz6/0iq39k6+Z+mHjRkWSsrK87njA3gosFCVmsVe2spyp6XgQhoXuu5zRGhk2J2uyKQhV1aGDHDRFdTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Rq9GXA5S; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913b539aabso3013945f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 08 Apr 2025 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744097998; x=1744702798; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzLFKKzd5monlWcdI4nxf5Z84XCk4SaHNdQAmnWtjA0=;
        b=Rq9GXA5SZNqCeQD2mYgl+xXE3NpNwlNOpkRtoQzwZCzLK9YZXZybYlN0kdVmptL368
         AkS3xs8CYhlIlbIYpeEqhkvdktsp4EL9QnzWCcH0JsyXPjzt1g4+kv2OiGQ1H/hbdUqo
         exW9THMAmU9cKcjC5UgBnsCIAk2cajLMt0D6ujO3BB+0WpmqZ8O3ghzm6d/nxo1YpSeN
         IKMakU8fcvffezuFWPBFLmZM5F0ZDSO+YOAMYk4QVRQi7ivYe6Atv0THVBTAVpoNpFdh
         W4GSWMwqGStPIn+PQHzw3rtinYiiTTB8X1Ho3wwiSy760lSmXiuoFSZrpZazmq9q4CWj
         cZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097998; x=1744702798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzLFKKzd5monlWcdI4nxf5Z84XCk4SaHNdQAmnWtjA0=;
        b=S4zIysPGLRAGR6A5tCpnbLtHQ9bsx8VFEzqpvHtvttXlMqfnS4gIocEGhaCgN91+Xz
         ZK+6VYLgCPilcxFycCZAcPPZRcFg+9oY2SoG337bWh3AkItFSx9d34ks6qBAoG6GtdQS
         BNahgvr/GRq+oZ7PRqrFpi7MHA3zjLrBRT+S5wbSgaY+eoMFSmfMT2Bu/3t8luRWwVmJ
         CZmPHYrWy44UQ3nOZ73DPlvugh1liGb/7zHl4Hiklxe7tXZ3AacRDZkjLijf6XMyDHwq
         4XaSQXvIh9nc0k8Jp+tdqa1GIZwNogIfz4mEThHzj+neBeeElYLj3kcy2M2QBL+tx5iZ
         uLCw==
X-Gm-Message-State: AOJu0Yzh8waLexVNLkc7BeU+/P8JOV51VnFN9p3rwuEY5L74ClYs4Cec
	wnUvmLueMHBtvMub+IU5w4K6xod9Vw7YzPgriepFScbIyGQT0Wrmb8aQ3Xw9xIE=
X-Gm-Gg: ASbGncse1LE28o+eI4MC20AvR19XTSnK/hKivNFxC2e6a2l7UzWdSQddpIdV8UMvpiB
	eCdwOKHtNRHKK6qEzBV/nqianwCL1Y+6Kv5X3I/cU9shekU7ByFrAyMmR9zmaKuIKLyYUl/lQJR
	piZ7PIBf65I4jpDTjM9w4lIcTQvHSNS3MW6DN4f64JDpaGTlNHFs1RG5ipH5hxBuiFKzIKtoJFt
	s2DqKMqBnHYqTerNEsBcpPIJv5UUdQ07nUbpFKNbNxOJwXsQ4V0ClGL15f/OtzIrD+MowJFUXS1
	pCTdjkmFKj18939KvGloAgSI0a3f6AvdKRKKVA==
X-Google-Smtp-Source: AGHT+IFBnscSTWeNc0kbRfBnMhse9CS3IWIkjIUMwm6j+QpSpPJjYHjtNIkqyww/lRRFUe7Se/td3Q==
X-Received: by 2002:a05:6000:2906:b0:39c:142a:35f9 with SMTP id ffacd0b85a97d-39cb3575bfamr13615953f8f.10.1744097997952;
        Tue, 08 Apr 2025 00:39:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342babfsm153692095e9.1.2025.04.08.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:39:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 08 Apr 2025 09:39:56 +0200
Subject: [PATCH] spi: xcomm: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gpiochip-set-rv-spi-v1-1-597660766654@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMvS9GcC/x3MMQqAMAxA0atIZgM1VYpeRRykxjaLlkZEKN7d4
 viG/wsoZ2GFqSmQ+RaV86jo2gZ8XI/AKFs1kKHBWHIYkpw+SkLlC/ONmgQdedON1tLeO6hlyrz
 L81/n5X0/tz0HnmUAAAA=
To: Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=UWSVaYTx9qsHllGeuLrfbRAZU1erxA1Jg78sg4AxvDg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9NLNSNlnAzpqfJnJvAMCxXAHB6VrSPj/6kR2x
 zhNgJWqJv6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TSzQAKCRARpy6gFHHX
 ck9jD/4xPWmB+Fni73N7cNG6zM+2V5MMthqOUGvEdwLf4iQG13MYHJn0kWkt1OOLf5M/iFMOP/C
 OI6s+vyvU/kiUf1vmZgju05+1htuxjRnXWQjP3FY/UIgJXVrIlTb2LJp1IZwRJFBMmD4ebjRz5G
 WXg5RYQhyT1mgKFn2NKMdhvRhYu0E3TDOAQ4eVHWwe7B/5RMKvo0FHYOAvPLYYhCJZPoIP2eaKn
 zOA7qjZgA0eUmJT8JxIX70Up+6Ag5X5SI9Vq8kM3Vn+ky67KFQfHTP1BLSYBlKm1GFhyR3wL4Rk
 izNm4QeVas/ZLdbRl7AfOHlOhYMVprk8DWR6GGoctr+KtRwLIOKUhpaK4MYeB8ISY+ZIFbw2BLK
 A+PLEop321r41E3CubUm8DA/P2qO7onyIBR5Z8pcu4C0rawreqShv0BOrqIWlnj8EQpt9+vTCqK
 ABk7ltP45GuDWsdw8x6byH77AaRpvcKFfBGbyjB1KO0FDqalSE9ckjgRkJU7cRtAVJNdYWZBTec
 dG8A5SlZxJ7WuCg7prHi5MvO6h41iwASCMO1nrdpFoJpkB0Kc7AYuwFyRpp1VbacOLe/TuN10rW
 prIxhDPWdPzf3wg9Kr/9yjGhO/7nsMk0tPF+CirmxtrhyOwni8sQnXR3aCtEEi06MDgP3lP+R56
 fqQBKO2M4GagZKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones.
---
 drivers/spi/spi-xcomm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 3bd0149d8f4e..1a40c4866ce1 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -44,8 +44,8 @@ struct spi_xcomm {
 	u8 buf[63];
 };
 
-static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
-				     unsigned int offset, int val)
+static int spi_xcomm_gpio_set_value(struct gpio_chip *chip,
+				    unsigned int offset, int val)
 {
 	struct spi_xcomm *spi_xcomm = gpiochip_get_data(chip);
 	unsigned char buf[2];
@@ -53,7 +53,7 @@ static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
 	buf[0] = SPI_XCOMM_CMD_GPIO_SET;
 	buf[1] = !!val;
 
-	i2c_master_send(spi_xcomm->i2c, buf, 2);
+	return i2c_master_send(spi_xcomm->i2c, buf, 2);
 }
 
 static int spi_xcomm_gpio_get_direction(struct gpio_chip *chip,
@@ -70,7 +70,7 @@ static int spi_xcomm_gpio_add(struct spi_xcomm *spi_xcomm)
 		return 0;
 
 	spi_xcomm->gc.get_direction = spi_xcomm_gpio_get_direction;
-	spi_xcomm->gc.set = spi_xcomm_gpio_set_value;
+	spi_xcomm->gc.set_rv = spi_xcomm_gpio_set_value;
 	spi_xcomm->gc.can_sleep = 1;
 	spi_xcomm->gc.base = -1;
 	spi_xcomm->gc.ngpio = 1;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250327-gpiochip-set-rv-spi-72c019332f47

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


