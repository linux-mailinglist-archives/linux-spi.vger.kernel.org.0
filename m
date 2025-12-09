Return-Path: <linux-spi+bounces-11833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B40CAFCD9
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D15FC302852C
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A162E612E;
	Tue,  9 Dec 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JIOrMyOf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC32EC094
	for <linux-spi@vger.kernel.org>; Tue,  9 Dec 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280493; cv=none; b=eWwOLJXyqHR0d5E6ZX+OhhhHj7VrK7ytlB6VVDaEnxGG9OpKOBTYEymB+F7kGt3nQqTcq0n8Ibo0wcfho7tqPj69QmmNhyMFvIgsGllHV1Vr5zHKfAqbcHL3BI2eX5zAzygKeMze0ACxpM0KDER7JUj5o0hwJ4xk+xuGzYDRs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280493; c=relaxed/simple;
	bh=dHhpHyfcU9fEFwxJNNEciJRyq/D4zCBHU1vVA3bGDlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3Y0znmPXp3NR0sU7oFozt6QgTGUb0AzFX0yOZiEWasLamQ0JTbhNY1Mge0BUjiFJXSUa+MlfFjprY+4Eq0R50ZIG5H2DO8xy+gXAMnSXboraglaFCi8umroJqCaXgFV4PALOAOn/M/Y+PE1DHkkPp0U4s/xJX9EIBzbst5KCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JIOrMyOf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477563e28a3so40114635e9.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Dec 2025 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765280488; x=1765885288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+4bfZ/t4/ENkJ2A9KCN8Mdc4bBDCO1QqKBV9qPPq/Q=;
        b=JIOrMyOfQlHGnYM973w8JfMAyxml/jvJVRzCVbzWd08JLj9JeCTvUUBw+VkXyDc0gu
         MWE3kySWwhXoi/RpodYP2i3OCLBdyuBCUqGrsBfykg8hVsyFvZ5uasrA4sQYmwvQ/w+F
         /4hun3bU7VC92+DVAS4aNU/8vkZTcyDTepkTtSMoQqIhLDGkSFOGaeQtkQdw3fGpXIti
         9VnP9DJtyJ9+Rt3xsprk/Sg5MQ7an7k1mtSOpInNT8xyrke8zGMq//lmBh3PTsy22EiF
         I1+fr+hYppOHn3VW0RhZlDeYQoUdj7R21R/w1lzLgmv89arKe4bag/epKgS2yWIdVQKP
         pKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765280488; x=1765885288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+4bfZ/t4/ENkJ2A9KCN8Mdc4bBDCO1QqKBV9qPPq/Q=;
        b=gTnVjsP5Uc4hxjrftEE5NYPDcpoYgpmn5JuYplEGNZmIkOZg28uGSgfZJ+qw4nb7h9
         BY3teh/UdyvfUXv4BwsornUtBF5KCpcQYxLChljvdkE4VDSDUOmu+MDKRR99AAYzk3Mo
         HaJqYCQljz+GY9Nb7jDUrmd4sZEoZRhxWb33i+YopPKb3dy3NicZIB3CBb+n0fsaXBXu
         SVU8MQ0+7WnS5y2yK1/ve5XoExYLPHkvtNS9X0Vu0hc2mxHLxxA+NTcAjua0/z2qsZ9J
         SyGjbWBiOd5S2YIZl8gM+iKd57yEXBgfLDqSE7fpLMVGEuyP1Z/1gePVeoEYpQ2xHJgR
         uWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO84en25xpW83Kpt4tvcXyc7hQ82o7Lk2qot4V53SP/ASiZnsyY+ZUaKvXJ4Ealaotzsex4q4qBg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyDEWxArNXwh+7ajlX+RD5Xi6/DDkT7qrPfInNORXUljhkaoN
	cSK+etIv2ll+iW7ALAeU7i2mAcegH34T+z466QXRtanBjMEgtrJnMqlr0izAjO8+Uzg=
