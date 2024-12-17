Return-Path: <linux-spi+bounces-6070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A959F4A20
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EE1188C155
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBB1EE031;
	Tue, 17 Dec 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V52EU7mA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063091E3DF7
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435762; cv=none; b=cnyhSqy1Rpqf98jVf2lbcLI0T3d3JrvDB+CNs2T2t13fx7ksGK5Lm2DhVKZr1MQGovzH2EwMtwfIVajSwHm+zk22j7SnGvTY6H2BfmLyqBrK57DCC/f4TFO0imZ2csJPSKqqVslwa0ohyA0hHOQui8sh40ory9hsDR66ccQsup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435762; c=relaxed/simple;
	bh=LkzV0DNqiGsjswwnEyCuMp6HwNDTTsH5J5bUCq7JnYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNhKYfGTjFKLScDbwbhvot86RSFDbUCjFx2ZjhELhWo8kMVi8Lj8wBhzV9Z7x6HI5Kdxyc9YpoOBj6qEm3gyBSK6/MypZdbVd9AABCg+tAZJuoTcZi7riNI1VChtWwSxLjOBK+NEuRWYY/uZOcqcIpTennJhkwx75W2z4KgubTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V52EU7mA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so8748979a12.1
        for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 03:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734435757; x=1735040557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArUfcZBAvAGoYlUyBKoJ/IMMXIGurHTq/qsX0ml077k=;
        b=V52EU7mAruvTU1AjvLKHXsBwUylzapGOjXHWyK6r0wLZaPP+6yZnL8bUeVQkl76nl8
         xsCjGy1gEhCS0DSZU8b1JFVEwiAkMwnaOVtT3IFdM0Hs2w3GjF30eAJECQQ0ALq6+SUJ
         HrUSXCPwt0smN7vzVUejeTJE+w/TVIMHbqs6Tv71KLYKAmO60A3NR2CYb5UNSYChM7jf
         96xGhQQZTaQmHWf9kadoheNLvOhJdv+c99KcSmSa1FG8W93ah4Q0JCIFh9OBhKGSWHd8
         roAR8hNeVwaBPGLtM6XYcilMg2m+yLhBwL/ppixJ0oC0M6ohiykrGtQ0M+uOiHGJ97pZ
         Tn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435757; x=1735040557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArUfcZBAvAGoYlUyBKoJ/IMMXIGurHTq/qsX0ml077k=;
        b=vSIGQipn/kr9VhEuKshvPrcFQBr4k4BoygUwDBAPfzqSeSsu6p5VoWf5/C8+mjYQjJ
         f+zxymMKf9KOC3OR0srBkKvDpyddzyKmzgd/rRFLSR2c40ncKpvgOuE5RaUVtYfAsuDG
         pnHi9wGH6RiDVEWu3K074Wn2Yt+gkO5mrc854u7zK6FiKL7yUAUZ/wQxcJ2GQrn2lbrI
         +nmNLx27Py20DuTZMkq9Q0BXUf39G/P1ebuIdRI5PqNuwH6HddDKX7/TDo/EGkMEeRpP
         1JWChKqd0Vs2pWs705/wPJIJsjGeZfif3DANCp0hKa5qKnfhwLWa8pPclZZ0rs76LU5G
         HP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyyfyPSNr6EhTDPw7LRFUh16nOFr0bGJY5htYw3XJJ3Vjcq+/7QkGTOmNmw+I7naYud1753DiQZDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0lrAyW+LRLB/9/jRmokcsv6YYJCasRX/tVWdIpcBWT9jloF7
	ltup64aGmaWrWN3+yOXbbVlPnTcSBHj1zKludhrNgCCB+ORl/n39Em7K5pf4E6o=
X-Gm-Gg: ASbGncsUOw/vo/8Nr15VF91SInx9boTiouPboCR1hXuKv2EIUF2PobVDpBEYz2zz+fo
	8nJraRS0A3UodAQxt1nga80+bZ0XLn/zQ7vR+sbUZbb4CBy4jXsMnYjnEQGjib0lQzQoIjC+Dxx
	XttYS8OJnZKhrRU4qaiUnizXqonk05A5WPl+3rBP1alSa1znoKoB67yZ47Cf4JGDM1HL13/o+0l
	PPlfPZZooKwuVm5jP00eZSewzD6/ZaZvWTLZEI2lMVBFq5duhVEy2jdS8jSDYORHXuEqIEIt0o2
	qVntjs4dcw==
X-Google-Smtp-Source: AGHT+IEtVQHORQkJxKFsI/43pcASHl64sFQgWIXVdwcwIcZcvMqELJ8VFE6BA/CQMfHAiBd7/n6MnA==
X-Received: by 2002:a05:6402:40cf:b0:5d0:e3fa:17ca with SMTP id 4fb4d7f45d1cf-5d63c3366b2mr14866853a12.15.1734435757344;
        Tue, 17 Dec 2024 03:42:37 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f351ddsm4362780a12.77.2024.12.17.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:42:36 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
Date: Tue, 17 Dec 2024 12:42:25 +0100
Message-ID: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=LkzV0DNqiGsjswwnEyCuMp6HwNDTTsH5J5bUCq7JnYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnYWOiY/gLL5oWBHhQSJ9dpfSPmGS1UCWX+uvq4 Yv81rQqAF6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ2FjogAKCRCPgPtYfRL+ TtKwCAC3+qL99sXvwVCUVrniqwufL1vaISysiBCgfWszu4h+RCPft51IbCLbX3OqxiBEowu0HIj 3tPDxHEz7SAcabiRnAUNUWc5WrBEt3zSsrKhTjGb4s+xtsUeYEvFiHG0zjW/+J6XVSbBMJnMWdX A4MpOjfsg2fKmVew2UJZYe3YpPrk7tQzuK6YrMhans9YYeGYfJGydN2VmxMV5lOo+cMbqJd72hf UHG84hTiZUrNNyZrZJDeE7WbH/Kq/OQoXG+2hgTlZ9Z+I5Ov0ZGNxkKhMWdYM6XhySLrmvf8gf4 PWoTnBp+QUFF8P7ET2ZQbC6hha8emVclmGlukjLTV3kK8brc
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is a 1:1 correspondance between the list of spi device-ids and the
devicetree compatibles. The latter is ordered alphabetically by vendor
and device. To simplify keeping the two lists in sync, mention the
vendor in a comment for the spi device-ids and order alphabetically,
too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/spi/spidev.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2b87b9ae56c0..58ae4304fdab 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -698,20 +698,24 @@ static const struct class spidev_class = {
 	.name = "spidev",
 };
 
+/*
+ * The spi device ids are expected to match the device names of the
+ * spidev_dt_ids array below. Both arrays are kept in the same ordering.
+ */
 static const struct spi_device_id spidev_spi_ids[] = {
-	{ .name = "bh2228fv" },
-	{ .name = "dh2228fv" },
-	{ .name = "jg10309-01" },
-	{ .name = "ltc2488" },
-	{ .name = "sx1301" },
-	{ .name = "bk4" },
-	{ .name = "bk4-spi" },
-	{ .name = "dhcom-board" },
-	{ .name = "m53cpld" },
-	{ .name = "spi-petra" },
-	{ .name = "spi-authenta" },
-	{ .name = "em3581" },
-	{ .name = "si3210" },
+	{ .name = /* cisco */ "spi-petra" },
+	{ .name = /* dh */ "dhcom-board" },
+	{ .name = /* elgin */ "jg10309-01" },
+	{ .name = /* lineartechnology */ "ltc2488" },
+	{ .name = /* lwn */ "bk4" },
+	{ .name = /* lwn */ "bk4-spi" },
+	{ .name = /* menlo */ "m53cpld" },
+	{ .name = /* micron */ "spi-authenta" },
+	{ .name = /* rohm */ "bh2228fv" },
+	{ .name = /* rohm */ "dh2228fv" },
+	{ .name = /* semtech */ "sx1301" },
+	{ .name = /* silabs */ "em3581" },
+	{ .name = /* silabs */ "si3210" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);

base-commit: fdb298fa865b0136f7be842e6c2e6310dede421a
-- 
2.45.2