X-Gm-Gg: ASbGncuvfTT4ZoAhcbySeMficUzvztqIcsHLkUIP55H5gEVzFFfHlZiN7VHrF5f6T5n
	kCZuZyYXgxmPomVW5RB9foKXaAQ3DSizfMokNwk8sY7AENQDhjhcBmFZBBrawLOE90+PIzn19gL
	nuWkgNN2hkef75/T4F8PS18T0LroNX97OIGJtpdw8zLRTxrHEnQFEuP991N6mPUFFAHvYqlXgu6
	JF4XNlMPy+Peuh5dzP02NbTE1iam45eKKS/Nru8Uodw2qkYAcP0ATo8TlT+rgmFzJruUmnPAbdO
	TyLIEp+RsM1N6RlY1PJ4/UynF5xHbBvRh2OXgRrckXw/xQqdM3OFOpyeRcXp9F/1X129V4KZomm
	7FBvQASv4DoWEZEr9TDlbQlQvegAtqNFo2g87tMBVzxIGUYoGrUGxB6JrFMt4Txiapx8DcYoEKx
	HNKCKLr9mJ01pczwWoronzvwQGXl89hMtvC4VBQurY+dKmtGfdWwm+O44mGnTM1JVOjFFQnm8tS
	cE=
X-Google-Smtp-Source: AGHT+IGXKHe4veBZ6hDBMR9TFxZYdUh5ntT4MOWKuDihIG9Z6MljyZmo6GAc9/XdLms9sUyJ5c8wsg==
X-Received: by 2002:a05:600c:888e:b0:479:3a8e:c85c with SMTP id 5b1f17b1804b1-47a7f969677mr10498795e9.18.1765280488094;
        Tue, 09 Dec 2025 03:41:28 -0800 (PST)
Received: from localhost (p200300f65f00660846b2ba6e435ad603.dip0.t-ipconnect.de. [2003:f6:5f00:6608:46b2:ba6e:435a:d603])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a7d6eb296sm34104485e9.1.2025.12.09.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 03:41:27 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] spi: fsi: Drop assigning fsi bus
Date: Tue,  9 Dec 2025 12:40:29 +0100
Message-ID:  <279e26a6740f10d119be7ea01d4af596309b3bb4.1765279318.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=dHhpHyfcU9fEFwxJNNEciJRyq/D4zCBHU1vVA3bGDlI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOAq/VmEHZ2+rH0Ld4JW6VqPHrFOtsac4G2FHq F3/b1x1QCuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTgKvwAKCRCPgPtYfRL+ TsBmB/9+vmwSapgwy4aosTlt270eN1BEiVoJZBP9VSnWe1xy/yV+p6/PEmHf60I6BK1L9VOOzIa cq6DyP5qabYozHPOByCeUNPBSH1LtNDLDyaT4IYCI/Ot+T+zTqu2QcRpBgkgaoknGKSdYAAVaWE pVfVtHxK1VE1hrkS/++IWrgYkCVl90DPOQpMtMjG9qCJi20O2EhGeufm07UHrv/WnNqElLxkjbg GYN1zb2a/zUInkcwB6wU4jHu5VDfzKjG5XVE6/Q7N9RKYGsQYSiKAE5rMVSZRWL/tyxejVO2svX 3KHc5b6fS9dc24vioIIPWlGdhuFi8zmoMf+a9hrg4wBAaqkM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Since commit FIXME ("fsi: Assign driver's bus in fsi_driver_register()")
module_fsi_driver() cares about assigning the driver's bus member. Drop
the explicit driver specific assignment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index e01c63d23b64..f9c15b99dba5 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -595,7 +595,6 @@ static struct fsi_driver fsi_spi_driver = {
 	.id_table = fsi_spi_ids,
 	.drv = {
 		.name = "spi-fsi",
-		.bus = &fsi_bus_type,
 		.probe = fsi_spi_probe,
 	},
 };
-- 
2.47.3


